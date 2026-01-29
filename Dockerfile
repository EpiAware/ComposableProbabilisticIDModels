FROM ubuntu:24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies and build tools for R package compilation
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    wget \
    gpg \
    build-essential \
    gfortran \
    liblapack-dev \
    libblas-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto (detect architecture)
ARG QUARTO_VERSION=1.6.43
RUN ARCH=$(dpkg --print-architecture) && \
    wget -qO /tmp/quarto.deb "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${ARCH}.deb" && \
    dpkg -i /tmp/quarto.deb && \
    rm /tmp/quarto.deb

# Install juliaup
RUN curl -fsSL https://install.julialang.org | sh -s -- -y
ENV PATH="/root/.juliaup/bin:${PATH}"

# Install R via r2u (prebuilt binaries for Ubuntu 24.04)
# r2u supports both amd64 and arm64 for Ubuntu 24.04 "noble"
# See: https://eddelbuettel.github.io/r2u/
RUN ARCH=$(dpkg --print-architecture) && \
    # Add r2u repository key
    wget -q -O- https://eddelbuettel.github.io/r2u/assets/dirk_eddelbuettel_key.asc \
        | tee -a /etc/apt/trusted.gpg.d/cranapt_key.asc > /dev/null && \
    # Add CRAN repository key for R itself
    wget -q -O- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
        | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc > /dev/null && \
    # Add r2u repository (architecture-aware)
    echo "deb [arch=${ARCH}] https://r2u.stat.illinois.edu/ubuntu noble main" \
        > /etc/apt/sources.list.d/cranapt.list && \
    # Add CRAN repository for R base
    echo "deb [arch=${ARCH}] https://cloud.r-project.org/bin/linux/ubuntu noble-cran40/" \
        > /etc/apt/sources.list.d/cran_r.list && \
    # Configure apt to prioritise r2u packages
    printf "Package: *\nPin: release o=CRAN-Apt Project\nPin: release l=CRAN-Apt Packages\nPin-Priority: 700\n" \
        > /etc/apt/preferences.d/99cranapt && \
    apt-get update -qq && \
    # Install R and dependencies for bspm
    apt-get install -y --no-install-recommends \
        r-base-core \
        python3-dbus \
        python3-gi \
        python3-apt && \
    rm -rf /var/lib/apt/lists/*

# Install renv, remotes, and bspm via apt for R environment management
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        r-cran-bspm \
        r-cran-renv \
        r-cran-remotes && \
    rm -rf /var/lib/apt/lists/*

# Set up bspm for seamless binary package installation (conditional to work with renv)
RUN RHOME=$(R RHOME) && \
    echo "if (requireNamespace('bspm', quietly = TRUE)) suppressMessages(bspm::enable())" \
        >> ${RHOME}/etc/Rprofile.site && \
    echo "options(bspm.version.check = FALSE)" >> ${RHOME}/etc/Rprofile.site

# Install Task (taskfile.dev)
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

# Copy project files
WORKDIR /project
COPY . .

# Use task to install Julia, instantiate packages, and install Quarto extensions
RUN task instantiate && task install-extensions

# Restore R environment
RUN task renv-restore

# Set up EpiAwareR (bypass renv autoloader to access system remotes)
RUN RENV_CONFIG_AUTOLOADER_ENABLED=FALSE Rscript -e ' \
    remotes::install_local("EpiAwareR", dependencies = FALSE, upgrade = "never"); \
    library(EpiAwareR); \
    epiaware_setup_julia() \
    '

# Declare volume for project files and outputs
VOLUME /project

# Default entrypoint
ENTRYPOINT ["task"]
CMD ["--list"]

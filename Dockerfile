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

# Install R from official CRAN repository (multi-arch support)
RUN wget -q -O- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
        | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc > /dev/null && \
    ARCH=$(dpkg --print-architecture) && \
    echo "deb [arch=${ARCH}] https://cloud.r-project.org/bin/linux/ubuntu noble-cran40/" \
        > /etc/apt/sources.list.d/cran_r.list && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        r-base \
        r-base-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
        libharfbuzz-dev \
        libfribidi-dev && \
    rm -rf /var/lib/apt/lists/*

# Install renv and remotes from CRAN
RUN Rscript -e 'install.packages(c("renv", "remotes"), repos = "https://cloud.r-project.org")'

# Install Task (taskfile.dev)
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

# Copy project files
WORKDIR /project
COPY . .

# Use task to install Julia, instantiate packages, and install Quarto extensions
RUN task instantiate && task install-extensions

# Restore R environment
RUN task renv-restore

# Set up EpiAwareR within renv environment
RUN Rscript -e ' \
    renv::install("./EpiAwareR", rebuild = FALSE); \
    library(EpiAwareR); \
    epiaware_setup_julia() \
    '

# Declare volume for project files and outputs
VOLUME /project

# Default entrypoint
ENTRYPOINT ["task"]
CMD ["--list"]

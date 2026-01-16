FROM ubuntu:24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    wget \
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

# Install Task (taskfile.dev)
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

# Copy project files
WORKDIR /project
COPY . .

# Use task to install Julia, instantiate packages, and install Quarto extensions
RUN task instantiate && task install-extensions

# Declare volume for project files and outputs
VOLUME /project

# Default entrypoint
ENTRYPOINT ["task"]
CMD ["--list"]

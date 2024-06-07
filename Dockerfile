# Use the bioconductor base image as the starting point
FROM --platform=linux/amd64 bioconductor/bioconductor_docker:devel

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    rsync

# Install Quarto CLI
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.43/quarto-1.5.43-linux-amd64.deb && \
    dpkg -i quarto-1.5.43-linux-amd64.deb && \
    rm quarto-1.5.43-linux-amd64.deb

# Install TinyTeX
RUN quarto install tinytex

# Install Python dependencies
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Set R environment variable
ENV R_PKG_DIR=${R_HOME}/site-library

# Copy and install R packages
COPY rpackages.R /rpackages.R
RUN Rscript /rpackages.R

# Download and build SQLite3 from source
RUN wget --no-check-certificate https://www.sqlite.org/2024/sqlite-autoconf-3450300.tar.gz && \
    tar -xvf sqlite-autoconf-3450300.tar.gz && \
    cd sqlite-autoconf-3450300 && \
    ./configure && \
    make && \
    make install && \
    export PATH="/usr/local/lib:$PATH" && \
    cd .. && \
    rm -rf sqlite-autoconf-3450300.tar.gz sqlite-autoconf-3450300

# Set environment variable for LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=/usr/local/lib

# Copy the project files into the Docker image 
COPY . /project

# Set the working directory
WORKDIR /project

RUN quarto render --execute --to html --output-dir build
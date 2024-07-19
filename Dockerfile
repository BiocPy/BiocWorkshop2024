# Use the bioconductor base image as the starting point
FROM --platform=linux/amd64 python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    rsync

# Install Python dependencies
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

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

EXPOSE 8889
CMD ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0", "--port=8889", "--no-browser"]
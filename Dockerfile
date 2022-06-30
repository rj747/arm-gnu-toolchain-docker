FROM ubuntu:20.04

# Use home directory for builds, be sure to have the application folder loaded here too (ie /home/app)
WORKDIR /home

# Set the time settings to prevent tzdata dialog from popping up
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

# Install build tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential git bzip2 cmake zip curl wget doxygen python3 python3-pip && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    apt-get clean

# Setup ARM GNU toolchain, rename the toolchain dir to leave out the version info in the cmake files (optional)
ARG ARM_DL_DIR_PATH=9-2020q2
ARG ARM_GNU_VER_ID=gcc-arm-none-eabi-9-2020-q2-update
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/$ARM_DL_DIR_PATH/$ARM_GNU_VER_ID-x86_64-linux.tar.bz2| tar -xj
RUN mv gcc-arm-none-eabi-9-2020-q2-update gcc-arm-none-eabi
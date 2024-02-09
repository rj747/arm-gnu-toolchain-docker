FROM ubuntu:20.04

ARG ARM_TOOLCHAIN_PATH=gcc-arm-none-eabi
ARG ARM_VERSION=13.2.rel1
ARG ARM_ARCH=x86_64

# Use home directory for builds, be sure to have the application folder loaded here too (ie /home/app)
WORKDIR /home

# Set the time settings to prevent tzdata dialog from popping up
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

# Install build tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential git bzip2 cmake zip curl wget doxygen python3 python3-pip python-is-python3 && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    apt-get clean

# Setup ARM GNU toolchain, rename the toolchain dir to leave out the version info in the cmake files (optional)
# Setup steps are referenced from https://github.com/jasonyang-ee/STM32-Dockerfile
RUN mkdir ${ARM_TOOLCHAIN_PATH}
RUN curl -L -o gcc-arm.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_VERSION}/binrel/arm-gnu-toolchain-${ARM_VERSION}-${ARM_ARCH}-arm-none-eabi.tar.xz"
RUN tar xf gcc-arm.tar.xz --strip-components=1 -C ${ARM_TOOLCHAIN_PATH}
RUN rm gcc-arm.tar.xz
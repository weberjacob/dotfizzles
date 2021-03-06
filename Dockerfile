FROM ubuntu:16.04
MAINTAINER Pete McWilliams <pmcwilliams@augustash.com>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color

# Set locale to UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen $LANG && \
  /usr/sbin/update-locale LANG=$LANG

# Install
RUN \
  apt-get -yqq update && \
  apt-get -yqq install \
    autoconf \
    build-essential \
    curl \
    git \
    python \
    python-setuptools \
    python-dev \
    sudo \
    tmux \
    vim \
    wget \
    zsh && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Change shell
ENV SHELL /bin/zsh
RUN chsh -s /bin/zsh

# Add dotfiles
WORKDIR /root
RUN mkdir -p /root/.dotfiles
COPY ./src/ /root/.dotfiles/

# Command to run
CMD [ "/bin/zsh" ]

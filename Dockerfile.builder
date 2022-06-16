FROM phusion/baseimage:focal-1.2.0

ARG OTP_VSN=24.0-1

# required packages
RUN apt-get update && apt-get install -y \
    bash \
    bash-completion \
    wget \
    git \
    make \
    gcc \
    g++ \
    vim \
    bash-completion \
    libc6-dev \
    libncurses5-dev \
    libssl-dev \
    libexpat1-dev \
    libpam0g-dev \
    unixodbc-dev \
    gnupg \
    zlib1g-dev \
    wget 

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf 
RUN chmod +x ~/.asdf/asdf.sh ~/.asdf/completions/asdf.bash
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
RUN echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc # optional
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN source ~/.bashrc; /root/.asdf/bin/asdf plugin-add erlang
RUN /root/.asdf/bin/asdf install erlang 24.3.2
RUN /root/.asdf/bin/asdf global erlang 24.3.2
COPY ./builder/build.sh /build.sh
VOLUME /builds

CMD ["/sbin/my_init"]

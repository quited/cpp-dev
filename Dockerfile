FROM phusion/baseimage:latest

CMD ["/sbin/my_init"]

# RUN curl "https://gitee.com/Fanghr/codes/hlijsbv2z710rmo9tn4d328/raw?blob_name=gistfile2.txt" > /etc/apt/sources.list

RUN apt-get -qq -y update&& apt-get -qq -y upgrade&& apt-get -qq -y install

RUN apt-get -qq -y install cmake make git xz-utils gdb gdbserver

RUN apt-get -qq clean && rm -rf /tmp/* /var/tmp/*

RUN curl "http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz" --output clang.tar.xz &&\
    tar -xf clang.tar.xz && \
    cp-r clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04/* /usr/local &&\
    rm -f clang.tar.xz&&rm -rf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04

RUN rm -rf /etc/service/sshd/down

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

COPY id_rsa.pub /tmp/id_rsa.pub

RUN cat /tmp/id_rsa.pub  >> /root/.ssh/authorized_keys && rm -rf /tmp/id_rsa.pub
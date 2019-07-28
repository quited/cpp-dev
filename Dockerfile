FROM phusion/baseimage:latest

CMD ["/sbin/my_init"]

# RUN curl "https://gitee.com/Fanghr/codes/hlijsbv2z710rmo9tn4d328/raw?blob_name=gistfile2.txt" > /etc/apt/sources.list

RUN apt -y update&& apt -y upgrade&& apt -y install

RUN apt -y install cmake make git xz-utils gdb gdbserver

RUN curl "http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz" --output clang.tar.xz &&\
    tar -C /usr/local -xf clang.tar.xz && rm -f clang.tar.xz

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -rf /etc/service/sshd/down

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

COPY id_rsa.pub /tmp/id_rsa.pub

RUN cat /tmp/id_rsa.pub  >> /root/.ssh/authorized_keys && rm -rf /tmp/id_rsa.pub
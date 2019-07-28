FROM phusion/baseimage:latest

CMD ["/sbin/my_init"]

RUN apt-get -qq update&&\
    apt-get -qq upgrade -y&&\
    apt-get -qq install -y &&\
    apt-get -qq install -y cmake make git xz-utils gdb gdbserver wget&&\
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -&&\
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main"&&\
    apt-get -qq update&&\
    apt-get -qq install -y clang-8&&\
    apt-get -qq clean && \
    rm -rf /tmp/* /var/tmp/*

RUN rm -rf /etc/service/sshd/down && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh

COPY id_rsa.pub /tmp/id_rsa.pub

RUN cat /tmp/id_rsa.pub  >> /root/.ssh/authorized_keys && rm -rf /tmp/id_rsa.pub
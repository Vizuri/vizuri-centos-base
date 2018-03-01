FROM centos:centos7
MAINTAINER Isaac Christoffersen <isaac@osshive.io>


RUN yum -y install epel-release && \
    yum -y --enablerepo="epel" update && \
    yum clean all && \
    useradd centos && \
    echo 'centos  ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    chown -R centos:centos /home/centos 

#Update Bash to 4.4.  Temporary until RPM available
RUN yum -y install wget gcc make which && \
    pushd /tmp && \
    wget http://ftp.gnu.org/gnu/bash/bash-4.4.tar.gz && \
    tar xf bash-4.4.tar.gz && \
    cd bash-4.4 && \
    ./configure && \
    make && \
    make install && \
    popd
RUN which bash && \
    bash --version && \
    yum -y remove wget gcc make which && \
    rm -rf /tmp/bash-4.4 /var/cache/yum && \
    yum clean all   

WORKDIR /home/centos
COPY configs/bashrc /home/centos/.bashrc
USER centos

ENTRYPOINT ["/usr/local/bin/bash"]

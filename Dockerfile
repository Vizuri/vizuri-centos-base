FROM centos:centos7
MAINTAINER Isaac Christoffersen <ichristoffersen@vizuri.com>


RUN yum -y update && \
    yum -y install epel-release && \
    yum clean all && \
    useradd vizuri && \
    echo 'vizuri  ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    chown -R vizuri:vizuri /home/vizuri

WORKDIR /home/vizuri
COPY configs/bashrc /home/vizuri/.bashrc
USER vizuri

ENTRYPOINT ["/bin/bash"]

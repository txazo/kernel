FROM centos:7

COPY CentOS7-Base-aliyun.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum clean all && \
    yum update -y && \
    yum clean all

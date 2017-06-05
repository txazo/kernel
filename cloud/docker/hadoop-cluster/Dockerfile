FROM centos:7

RUN yum update -y && \
    yum install -y wget && \
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo && \
    yum clean all

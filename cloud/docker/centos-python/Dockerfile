# Build Python Image

FROM centos:7

LABEL maintainer "txazo1218@163.com"

# 更新yum源
COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum clean all && \
    yum update -y && \
    yum install -y wget gcc make zip unzip zlib

wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
tar -zxvf Python-2.7.13.tgz
cd Python-2.7.13
./configure --prefix=/usr/local/python2.7 && make && make install
ln -s /usr/local/python2.7 /usr/local/python
rm -f /usr/bin/python
ln -s /usr/local/python/bin/python /usr/bin/python

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

wget https://pypi.python.org/packages/a9/23/720c7558ba6ad3e0f5ad01e0d6ea2288b486da32f053c73e259f7c392042/setuptools-36.0.1.zip

wget https://pypi.python.org/packages/11/b6/abcb525026a4be042b486df43905d6893fb04f05aac21c32c638e939e447/pip-9.0.1.tar.gz
tar -zxvf pip-9.0.1.tar.gz
cd pip-9.0.1
python setup.py install

RUN yum clean all

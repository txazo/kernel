FROM centos-yum-aliyum

RUN yum install -y wget && \
    wget --no-cookie --no-check-certificate --header "Cookie: s_cc=true;oraclelicense=accept-securebackup-cookie;gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm && \
    rpm -ivh jdk-8u131-linux-x64.rpm && \
    rm -f jdk-8u131-linux-x64.rpm

ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin

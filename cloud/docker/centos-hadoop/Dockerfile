FROM centos:7

# 更新yum源
COPY CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum clean all && \
    yum update -y && \
    yum install -y wget where applydeltarpm dracut && \
    yum clean all

# 安装ssh
RUN yum install -y openssh-server openssh-clients && \
    ssh-keygen -t rsa -P '' -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P '' -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t dsa -P '' -f /etc/ssh/ssh_host_ed25519_key && \
    sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
# ssh免密码登录
ADD id_rsa /root/.ssh
ADD id_rsa.pub /root/.ssh
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod 0600 /root/.ssh/authorized_keys

# 安装jdk
RUN wget --no-cookie --no-check-certificate --header "Cookie: s_cc=true;oraclelicense=accept-securebackup-cookie;gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm && \
    rpm -ivh jdk-8u131-linux-x64.rpm && \
    rm -f jdk-8u131-linux-x64.rpm

# 设置jdk环境变量
ENV JAVA_HOME /usr/java/default
ENV CLASSPATH .:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
ENV PATH $PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin

# RUN sed -i '/^export PATH/a export JAVA_HOME="/usr/java/default"\nexport PATH="$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin"\nexport CLASSPATH=".:$JAVA_HOME/lib:$JAVA_HOME/jre/lib"' /etc/profile && \
#     source /etc/profile

# 安装hadoop
RUN wget http://mirror.bit.edu.cn/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz && \
    tar -zxvf hadoop-2.7.3.tar.gz -C /usr/local && \
    ln -s /usr/local/hadoop-2.7.3 /usr/local/hadoop

# 设置hadoop环境变量
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# 初始化hdfs
RUN hdfs namenode -format

# hosts
RUN echo "192.168.1.100     master" >> /etc/hosts && \
    echo "192.168.1.101     slave1" >> /etc/hosts && \
    echo "192.168.1.102     slave2" >> /etc/hosts

# 启动sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# docker run -d -p 10022:22 centos-hadoop
# ssh root@192.168.99.100 -p 10022

# docker run --name master --hostname master --ip 192.168.1.100 -d -P -p 50070:50070 -p 8088:8088 centos-hadoop
# docker run --name slave1 --hostname slave1 --ip 192.168.1.101 -d -P centos-hadoop
# docker run --name slave2 --hostname slave2 --ip 192.168.1.102 -d -P centos-hadoop

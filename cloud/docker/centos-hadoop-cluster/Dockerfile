# Build Hadoop Image

FROM centos:7

LABEL maintainer "txazo1218@163.com"

# 更新yum源
COPY repo/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum clean all && \
    yum update -y && \
    yum install -y wget which

# 安装ssh
RUN yum install -y openssh-server openssh-clients && \
    ssh-keygen -t rsa -P '' -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P '' -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t dsa -P '' -f /etc/ssh/ssh_host_ed25519_key && \
    sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
    echo -e "\tStrictHostKeyChecking no" >> /etc/ssh/ssh_config

# ssh免密码登录
ADD ssh/id_rsa.pub /root/.ssh/
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys

# 安装jdk
RUN wget --no-cookie --no-check-certificate --header "Cookie: s_cc=true;oraclelicense=accept-securebackup-cookie;gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm && \
    rpm -ivh jdk-8u131-linux-x64.rpm && \
    rm -f jdk-8u131-linux-x64.rpm

# 安装hadoop
RUN wget http://mirror.bit.edu.cn/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz && \
    tar -zxvf hadoop-2.7.3.tar.gz -C /usr/local && \
    rm -f hadoop-2.7.3.tar.gz && \
    ln -s /usr/local/hadoop-2.7.3 /usr/local/hadoop

# 设置hadoop环境变量
ENV HADOOP_HOME /usr/local/hadoop

# 替换hadoop配置文件
ADD etc-hadoop/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
ADD etc-hadoop/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
ADD etc-hadoop/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
ADD etc-hadoop/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml

# 修改hadoop中JAVA_HOME
RUN sed -i '/^export JAVA_HOME.*/s//export JAVA_HOME=\/usr\/java\/default/' $HADOOP_HOME/etc/hadoop/hadoop-env.sh

# 修改path环境变量
RUN sed -i '/^export PATH/a export JAVA_HOME="/usr/java/default"\nexport CLASSPATH=".:$JAVA_HOME/lib:$JAVA_HOME/jre/lib"\nexport HADOOP_HOME="/usr/local/hadoop"\nexport PATH="$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin"' /etc/profile && \
    source /etc/profile

RUN yum clean all

# 启动sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

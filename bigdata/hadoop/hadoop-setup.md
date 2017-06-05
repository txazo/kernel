## Hadoop安装

#### 环境说明

* 系统: Mac OS X 10.10.2
* JDK: 1.8.0_131
* Hadoop: 2.7.3

#### 下载安装

下载Hadoop: [Hadoop Download](http://hadoop.apache.org/releases.html)

安装Hadoop:

```
tar -zxvf hadoop-2.7.3.tar.gz -C /usr/local
ln -s hadoop-2.7.3 hadoop
```

Hadoop安装检测:

```
cd /usr/local/hadoop
bin/hadoop
```

#### 单机

```
cd /usr/local/hadoop
mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar grep input output 'dfs[a-z.]+'
cat output/*
```

#### 伪分布式

配置SSH免密码登录:

```
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
```

修改配置文件 `etc/hadoop/core-site.xml`:

```
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

修改配置文件 `etc/hadoop/hdfs-site.xml`:

```
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
```

格式化`HDFS`:

```
bin/hdfs namenode -format
```

启动`HDFS`:

```
sbin/start-dfs.sh
```

浏览器访问`NameNode`: [http://localhost:50070/](http://localhost:50070/)

`HDFS`上创建当前用户目录:

```
bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/txazo
```

复制`etc/hadoop`目录下文件到`HDFS`上当前用户目录的`input`目录下:

```
bin/hdfs dfs -put etc/hadoop input
```

执行Hadoop任务:

```
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar grep input output 'dfs[a-z.]+'
```

查看任务执行结果:

```
bin/hdfs dfs -cat output/*
```

关闭`HDFS`:

```
sbin/stop-dfs.sh
```

#### 单机YARN配置

修改配置文件 `etc/hadoop/mapred-site.xml`:

```
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```

修改配置文件 `etc/hadoop/yarn-site.xml`:

```
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
```

启动`YARN`:

```
sbin/start-yarn.sh
```

浏览器访问`ResourceManager`: [http://localhost:8088/](http://localhost:8088/)

关闭`YARN`:

```
sbin/stop-yarn.sh
```

#### 分布式

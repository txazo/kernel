## Hadoop安装

#### 环境说明

* 系统: Mac OS
* JDK: 1.8.0_131
* Hadoop: 2.8.0

#### 下载安装

```
tar -zxvf hadoop-2.7.3.tar.gz
mv hadoop-2.7.3 /usr/local
ln -s hadoop-2.7.3 hadoop
```

安装成功检测:

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

配置文件 `etc/hadoop/core-site.xml`:

```
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

配置文件 `etc/hadoop/hdfs-site.xml`:

```
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
```

格式化`HDFS`

```
bin/hdfs namenode -format
```

启动`NameNode`和`DataNode`

```
sbin/start-dfs.sh
```

浏览器访问`NameNode`: [http://localhost:50070/](http://localhost:50070/)

#### 分布式

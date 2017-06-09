## Hive

#### 环境说明

* 系统: Mac OS X 10.10.2
* JDK: 1.8.0_131
* Hadoop: 2.7.3
* Hive: 2.1.1

#### 安装JDK和Hadoop

安装JDK和Hadoop，并配置`JAVA_HOME`和`HADOOP_HOME`环境变量

#### 下载安装Hive

下载Hive: [Hive Download](http://hive.apache.org/downloads.html)

安装Hive:

```
tar -zxvf apache-hive-2.1.1-bin.tar.gz -C /usr/local
cd /usr/local
mv apache-hive-2.1.1-bin hive-2.1.1
ln -s hive-2.1.1 hive
```

配置Hive环境变量，修改 `/etc/profile`:

```
export HIVE_HOME=/usr/local/hive
export PATH=$PATH:$HIVE_HOME/bin
```

#### 内嵌模式

```
bin/schematool -dbType derby -initSchema
```

#### 本地模式

`mysql-connector-java-x.x.x.jar`复制到`$HIVE_HOME/lib`目录下

```
bin/schematool -dbType mysql -initSchema
```

#### 远程模式

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

初始化`HDFS`:

```
cd $HADOOP_HOME
bin/hadoop fs -mkdir -p /tmp/hive
bin/hadoop fs -mkdir -p /user/hive/warehouse
bin/hadoop fs -chmod g+w /tmp/hive
bin/hadoop fs -chmod g+w /user/hive/warehouse
```

#### Hive配置

```
cd $HIVE_HOME/conf
cp hive-env.sh.template hive-env.sh
cp hive-default.xml.template hive-site.xml
cp hive-log4j2.properties.template hive-log4j2.properties
cp hive-exec-log4j2.properties.template hive-exec-log4j2.properties
```

修改 `hive-site.xml`:

```
<property>
    <name>system:java.io.tmpdir</name>
    <value>/tmp/hive/io</value>
</property>
<property>
    <name>system:user.name</name>
    <value>hive</value>
</property>
```

#### 内嵌模式

```
bin/schematool -dbType derby -initSchema
```

#### 本地模式

```
<property>
    <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:mysql://localhost:3306/hive_db?createDatabaseIfNoExist=true&amp;useSSL=true</value>
</property>
<property>
    <name>javax.jdo.option.ConnectionDriverName</name>
    <value>com.mysql.cj.jdbc.Driver</value>
</property>
<property>
    <name>javax.jdo.option.ConnectionUserName</name>
    <value>root</value>
</property>
<property>
    <name>javax.jdo.option.ConnectionPassword</name>
    <value>root</value>
</property>
```

`mysql-connector-java-x.x.x.jar`复制到`$HIVE_HOME/lib`目录下

```
bin/schematool -dbType mysql -initSchema
```

```
bin/hive
```

#### 远程模式

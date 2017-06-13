## Scala安装

下载安装Scala:

```
wget https://downloads.lightbend.com/scala/2.12.2/scala-2.12.2.tgz
tar -zxvf scala-2.12.2.tgz -C /usr/local
ln -s /usr/local/scala-2.12.2 /usr/local/scala
```

配置Scala环境变量，修改`/etc/profile`:

```
export SCALA_HOME=/usr/local/scala
export PATH=$PATH:$SCALA_HOME/bin
```

```
source /etc/profile
```

```
scala
```

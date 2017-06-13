## Spark安装

#### 环境说明

* 系统: Mac OS X 10.10.2
* JDK: 1.8.0_131
* Spark: 1.2.2

#### Spark下载安装

下载Spark: [Spark Download](http://spark.apache.org/downloads.html)

安装Spark:

```
wget https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz
tar -zxvf spark-2.1.1-bin-hadoop2.7.tgz -C /usr/local
cd /usr/local
mv spark-2.1.1-bin-hadoop2.7 spark-2.1.1-hadoop2.7
ln -s spark-2.1.1-hadoop2.7 spark
```

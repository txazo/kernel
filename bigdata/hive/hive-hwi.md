## HWI

HWI，Hive Web Interface

#### HWI安装配置

安装HWI的war包: 执行 [hive-hwi-build.sh](hive-hwi-build.sh)

copy [hive-site-hwi.xml](hive-site-hwi.xml)中的配置到 `${HIVE_HOME}/conf/hive-site.xml`

copy以下jar包到`${HIVE_HOME}/lib`目录:

* commons-el-1.0.jar
* jasper-runtime-5.5.23.jar
* jasper-compiler-5.5.23.jar
* ${JAVA_HOME}/lib/tools.jar

#### HWI启动

```
bin/hive --service hwi
```

HWI访问: [http://127.0.0.1:9999/hwi](http://127.0.0.1:9999/hwi)

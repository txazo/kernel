#### java

* 执行类: java [-options] org.apache.catalina.startup.Bootstrap [args...]
* 执行jar: java [-options] -jar sample.jar [args...]

#### -options

* -classpath(-cp): 指定类路径，:分隔
* -D<名称>=<值>: 设置系统属性
* -version: 输出产品版本并退出
* -X: 输出非标准选项的帮助

#### 入口

`hotspot/jdk/src/share/bin/main.c`

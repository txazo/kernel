## Beeline

#### 启动HiveServer2

```
$HIVE_HOME/bin/hiveserver2
```

后台运行:

```
$HIVE_HOME/bin/hive --service hiveserver2 &
```

#### 运行Beeline

```
$HIVE_HOME/bin/beeline -u jdbc:hive2://localhost:10000
```

Beeline和HiveServer2在同一个进程中运行:

```
$HIVE_HOME/bin/beeline -u jdbc:hive2://
```

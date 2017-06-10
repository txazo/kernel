## CLI

CLI，Command Line Interface

#### CLI使用

```
bin/hive
```

或

```
bin/hive --service cli
```

静默模式: `-S`，不打印日志，只输出结果

```
bin/hive -S
```

非交互模式: `-e`，执行完成后退出

```
bin/hive -e 'select * from people'
```

#### CLI命令

退出: `exit;` 或 `quit;`

清屏: `Ctrl + L` 或 `!clear;`

查看函数列表:

```
show functions
```

查看`HDFS`上文件:

```
dfs -ls /path
```

执行操作系统命令: `!` + 命令

执行sql文件:

```
source /path/test.sql
```

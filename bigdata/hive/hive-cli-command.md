## Hive CLI命令

清屏: `Ctrl + L` 或 `!clear;`

查看表列表:

```
show tables
```

查看函数列表:

```
show functions
```

查看表结构:

```
desc table_name
```

查看`HDFS`上文件:

```
dfs -ls /path
```

递归查看`HDFS`上文件:

```
dfs -ls -R /path
```

执行操作系统的命令: `!` + 命令

```
select * from test;
```

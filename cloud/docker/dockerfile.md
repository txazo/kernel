## Dockerfile

Dockerfile是一个包括所有的用来组装镜像的命令的文本文档

#### Dockerfile格式

```
# Comment
INSTRUCTION arguments
```

#### FROM

```
FROM centos:7
```

#### ENV

设置环境变量

```
ENV <key> <value>
ENV <key>=<value> ...
```

#### WORKDIR

设置工作目录

```
WORKDIR /path/to/workdir
```

#### ADD

复制文件或目录并添加到镜像的文件系统的指定路径

```
ADD <src>... <dest>
ADD ["<src>",... "<dest>"]
```

#### COPY

```
COPY <src>... <dest>
COPY ["<src>",... "<dest>"]
```

#### EXPOSE

通知Docker容器在运行时监听指定的网络端口

```
EXPOSE <port> [<port>...]
```

#### RUN

执行指令

```
RUN echo "start"
RUN ["echo", "start"]
```

#### CMD

```
CMD catalina.sh run
CMD ["catalina.sh", "run"]
```

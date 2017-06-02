## Docker命令

#### 打印Docker版本信息

```
docker --version
```

#### 列出镜像

```
docker images
docker image ls
```

#### 从仓库pull镜像

```
docker image pull NAME[:TAG|@DIGEST]
```

#### 删除镜像

```
docker image rm [OPTIONS] IMAGE [IMAGE...]
```

* `-f`: 强制删除镜像

#### 列出容器

```
docker ps
```

#### 删除容器

```
docker rm [OPTIONS] CONTAINER [CONTAINER...]
```

* `-f`: 强制kill并删除正在运行的容器

#### 获取容器日志

```
docker logs [OPTIONS] CONTAINER
```

* `-f`: 跟踪日志输出

#### 运行容器

```
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

* `-i`: 以交互模式运行，与`-t`同时使用
* `-t`: 为容器分配一个伪终端，与`-i`同时使用
* `-d`: 后台运行容器并输出容器ID
* `-p`: Docker指定映射暴露的端口
* `-P`: Docker随机映射暴露的端口

例如:

```
docker run centos:7 /bin/echo "Hello World"
docker run -i -t centos:7 /bin/bash
docker run -d centos:7 /bin/bash -c "while true; do echo hello world; sleep 1; done"
docker run -d -P friendlyhello
docker run -d -p 4000:80 friendlyhello
```

#### 停止运行的容器

```
docker stop [OPTIONS] CONTAINER [CONTAINER...]
```

* `-t`: 在kill容器之前等待容器停止的秒数，默认为10

#### 实时显示容器的资源使用统计

```
docker stats [CONTAINER...]
```

#### 从Dockerfile构建镜像

```
docker build [OPTIONS] PATH | URL | -
```

* `-t`: 指定镜像名和可选的标签

例如:

```
docker build -t friendlyhello .
```

#### 登录Docker仓库

```
docker login [OPTIONS] [SERVER]
```

* `-u`: 用户名
* `-p`: 密码

例如:

```
docker login -u username -p password hub.docker.com
```

#### 登出Docker仓库

```
docker logout [SERVER]
docker logout hub.docker.com
```

#### 创建指向源镜像的目标镜像

```
docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
```

例如:

```
docker tag friendlyhello txazo/friendlyhello:1.0
```

#### 镜像push到仓库

```
docker push [OPTIONS] NAME[:TAG]
docker push txazo/friendlyhello:1.0
```

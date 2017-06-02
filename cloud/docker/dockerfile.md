## Dockerfile

#### friendlyhello

镜像包含文件:

* [Dockerfile](dockerfile/friendlyhello/Dockerfile)
* [requirements.txt](dockerfile/friendlyhello/requirements.txt)
* [app.py](dockerfile/friendlyhello/app.py)

build镜像:

```
docker build -t friendlyhello .
```

运行镜像:

```
docker run -d -p 4000:80 friendlyhello
```

外部访问:

[http://192.168.99.100:4000](http://192.168.99.100:4000)

停止容器:

```
docker stop 4553a5b84f71
```

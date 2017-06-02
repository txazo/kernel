## Docker Hub

注册Docker账号

登陆Docker仓库:

```
docker login
```

创建一个指向源镜像的目标镜像:

```
docker tag friendlyhello txazo/friendlyhello:1.0
```

镜像push到仓库:

```
docker push txazo/friendlyhello:1.0
```

运行镜像:

```
docker run -d -p txazo/friendlyhello:1.0
```

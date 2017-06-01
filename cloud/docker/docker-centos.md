## Docker CentOS

```
docker run centos:7 /bin/echo "HelloWorld"
```

#### 交互式运行

```
docker run -i -t centos:7 /bin/bash
```

#### 后台运行

```
docker run -d centos:7 /bin/bash -c "while true; do echo hello world; sleep 1; done"
```

```
docker run -d -P training/webapp python app.py
```

```
docker run -d -p 8080:5000 training/webapp python app.py
```

# 使用官方的python运行环境作为基础镜像
FROM python:2.7-slim

# 设置工作目录
WORKDIR /app

# 复制当前目录内容到容器的/app
ADD . /app

# 执行命令
RUN pip install -r requirements.txt

# 对外开发80端口
EXPOSE 80

# 定义环境变量
ENV NAME World

# 容器启动时运行app.py
CMD ["python", "app.py"]

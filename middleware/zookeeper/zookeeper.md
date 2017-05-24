#### Zookeeper简介

分布式协调服务

#### Zookeeper应用场景

* 命名
* 配置
* 同步

#### Zookeeper节点状态(ServerState)

* LOOKING
* LEADING
* FOLLOWING
* OBSERVING

#### Zookeeper配置

参考 [zoo.cfg](zoo.cfg.md)

ServerId即${dataDir}/myid文件中的数字，同server.id保持一致

查看节点配置，`echo conf | nc localhost 2181`

#### Zookeeper启动

Main-Class: org.apache.zookeeper.server.quorum.QuorumPeerMain

#### Zookeeper节点状态检测

* `bin/zkCli.sh -server 127.0.0.1:2181`
* `echo stat | nc localhost 2181`

#### 其它四字命令(参考ServerCnxn)

* `echo cons | nc localhost 2181`: 输出节点上连接的客户端信息

#### Zookeeper数据模型

#### 数据快照

#### 事务日志

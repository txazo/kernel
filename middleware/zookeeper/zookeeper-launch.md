## Zookeeper启动

启动入口类: `org.apache.zookeeper.server.quorum.QuorumPeerMain`

#### QuorumPeerMain

* 读取并解析`zoo.cfg`配置文件
* 如果启用了自动清理功能(`autopurge.purgeInterval` > 0)，则启动自动清理任务`PurgeTask`调度
* 以集群方式启动，`QuorumPeer.start()`

#### PurgeTask

* 查找文件名中zxid最大的`snapRetainCount`个snapshot文件，即为保留的snapshot文件
* `leastZxidToBeRetain` = 上面保留的snapshot文件名中最小的zxid
* 文件过滤: log文件和snapshot文件中文件名zxid大于或等于`leastZxidToBeRetain`的文件保留，其它文件可清理
* 清理文件

#### QuorumPeer

```
public synchronized void start() {
    loadDataBase();
    cnxnFactory.start();
    startLeaderElection();
    super.start();
}
```

* `loadDataBase()`: [加载内存数据库](#加载内存数据库)
* `cnxnFactory.start()`: [NIOServerCnxnFactory](#NIOServerCnxnFactory)
* `startLeaderElection()`: [Leader选举](#Leader选举)

#### 加载内存数据库

* `ZKDatabase.loadDataBase()`
* 在`dataDir`目录中逐个处理文件名中zxid最大的snapshot文件，反序列化为`DataTree`，并通过CRC检验
* `lastProcessedZxid` = 上一步snapshot文件名的zxid
* 在`dataLogDir`目录中选取文件名zxid大于或等于`lastProcessedZxid`的log文件和zxid小于`lastProcessedZxid`的最新一个文件为待恢复的log文件
* 从待恢复的log文件中，按zxid从小到大的顺序逐行读取事务日志，直到事务的zxid不小于`lastProcessedZxid + 1`
* 继续读取事务日志，根据事务日志恢复`DataTree`，并更新`lastProcessedZxid`
* 从`lastProcessedZxid`中解析出`epoch`，校验`currentEpoch`和`acceptedEpoch`

#### NIOServerCnxnFactory

#### Leader选举

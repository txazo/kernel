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

* `loadDataBase()`:
* 

#### 加载内存数据库

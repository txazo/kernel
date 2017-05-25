#### Zookeeper简介

分布式协调服务

#### Zookeeper应用场景

* 命名
* 配置
* 同步

#### Zookeeper Server

节点状态(参考ServerState)

* LOOKING
* LEADING
* FOLLOWING
* OBSERVING

节点类型(参考LearnerType)

* PARTICIPANT: 参与选举，同步Leader数据，处理客户端读写
* OBSERVER: 不参入选举，同步Leader数据，处理客户端读写

#### Zookeeper配置

参考 [zoo.cfg](zoo.cfg.md)

`server id`: ${dataDir}/myid文件中的数字

查看节点配置: `echo conf | nc localhost 2181`

#### Zookeeper启动

Main-Class: `org.apache.zookeeper.server.quorum.QuorumPeerMain`

#### Zookeeper节点状态检测

* 客户端连接Zookeeper: `bin/zkCli.sh -server 127.0.0.1:2181`
* `echo stat | nc localhost 2181`

#### 其它四字命令(参考ServerCnxn)

* `echo cons | nc localhost 2181`: 输出节点上连接的客户端信息

#### Zookeeper内存快照文件(dataDir)

* myid
* version-2/acceptedEpoch
* version-2/currentEpoch
* snapshot.{zxid}: zxid为该文件最小的xzid

```
-rw-r--r--  1 txazo  wheel        2  5 25 16:54 acceptedEpoch
-rw-r--r--  1 txazo  wheel        2  5 25 16:54 currentEpoch
-rw-r--r--  1 txazo  wheel      296  5 23 17:55 snapshot.0
-rw-r--r--  1 txazo  wheel  9179214  5 25 16:42 snapshot.1100000013
-rw-r--r--  1 txazo  wheel  9179398  5 25 16:44 snapshot.1200000002
```

#### snapshot文件格式

log格式化输出: `java -cp /usr/local/zookeeper/zookeeper-3.4.8.jar -Djava.ext.dirs=/usr/local/zookeeper/lib org.apache.zookeeper.server.SnapshotFormatter /var/lib/zookeeper/data/server1/version-2/snapshot.1100000013`

```
FileHeader {
    int magic
    int version
    long dbid
} fileheader // 文件头
int count // session个数
{
    long id // 会话id
    int timeout // 超时时间
} session[count] // session数组
DataTree {
    int map
    {
        long long
        ACL {
            int perms
            Id {
                string scheme
                string id
            } id
        } acl[]
    } [map]
    {
        string path
        DataNode {
            byte[] data // 节点数据
            long acl
            StatPersisted {
                long czxid // 节点创建时的xzid
                long mzxid // 节点最近更新的xzid
                long ctime // 节点创建时的时间戳
                long mtime // 节点最近更新的时间戳
                int version // 节点数据更新次数
                int cversion // 子节点更新次数
                int aversion // 节点acl更新次数
                long ephemeralOwner // 临时节点的session id
                long pzxid // 子节点最近更新的xzid
            } statpersisted
        } node
    } []
} tree
```

#### Zookeeper事务日志文件(dataLogDir)

* version-2/log.{zxid}: zxid为该文件最小的xzid

```
-rw-r--r--  1 txazo  wheel  67108880  5 23 18:01 log.500000001
-rw-r--r--  1 txazo  wheel  67108880  5 24 10:56 log.500000004
-rw-r--r--  1 txazo  wheel  67108880  5 24 15:40 log.b00000001
-rw-r--r--  1 txazo  wheel  67108880  5 25 10:13 log.c00000001
-rw-r--r--  1 txazo  wheel  67108880  5 25 10:15 log.c00011629
```

#### log文件格式

log格式化输出: `java -cp /usr/local/zookeeper/zookeeper-3.4.8.jar -Djava.ext.dirs=/usr/local/zookeeper/lib org.apache.zookeeper.server.LogFormatter /var/lib/zookeeper/datalog/server1/version-2/log.f00000001`

```
FileHeader {
    int magic
    int version
    long dbid
} fileheader
{
    long crcvalue // 检验和
    TxnHeader {
        long clientId
        int cxid
        long zxid
        long time
        int type
    } hdr
    CreateSessionTxn {
        int timeOut
    } |
    CreateTxn {
        string path
        byte[] data
        ACL {
            int perms
            Id {
                string scheme
                string id
            } id
        } acl[]
        bool ephemeral
        int parentCVersion
    } |
    DeleteTxn {
        string path
    } |
    SetDataTxn {
        string path
        byte[] data
        int version
    } |
    SetACLTxn {
        string path
        ACL {
            int perms
            Id {
                string scheme
                string id
            } id
        } acl[]
        int version
    } |
    ErrorTxn {
        int err
    } txn
    byte EOR // 事务结束
} txnEntry[]
```

#### xzid

zxid: 递增的事务id

#### ACL(Access Control List)

访问控制列表

* `scheme:id`: 权限机制
    * world: `world:anyone`
    * auth
    * digest
    * ip
* `permission`: 五种权限(READ | WRITE | CREATE | DELETE | ADMIN)

#### Zookeeper数据模型

path: `/path1/path2/...`

```
DataTree {
    Map<String, DataNode> nodes // path/节点映射
    Map<Long, List<ACL>> longKeyMap // DataNode的acl/List<ACL>的映射
    Map<Long, HashSet<String>> ephemerals // session id/临时节点path集合的映射
    WatchManager dataWatches 节点数据watch
    WatchManager childWatches 子节点watch
}
DataNode {
    byte[] data // 节点数据
    long acl
    StatPersisted {
        
    } stat // 统计信息
    DataNode parent // 父节点
    Set<String> children // 子节点列表
}
WatchManager {
    HashMap<String, HashSet<Watcher>> watchTable
    HashMap<Watcher, HashSet<String>> watch2Paths
}
```

#### Zookeeper临时节点实现

#### Zookeeper顺序节点实现

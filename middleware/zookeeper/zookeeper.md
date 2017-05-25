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

#### Zookeeper内存快照文件(dataDir)

* myid
* version-2/acceptedEpoch
* version-2/currentEpoch
* snapshot.{zxid}: zxid为最小的xzid

#### snapshot文件格式

```
fileheader
    magic: 4字节, 1514885966
    version: 4字节, 2
    dbid: 8字节, -1
count: 4字节, session个数
foreach {count}:
    id: 8字节, session的id
    timeout: 4字节, session的timeout
tree
    map: 4字节
    foreach {map}:
        long: 8字节
        acls: 4字节
        foreach {acls}:
            acl
                perms:
                id
                    scheme
                    id:
    path
        len: 4字节, path长度
        value: string
    node
        data
            len: 4字节, data长度
            value: string
        acl: 8字节
        statpersisted
            czxid: 8字节
            mzxid: 8字节
            ctime: 8字节
            mtime: 8字节
            version: 4字节
            cversion: 4字节
            aversion: 4字节
            ephemeralOwner: 8字节
            pzxid: 8字节      
```

#### Zookeeper事务日志文件(dataLogDir)

* version-2/log.{zxid}: zxid为最小的xzid

```
-rw-r--r--  1 txazo  wheel  67108880  5 23 18:01 log.500000001
-rw-r--r--  1 txazo  wheel  67108880  5 24 10:56 log.500000004
-rw-r--r--  1 txazo  wheel  67108880  5 24 15:40 log.b00000001
-rw-r--r--  1 txazo  wheel  67108880  5 25 10:13 log.c00000001
-rw-r--r--  1 txazo  wheel  67108880  5 25 10:15 log.c00011629
```

#### log文件格式

log格式化输出类: `java -cp /usr/local/zookeeper/zookeeper-3.4.8.jar -Djava.ext.dirs=/usr/local/zookeeper/lib org.apache.zookeeper.server.LogFormatter /var/lib/zookeeper/datalog/server1/version-2/log.f00000001`

```
FileHeader {
    int magic
    int version
    long dbid
} fileheader
long crcvalue // 检验和
{
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
} txnEntry[]
```

#### xzid

#### Zookeeper数据模型

#### 数据快照

#### 事务日志

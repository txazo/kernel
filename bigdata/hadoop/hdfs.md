## HDFS

HDFS(Hadoop Distributed File System)，Hadoop分布式文件系统

* NameNode: 管理节点，存放文件元数据
* DataNode: 工作节点，存放数据块
* Block: HDFS中文件存储和处理的逻辑单元，默认大小64M

#### NameNode

* 文件和数据块的映射表
* 数据块和数据节点的映射表

#### DataNode

#### 数据块副本

#### 心跳检测

DataNode定期向NameNode发送心跳消息

#### 二级NameNode

SecondaryNameNode，NameNode的备份节点

#### HDFS文件读

* 客户端向NameNode发起文件读取请求
* NameNode返回给客户端文件的元数据
* 客户端，并组装

#### HDFS写文件

* 文件拆分为Block
* 客户端请求NameNode返回可用的DataNode列表
* Block写入DataNode1，DataNode1复制到DataNode2，DataNode2复制到DataNode3
* NameNode更新元数据
* 写后续Block

#### HDFS特点

* 数据冗余
* 流式的数据访问，一次写入多次读取
* 存储大文件

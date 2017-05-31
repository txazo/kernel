## Zookeeper选举

* 默认选举方案: FastLeader
* 默认选举仲裁: QuorumMaj(多于半数票就通过)

#### FastLeader选举

* 初始化`QuorumCnxManager`
* 启动`QuorumCnxManager$Listener`线程，两两节点在选举端口上建立Socket连接，并对每个节点连接启动SendWorker和RecvWorker线程
* `SendWorker`: 从消息发送队列中poll消息并发送
* `RecvWorker`: 接收消息并放入消息接收队列
* 实例化FastLeader选举算法(FastLeaderElection)
* 启动`QuorumPeer`线程，进入选举主循环
* 开启新一轮选举`FastLeaderElection.lookForLeader()`，选举次数加一，并将当前节点投票发送给其它节点
* 接收消息，更新当前节点投票，并广播节点投票，对接收到的各个节点的投票进行仲裁，通过仲裁则更新节点状态

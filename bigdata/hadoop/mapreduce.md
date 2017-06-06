## MapReduce

MapReduce过程:

[Input](#Input)  —  [Split](#Split)  —  [Map](#Map)  —  [Sort](#Sort)

(input) <k1, v1> -> map -> <k2, v2> -> combine -> <k2, v2> -> reduce -> <k3, v3> (output)

#### Input

输入数据存放在Hadoop的不同节点的HDSF上

#### Split

输入数据分片，针对每个分片创建一个map任务

#### Map

输入数据经过map处理转换为<key, value>键值对暂存在本机

#### Sort

划分等同reduce任务数的分区，对map的输出数据进行hash处理到不同的分区

#### Copy

分区中的数据拷贝给对应的reduce任务

#### Merge

reduce节点接收各个map节点copy的数据，进行排序和合并，转换为<key, list<value>>

#### Reduce

reduce处理

#### Output

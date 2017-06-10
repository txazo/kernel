## Hive DDL

#### 查看库列表

```
show databases;
show databases like '.*e';
```

#### 查看表列表

```
show tables;
show tables '.*e';
```

#### 查看创建表语句

```
show create table people;
```

#### 查看表属性

```
show tblproperties people;
```

#### 查看表字段

```
show columns in people;
```

#### 表描述

```
desc people;
```

#### 创建表

```
create table [if not exists] people (
    age int,
    name string
) partitioned by (id int);
```

复制表结构:

```
create table people_bak like people;
```

#### 删除表

```
drop table people;
```

#### 清空表

```
truncate table people;
```

#### 修改表

重命名表:

```
alter table people rename to people_new;
```

修改表字段:

```
create table people (a int, b int, c int);
alter table people change a a1 int;
alter table people change a1 a2 string after b;
alter table people change c c1 int first;
```

新增表字段:

```
alter table people add columns (data string);
```

替换表字段:

```
alter table people replace columns (data timestamp);
```

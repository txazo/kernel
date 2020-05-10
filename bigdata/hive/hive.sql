create table t1(
  id int,
  name string)
row format delimited fields terminated by ','
location '/user/hive/warehouse/t1';

create table t2 as select * from t1;

load data local inpath '/Users/txazo/test/t1.txt' into table t1;

select * from t1;

bin/hdfs dfs -text /user/hive/warehouse/t1/t1.txt

show tables;

desc t1;

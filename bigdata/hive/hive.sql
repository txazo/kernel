create table t1(
  tid int,
  tname string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/t1';

load data local inpath '/Users/txazo/test/data.txt' into table t1;

create table t2 as select * from t1;

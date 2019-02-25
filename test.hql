SET hive.auto.convert.join=true;
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions.pernode = 400;
SET hive.exec.parallel=true;

ADD JAR gs://hive-demo/udf.jar;
create database testdb;
use testdb;
show tables;
CREATE TABLE dual (x INT);
INSERT INTO dual (x) VALUES(1);

CREATE TEMPORARY FUNCTION to_json AS 'com.google.cloud.example.hive.udf.HiveOutputToJsonUDF';

CREATE TABLE struct_table (
  address STRUCT<
    nbr: INT
    ,street: STRING
    ,city: STRING
    ,state: STRING
    ,postal: INT
  >
)
PARTITIONED BY (data_date STRING)
STORED AS ORC;

CREATE TABLE json_table (
  address STRING
)
PARTITIONED BY (data_date STRING)
STORED AS ORC;

SHOW TABLES;

INSERT INTO TABLE struct_table
PARTITION (data_date)
SELECT
  NAMED_STRUCT(
    'nbr',111,
    'street','8th Ave',
    'city','New York',
    'state','NY',
    'postal',10011
  ) AS address
  ,'2019-02-25' as data_date
FROM dual
LIMIT 1;

SELECT * FROM struct_table;

INSERT INTO TABLE json_table
PARTITION (data_date)
SELECT
  '{}' AS address
  ,'2019-02-25' as data_date
FROM dual
LIMIT 1;

SELECT * FROM json_table;

INSERT OVERWRITE TABLE json_table
PARTITION (data_date)
SELECT
  to_json(address) as address
  ,data_date
FROM struct_table
LIMIT 1;

SELECT * FROM json_table;
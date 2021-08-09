--CLEANUP

drop view v_status_dio_list;
drop view v_status_sensor_list;
drop view v_list_dio_status;
drop view v_status_sensor_adjusted;
--drop view v_bias_sensor;
drop view v_name_sensor;
drop view v_name_dio;

--drop function status_dio_list_rebuild();
drop function status_dio_list_update();
drop function status_sensor_list_update();

drop rule insert_name_sensor on unit;
drop rule insert_name_dio on unit;
--drop rule insert_bias_sensor on unit;
drop rule insert_status_sensor on unit;
drop rule insert_status_dio on unit;
drop rule insert_request_dio on unit;


drop table name_dio;
drop table name_sensor;
--drop table bias_sensor;
drop table status_sensor;
drop table status_dio;
drop table request_dio;
drop table log;
drop table unit;
drop table status_dio_list;
drop table status_sensor_list;

drop type t_list_dio;
drop type t_list_sensor;



--TYPES

--t_list_dio is used in function 'rebuild_list_dio', which is called whenever the 'unit' or 'name_dio' table is updated
create type t_list_dio as (id integer, name varchar, online boolean, d00 varchar, d01 varchar, d02 varchar, d03 varchar, d04 varchar, d05 varchar, d06 varchar, d07 varchar, 
                                                                          d08 varchar, d09 varchar, d10 varchar, d11 varchar, d12 varchar, d13 varchar, d14 varchar, d15 varchar,
                                                                          d16 varchar, d17 varchar, d18 varchar, d19 varchar, d20 varchar, d21 varchar, d22 varchar, d23 varchar,
                                                                          d24 varchar, d25 varchar, d26 varchar, d27 varchar, d28 varchar, d29 varchar, d30 varchar, d31 varchar,
                                                                          d32 varchar, d33 varchar, d34 varchar, d35 varchar, d36 varchar, d37 varchar, d38 varchar, d39 varchar,
                                                                          d40 varchar, d41 varchar, d42 varchar, d43 varchar, d44 varchar, d45 varchar, d46 varchar, d47 varchar,
                                                                          d48 varchar, d49 varchar, d50 varchar, d51 varchar, d52 varchar, d53 varchar);
--same as above except for sensors instead of DIO points
create type t_list_sensor as (id integer, name varchar, online boolean, a00 varchar, a01 varchar, a02 varchar, a03 varchar, a04 varchar, a05 varchar, a06 varchar, a07 varchar,
                                                                             a08 varchar, a09 varchar, a10 varchar, a11 varchar, a12 varchar, a13 varchar, a14 varchar, a15 varchar,
                                                                             i00 varchar, i01 varchar, i02 varchar);



--TABLES

create table unit (id integer primary key, address varchar, ain_active char(16), dio_mode char(54), dio_init char(54), online boolean, online_offline timestamp, updated timestamp, name varchar unique, misc varchar);
alter table unit owner to controller;
grant all on unit to controller;

--create table bias_sensor (address varchar references unit(address) primary key, a00 varchar, a01 varchar, a02 varchar, a03 varchar, a04 varchar, a05 varchar, a06 varchar, a07 varchar,
--                                                                                a08 varchar, a09 varchar, a10 varchar, a11 varchar, a12 varchar, a13 varchar, a14 varchar, a15 varchar,
--                                                                                i00 varchar, i01 varchar, i02 varchar);
--alter table bias_sensor owner to controller;
--grant all on bias_sensor to controller;

create table	status_sensor (unit integer references unit(id) primary key, a00 float, a01 float, a02 float, a03 float, a04 float, a05 float, a06 float, a07 float,
                                                                                     a08 float, a09 float, a10 float, a11 float, a12 float, a13 float, a14 float, a15 float,
                                                                                     i00 float, i01 float, i02 float, changed timestamp, updated timestamp);
alter table status_sensor owner to controller;
grant all on status_sensor to controller;


create table	status_dio (unit integer references unit(id) primary key, d00 boolean, d01 boolean, d02 boolean, d03 boolean, d04 boolean, d05 boolean, d06 boolean, d07 boolean,
                                                                                  d08 boolean, d09 boolean, d10 boolean, d11 boolean, d12 boolean, d13 boolean, d14 boolean, d15 boolean,
                                                                                  d16 boolean, d17 boolean, d18 boolean, d19 boolean, d20 boolean, d21 boolean, d22 boolean, d23 boolean,
                                                                                  d24 boolean, d25 boolean, d26 boolean, d27 boolean, d28 boolean, d29 boolean, d30 boolean, d31 boolean,
                                                                                  d32 boolean, d33 boolean, d34 boolean, d35 boolean, d36 boolean, d37 boolean, d38 boolean, d39 boolean,
                                                                                  d40 boolean, d41 boolean, d42 boolean, d43 boolean, d44 boolean, d45 boolean, d46 boolean, d47 boolean,
                                                                                  d48 boolean, d49 boolean, d50 boolean, d51 boolean, d52 boolean, d53 boolean,                                                                                  
                                                                                  changed timestamp, updated timestamp);
alter table status_dio owner to controller;
grant all on status_dio to controller;

create table request_dio  (unit integer references unit(id) primary key,  d00 boolean, d01 boolean, d02 boolean, d03 boolean, d04 boolean, d05 boolean, d06 boolean, d07 boolean,
                                                                                  d08 boolean, d09 boolean, d10 boolean, d11 boolean, d12 boolean, d13 boolean, d14 boolean, d15 boolean,
                                                                                  d16 boolean, d17 boolean, d18 boolean, d19 boolean, d20 boolean, d21 boolean, d22 boolean, d23 boolean,
                                                                                  d24 boolean, d25 boolean, d26 boolean, d27 boolean, d28 boolean, d29 boolean, d30 boolean, d31 boolean,
                                                                                  d32 boolean, d33 boolean, d34 boolean, d35 boolean, d36 boolean, d37 boolean, d38 boolean, d39 boolean,
                                                                                  d40 boolean, d41 boolean, d42 boolean, d43 boolean, d44 boolean, d45 boolean, d46 boolean, d47 boolean,
                                                                                  d48 boolean, d49 boolean, d50 boolean, d51 boolean, d52 boolean, d53 boolean,
                                                                                  updated timestamp);
alter table request_dio owner to controller;
grant all on request_dio to controller;


create table name_dio  (unit integer references unit(id) primary key,     d00 varchar, d01 varchar, d02 varchar, d03 varchar, d04 varchar, d05 varchar, d06 varchar, d07 varchar,
                                                                                  d08 varchar, d09 varchar, d10 varchar, d11 varchar, d12 varchar, d13 varchar, d14 varchar, d15 varchar,
                                                                                  d16 varchar, d17 varchar, d18 varchar, d19 varchar, d20 varchar, d21 varchar, d22 varchar, d23 varchar,
                                                                                  d24 varchar, d25 varchar, d26 varchar, d27 varchar, d28 varchar, d29 varchar, d30 varchar, d31 varchar,
                                                                                  d32 varchar, d33 varchar, d34 varchar, d35 varchar, d36 varchar, d37 varchar, d38 varchar, d39 varchar,
                                                                                  d40 varchar, d41 varchar, d42 varchar, d43 varchar, d44 varchar, d45 varchar, d46 varchar, d47 varchar,
                                                                                  d48 varchar, d49 varchar, d50 varchar, d51 varchar, d52 varchar, d53 varchar);
grant all on name_dio to controller;

create table name_sensor  (unit integer references unit(id) primary key,  a00 varchar, a01 varchar, a02 varchar, a03 varchar, a04 varchar, a05 varchar, a06 varchar, a07 varchar,
                                                                                  a08 varchar, a09 varchar, a10 varchar, a11 varchar, a12 varchar, a13 varchar, a14 varchar, a15 varchar,
                                                                                  i00 varchar, i01 varchar, i02 varchar);
alter table name_sensor owner to controller;
grant all on name_sensor to controller;

create table status_dio_list (unit integer, name varchar, online boolean, dio varchar, description varchar, status boolean);
alter table status_dio_list owner to controller;
grant all on status_dio_list to controller;

create table status_sensor_list (unit integer, name varchar, online boolean, sensor varchar, description varchar, status float);
alter table status_sensor_list owner to controller;
grant all on status_sensor_list to controller;

create table log (event serial primary key, description varchar, updated timestamp);
alter table log owner to controller;
grant all on log to controller;


--RULES

--create rule insert_bias_sensor as on insert to unit
--  do (insert into bias_sensor (address, a00, a01, a02, a03, a04, a05, a06, a07,
--                                        a08, a09, a10, a11, a12, a13, a14, a15,
--                                        i00, i01, i02) values
--                              (new.address, '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0',
--                                            '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0',
--                                            '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0', '0.0:0.0:0.0:0.0:1.0:0.0'));

create rule insert_status_sensor as on insert to unit
  do (insert into status_sensor (unit, a00, a01, a02, a03, a04, a05, a06, a07,
                                          a08, a09, a10, a11, a12, a13, a14, a15,
                                          i00, i01, i02,
                                          changed, updated) values 
                                (new.id, '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0',
                                              '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0',
                                              '0.0', '0.0', '0.0',
                                              now(), now()));

create rule insert_status_dio as on insert to unit
  do (insert into status_dio (unit, 	d00, d01, d02, d03, d04, d05, d06, d07, 
                                        d08, d09, d10, d11, d12, d13, d14, d15,
                                        d16, d17, d18, d19, d20, d21, d22, d23,
                                        d24, d25, d26, d27, d28, d29, d30, d31,
                                        d32, d33, d34, d35, d36, d37, d38, d39,
                                        d40, d41, d42, d43, d44, d45, d46, d47,
                                        d48, d49, d50, d51, d52, d53,
                                        changed, updated) values 
                             (new.id, 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f',
                                           now(), now()));

create rule insert_request_dio as on insert to unit
  do (insert into request_dio (unit, d00, d01, d02, d03, d04, d05, d06, d07, 
                                        d08, d09, d10, d11, d12, d13, d14, d15,
                                        d16, d17, d18, d19, d20, d21, d22, d23,
                                        d24, d25, d26, d27, d28, d29, d30, d31,
                                        d32, d33, d34, d35, d36, d37, d38, d39,
                                        d40, d41, d42, d43, d44, d45, d46, d47,
                                        d48, d49, d50, d51, d52, d53,
                                        updated) values 
                             (new.id, 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f',
                                           'f', 'f', 'f', 'f', 'f', 'f',
                                           now()));

create rule insert_name_dio as on insert to unit
  do (insert into name_dio (unit, 	d00, d01, d02, d03, d04, d05, d06, d07, 
                                        d08, d09, d10, d11, d12, d13, d14, d15,
                                        d16, d17, d18, d19, d20, d21, d22, d23,
                                        d24, d25, d26, d27, d28, d29, d30, d31,
                                        d32, d33, d34, d35, d36, d37, d38, d39,
                                        d40, d41, d42, d43, d44, d45, d46, d47,
                                        d48, d49, d50, d51, d52, d53) values 
                             (new.id, 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable',
                                           'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable',
                                           'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable',
                                           'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable',
                                           'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable',
                                           'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable',
                                           'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable'));

create rule insert_name_sensor as on insert to unit
  do (insert into name_sensor (unit, a00, a01, a02, a03, a04, a05, a06, a07,
                                        a08, a09, a10, a11, a12, a13, a14, a15,
                                        i00, i01, i02) values
                              (new.id, 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable',
                                            'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 
                                            'unavailable', 'unavailable', 'unavailable'));


insert into log (description) values ('database initiation');


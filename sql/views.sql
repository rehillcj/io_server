--CLEANUP

drop view v_status_sensor_adjusted;
drop view v_bias_sensor;
drop view v_name_sensor;
drop view v_name_dio;
drop view v_status_sensor_list;
drop view v_status_dio_list;
drop view v_status_sensor;

--VIEWS

--create view v_status_sensor_adjusted as
--  select unit.address, unit.name, unit.updated,
--        (cast (split_part(bias_sensor.i00, ':', 1) as float) * power(status_sensor.i00, 5) +
--         cast (split_part(bias_sensor.i00, ':', 2) as float) * power(status_sensor.i00, 4) +
--         cast (split_part(bias_sensor.i00, ':', 3) as float) * power(status_sensor.i00, 3) +
--         cast (split_part(bias_sensor.i00, ':', 4) as float) * power(status_sensor.i00, 2) +
--         cast (split_part(bias_sensor.i00, ':', 5) as float) * power(status_sensor.i00, 1) +
--         cast (split_part(bias_sensor.i00, ':', 6) as float)) as i00,
--repeat this block for i01, i02, and a00-a15

--  from unit, status_sensor, bias_sensor
--  where status_sensor.address = unit.address
--  and bias_sensor.address = unit.address
--  ----and unit.online = 't'
--  order by unit.address;
--alter view v_status_sensor_adjusted owner to controller;
--grant all on v_status_sensor_adjusted to controller;

--create view v_bias_sensor as
--  select  unit.address, unit.name,  bias_sensor.a00, bias_sensor.a01, bias_sensor.a02, bias_sensor.a03, bias_sensor.a04, bias_sensor.a05, bias_sensor.a06, bias_sensor.a07,
--                                    bias_sensor.a08, bias_sensor.a09, bias_sensor.a10, bias_sensor.a11, bias_sensor.a12, bias_sensor.a13, bias_sensor.a14, bias_sensor.a15,
--                                    bias_sensor.i00, bias_sensor.i01, bias_sensor.i02
--  from	  unit, bias_sensor
--  where	  unit.address = bias_sensor.address
--  order by unit.address;
--alter view v_bias_sensor owner to controller;
--grant all on v_bias_sensor to controller;

create view v_name_sensor as
  select  unit.id, unit.name, name_sensor.a00, name_sensor.a01, name_sensor.a02, name_sensor.a03, name_sensor.a04, name_sensor.a05, name_sensor.a06, name_sensor.a07,
                              name_sensor.a08, name_sensor.a09, name_sensor.a10, name_sensor.a11, name_sensor.a12, name_sensor.a13, name_sensor.a14, name_sensor.a15,
                              name_sensor.i00, name_sensor.i01, name_sensor.i02
  from	  unit, name_sensor
  where	  unit.id = name_sensor.unit
  order by unit.id;
alter view v_name_sensor owner to controller;
grant all on v_name_sensor to controller;

create view v_name_dio as
  select  unit.id, unit.name, name_dio.d00, name_dio.d01, name_dio.d02, name_dio.d03, name_dio.d04, name_dio.d05, name_dio.d06, name_dio.d07,
                              name_dio.d08, name_dio.d09, name_dio.d10, name_dio.d11, name_dio.d12, name_dio.d13, name_dio.d14, name_dio.d15,
                              name_dio.d16, name_dio.d17, name_dio.d18, name_dio.d19, name_dio.d20, name_dio.d21, name_dio.d22, name_dio.d23,
                              name_dio.d24, name_dio.d25, name_dio.d26, name_dio.d27, name_dio.d28, name_dio.d29, name_dio.d30, name_dio.d31,
                              name_dio.d32, name_dio.d33, name_dio.d34, name_dio.d35, name_dio.d36, name_dio.d37, name_dio.d38, name_dio.d39,
                              name_dio.d40, name_dio.d41, name_dio.d42, name_dio.d43, name_dio.d44, name_dio.d45, name_dio.d46, name_dio.d47,
                              name_dio.d48, name_dio.d49, name_dio.d50, name_dio.d51, name_dio.d52, name_dio.d53
  from	  unit, name_dio
  where	  unit.id = name_dio.unit
  --and	  unit.dio_enabled = true
  order by unit.id;
alter view v_name_dio owner to controller;
grant all on v_name_dio to controller;

create view v_status_dio_list as
  select * from status_dio_list_update();
alter view v_status_dio_list owner to controller;
grant all on v_status_dio_list to controller;

create view v_status_sensor_list as
  select * from status_sensor_list_update();
alter view v_status_sensor_list owner to controller;
grant all on v_status_sensor_list to controller;

create view v_status_sensor as
  select unit.id, unit.name, unit.address, status_sensor.a00, status_sensor.i00, status_sensor.i01, status_sensor.i02, status_sensor.updated
  from	unit, status_sensor
  where unit.id = status_sensor.unit
--  and	unit.online = 't'
  order by unit.id;
alter view v_status_sensor owner to controller;
grant all on v_status_sensor to controller;



drop view v_status_sensor_adjusted;
drop view v_bias_sensor;
drop view v_name_sensor;
drop view v_name_dio;
drop view v_status_dio_list;
drop view v_status_sensor_list;
drop view v_sensors_adjusted;
drop view v_sensors_raw;
drop view v_active_status_adjusted;


drop rule insert_name_sensor on unit;
drop rule insert_name_dio on unit;
drop rule insert_bias_sensor on unit;
drop rule insert_status_sensor on unit;
drop rule insert_status_dio on unit;
drop rule insert_request_dio on unit;
drop rule insert_status_analog_adjusted on unit;
drop rule insert_status_analog_raw on unit;
drop rule insert_status_i2c_adjusted on unit;
drop rule insert_status_i2c_raw on unit;
drop rule insert_bias_analog on unit;
drop rule insert_bias_i2c on unit;

drop trigger update_unit on unit;
drop trigger update_request_dio on request_dio;
drop trigger update_status_dio on status_dio;
drop trigger update_status_sensor on status_sensor;
drop trigger insert_log on log;
drop trigger status_dio_list_from_name_dio on name_dio;
drop trigger status_dio_list_from_unit on unit;
drop trigger status_sensor_list_from_name_sensor on name_sensor;
drop trigger status_sensor_list_from_unit on unit;

drop function status_dio_list_rebuild();
drop function status_dio_list_update();
drop function status_sensor_list_rebuild();
drop function status_sensor_list_update();
drop function unit_get_address_from_name(varchar);
drop function update_unit();
drop function update_request_dio();
drop function update_status_dio();
drop function update_status_sensor();
drop function insert_log();



drop table status_sensor_list;
drop table status_dio_list;
drop table name_dio;
drop table name_sensor;
drop table bias_sensor;
drop table status_sensor;
drop table status_dio;
drop table request_dio;
drop table log;
drop table status_analog_adjusted;
drop table status_analog_raw;
drop table status_i2c_adjusted;
drop table status_i2c_raw;
drop table bias_analog;
drop table bias_i2c;
drop table unit;

drop type t_list_dio;
drop type t_list_sensor;

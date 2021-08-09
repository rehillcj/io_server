--CLEANUP


drop view v_status_dio_list;
drop view v_status_sensor_list;

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



--FUNCTIONS
create function status_dio_list_rebuild() returns trigger as $status_dio_list_rebuild$
declare
  r t_list_dio;
begin
  delete from status_dio_list;
  for r in select unit.id, unit.name, unit.online,  name_dio.d00, name_dio.d01, name_dio.d02, name_dio.d03, name_dio.d04, name_dio.d05, name_dio.d06, name_dio.d07,
                                                    name_dio.d08, name_dio.d09, name_dio.d10, name_dio.d11, name_dio.d12, name_dio.d13, name_dio.d14, name_dio.d15,
                                                    name_dio.d16, name_dio.d17, name_dio.d18, name_dio.d19, name_dio.d20, name_dio.d21, name_dio.d22, name_dio.d23,
                                                    name_dio.d24, name_dio.d25, name_dio.d26, name_dio.d27, name_dio.d28, name_dio.d29, name_dio.d30, name_dio.d31,
                                                    name_dio.d32, name_dio.d33, name_dio.d34, name_dio.d35, name_dio.d36, name_dio.d37, name_dio.d38, name_dio.d39,
                                                    name_dio.d40, name_dio.d41, name_dio.d42, name_dio.d43, name_dio.d44, name_dio.d45, name_dio.d46, name_dio.d47,
                                                    name_dio.d48, name_dio.d49, name_dio.d50, name_dio.d51, name_dio.d52, name_dio.d53
    from        unit, name_dio
    where       unit.id = name_dio.unit
    and         unit.dio_mode <> 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
  loop
    if ((r.d00 <> 'unset') and (r.d00 <> 'n/a') and (r.d00 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd00', r.d00); end if;
    if ((r.d01 <> 'unset') and (r.d01 <> 'n/a') and (r.d01 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd01', r.d01); end if;
    if ((r.d02 <> 'unset') and (r.d02 <> 'n/a') and (r.d02 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd02', r.d02); end if;
    if ((r.d03 <> 'unset') and (r.d03 <> 'n/a') and (r.d03 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd03', r.d03); end if;
    if ((r.d04 <> 'unset') and (r.d04 <> 'n/a') and (r.d04 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd04', r.d04); end if;
    if ((r.d05 <> 'unset') and (r.d05 <> 'n/a') and (r.d05 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd05', r.d05); end if;
    if ((r.d06 <> 'unset') and (r.d06 <> 'n/a') and (r.d06 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd06', r.d06); end if;
    if ((r.d07 <> 'unset') and (r.d07 <> 'n/a') and (r.d07 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd07', r.d07); end if;
    if ((r.d08 <> 'unset') and (r.d08 <> 'n/a') and (r.d08 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd08', r.d08); end if;
    if ((r.d09 <> 'unset') and (r.d09 <> 'n/a') and (r.d09 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd09', r.d09); end if;
    if ((r.d10 <> 'unset') and (r.d00 <> 'n/a') and (r.d10 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd10', r.d10); end if;
    if ((r.d11 <> 'unset') and (r.d11 <> 'n/a') and (r.d11 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd11', r.d11); end if;
    if ((r.d12 <> 'unset') and (r.d12 <> 'n/a') and (r.d12 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd12', r.d12); end if;
    if ((r.d13 <> 'unset') and (r.d13 <> 'n/a') and (r.d13 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd13', r.d13); end if;
    if ((r.d14 <> 'unset') and (r.d14 <> 'n/a') and (r.d14 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd14', r.d14); end if;
    if ((r.d15 <> 'unset') and (r.d15 <> 'n/a') and (r.d15 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd15', r.d15); end if;
    if ((r.d16 <> 'unset') and (r.d16 <> 'n/a') and (r.d16 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd16', r.d16); end if;
    if ((r.d17 <> 'unset') and (r.d17 <> 'n/a') and (r.d17 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd17', r.d17); end if;
    if ((r.d18 <> 'unset') and (r.d18 <> 'n/a') and (r.d18 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd18', r.d18); end if;
    if ((r.d19 <> 'unset') and (r.d19 <> 'n/a') and (r.d19 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd19', r.d19); end if;
    if ((r.d20 <> 'unset') and (r.d20 <> 'n/a') and (r.d20 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd20', r.d20); end if;
    if ((r.d21 <> 'unset') and (r.d21 <> 'n/a') and (r.d21 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd21', r.d21); end if;
    if ((r.d22 <> 'unset') and (r.d22 <> 'n/a') and (r.d22 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd22', r.d22); end if;
    if ((r.d23 <> 'unset') and (r.d23 <> 'n/a') and (r.d23 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd23', r.d23); end if;
    if ((r.d24 <> 'unset') and (r.d24 <> 'n/a') and (r.d24 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd24', r.d24); end if;
    if ((r.d25 <> 'unset') and (r.d25 <> 'n/a') and (r.d25 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd25', r.d25); end if;
    if ((r.d26 <> 'unset') and (r.d26 <> 'n/a') and (r.d26 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd26', r.d26); end if;
    if ((r.d27 <> 'unset') and (r.d27 <> 'n/a') and (r.d27 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd27', r.d27); end if;
    if ((r.d28 <> 'unset') and (r.d28 <> 'n/a') and (r.d28 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd28', r.d28); end if;
    if ((r.d29 <> 'unset') and (r.d29 <> 'n/a') and (r.d29 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd29', r.d29); end if;
    if ((r.d30 <> 'unset') and (r.d30 <> 'n/a') and (r.d30 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd30', r.d30); end if;
    if ((r.d31 <> 'unset') and (r.d31 <> 'n/a') and (r.d31 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd31', r.d31); end if;
    if ((r.d32 <> 'unset') and (r.d32 <> 'n/a') and (r.d32 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd32', r.d32); end if;
    if ((r.d33 <> 'unset') and (r.d33 <> 'n/a') and (r.d33 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd33', r.d33); end if;
    if ((r.d34 <> 'unset') and (r.d34 <> 'n/a') and (r.d34 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd34', r.d34); end if;
    if ((r.d35 <> 'unset') and (r.d35 <> 'n/a') and (r.d35 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd35', r.d35); end if;
    if ((r.d36 <> 'unset') and (r.d36 <> 'n/a') and (r.d36 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd36', r.d36); end if;
    if ((r.d37 <> 'unset') and (r.d37 <> 'n/a') and (r.d37 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd37', r.d37); end if;
    if ((r.d38 <> 'unset') and (r.d38 <> 'n/a') and (r.d38 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd38', r.d38); end if;
    if ((r.d39 <> 'unset') and (r.d39 <> 'n/a') and (r.d39 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd39', r.d39); end if;
    if ((r.d40 <> 'unset') and (r.d40 <> 'n/a') and (r.d40 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd40', r.d40); end if;
    if ((r.d41 <> 'unset') and (r.d41 <> 'n/a') and (r.d41 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd41', r.d41); end if;
    if ((r.d42 <> 'unset') and (r.d42 <> 'n/a') and (r.d42 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd42', r.d42); end if;
    if ((r.d43 <> 'unset') and (r.d43 <> 'n/a') and (r.d43 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd43', r.d43); end if;
    if ((r.d44 <> 'unset') and (r.d44 <> 'n/a') and (r.d44 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd44', r.d44); end if;
    if ((r.d45 <> 'unset') and (r.d45 <> 'n/a') and (r.d45 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd45', r.d45); end if;
    if ((r.d46 <> 'unset') and (r.d46 <> 'n/a') and (r.d46 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd46', r.d46); end if;
    if ((r.d47 <> 'unset') and (r.d47 <> 'n/a') and (r.d47 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd47', r.d47); end if;
    if ((r.d48 <> 'unset') and (r.d48 <> 'n/a') and (r.d48 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd48', r.d48); end if;
    if ((r.d49 <> 'unset') and (r.d49 <> 'n/a') and (r.d49 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd49', r.d49); end if;
    if ((r.d50 <> 'unset') and (r.d50 <> 'n/a') and (r.d50 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd50', r.d50); end if;
    if ((r.d51 <> 'unset') and (r.d51 <> 'n/a') and (r.d51 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd51', r.d51); end if;
    if ((r.d52 <> 'unset') and (r.d52 <> 'n/a') and (r.d52 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd52', r.d52); end if;
    if ((r.d53 <> 'unset') and (r.d53 <> 'n/a') and (r.d53 <> 'unavailable')) then insert into status_dio_list (unit, name, online, dio, description) values (r.id, r.name, r.online, 'd53', r.d53); end if;
  end loop;
  return new;
end
$status_dio_list_rebuild$ language plpgsql;
alter function status_dio_list_rebuild() owner to controller;

create function status_dio_list_update() returns setof status_dio_list  as $status_dio_list_update$
declare
 r status_dio_list%rowtype;
--temp boolean;
begin
  for r in select * from status_dio_list
  loop
    if (r.dio = 'd00') then select d00 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd01') then select d01 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd02') then select d02 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd03') then select d03 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd04') then select d04 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd05') then select d05 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd06') then select d06 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd07') then select d07 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd08') then select d08 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd09') then select d09 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd10') then select d10 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd11') then select d11 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd12') then select d12 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd13') then select d13 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd14') then select d14 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd15') then select d15 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd16') then select d16 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd17') then select d17 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd18') then select d18 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd19') then select d19 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd20') then select d20 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd21') then select d21 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd22') then select d22 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd23') then select d23 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd24') then select d24 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd25') then select d25 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd26') then select d26 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd27') then select d27 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd28') then select d28 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd29') then select d29 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd30') then select d30 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd31') then select d31 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd32') then select d32 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd33') then select d33 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd34') then select d34 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd35') then select d35 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd36') then select d36 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd37') then select d37 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd38') then select d38 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd39') then select d39 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd40') then select d40 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd41') then select d41 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd42') then select d42 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd43') then select d43 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd44') then select d44 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd45') then select d45 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd46') then select d46 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd47') then select d47 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd48') then select d48 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd49') then select d49 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd50') then select d50 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd51') then select d51 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd52') then select d52 into r.status from status_dio where unit = r.unit; end if;
    if (r.dio = 'd53') then select d53 into r.status from status_dio where unit = r.unit; end if;
    return next r; 
  end loop;
  return;
end;
$status_dio_list_update$ language plpgsql;
alter function status_dio_list_update() owner to controller;


create function status_sensor_list_rebuild() returns trigger as $status_sensor_list_rebuild$
declare
  r t_list_sensor;
begin
  delete from status_sensor_list;
  for r in select unit.id, unit.name, unit.online, name_sensor.a00, name_sensor.a01, name_sensor.a02, name_sensor.a03, name_sensor.a04, name_sensor.a05, name_sensor.a06, name_sensor.a07,
                                                   name_sensor.a08, name_sensor.a09, name_sensor.a10, name_sensor.a11, name_sensor.a12, name_sensor.a13, name_sensor.a14, name_sensor.a15,
                                                   name_sensor.i00, name_sensor.i01, name_sensor.i02
    from 	unit, name_sensor
    where       unit.id = name_sensor.unit
  loop
    if ((r.a00 <> 'unset') and (r.a00 <> 'n/a') and (r.a00 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a00', r.a00); end if;
    if ((r.a01 <> 'unset') and (r.a01 <> 'n/a') and (r.a01 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a01', r.a01); end if;
    if ((r.a02 <> 'unset') and (r.a02 <> 'n/a') and (r.a02 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a02', r.a02); end if;
    if ((r.a03 <> 'unset') and (r.a03 <> 'n/a') and (r.a03 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a03', r.a03); end if;
    if ((r.a04 <> 'unset') and (r.a04 <> 'n/a') and (r.a04 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a04', r.a04); end if;
    if ((r.a05 <> 'unset') and (r.a05 <> 'n/a') and (r.a05 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a05', r.a05); end if;
    if ((r.a06 <> 'unset') and (r.a06 <> 'n/a') and (r.a06 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a06', r.a06); end if;
    if ((r.a07 <> 'unset') and (r.a07 <> 'n/a') and (r.a07 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a07', r.a07); end if;
    if ((r.a08 <> 'unset') and (r.a08 <> 'n/a') and (r.a08 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a08', r.a08); end if;
    if ((r.a09 <> 'unset') and (r.a09 <> 'n/a') and (r.a09 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a09', r.a09); end if;
    if ((r.a10 <> 'unset') and (r.a10 <> 'n/a') and (r.a10 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a10', r.a10); end if;
    if ((r.a11 <> 'unset') and (r.a11 <> 'n/a') and (r.a11 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a11', r.a11); end if;
    if ((r.a12 <> 'unset') and (r.a12 <> 'n/a') and (r.a12 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a12', r.a12); end if;
    if ((r.a13 <> 'unset') and (r.a13 <> 'n/a') and (r.a13 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a13', r.a13); end if;
    if ((r.a14 <> 'unset') and (r.a14 <> 'n/a') and (r.a14 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a14', r.a14); end if;
    if ((r.a15 <> 'unset') and (r.a15 <> 'n/a') and (r.a15 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'a15', r.a15); end if;

    if ((r.i00 <> 'unset') and (r.i00 <> 'n/a') and (r.i00 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'i00', r.i00); end if;
    if ((r.i01 <> 'unset') and (r.i01 <> 'n/a') and (r.i01 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'i01', r.i01); end if;
    if ((r.i02 <> 'unset') and (r.i02 <> 'n/a') and (r.i02 <> 'unavailable')) then insert into status_sensor_list (unit, name, online, sensor, description) values (r.id, r.name, r.online, 'i02', r.i02); end if;
  end loop;
  return new;
end
$status_sensor_list_rebuild$ language plpgsql;
alter function status_sensor_list_rebuild() owner to controller;

create function status_sensor_list_update() returns setof status_sensor_list as $status_sensor_list_update$
declare
 r status_sensor_list%rowtype;
begin
  for r in select * from status_sensor_list
  loop
    if (r.sensor = 'a00') then
      select a00 into r.status from status_sensor where unit = r.unit;
      select a00 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a01') then
      select a01 into r.status from status_sensor where unit = r.unit;
      select a01 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a02') then
      select a02 into r.status from status_sensor where unit = r.unit;
      select a02 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a03') then
      select a03 into r.status from status_sensor where unit = r.unit;
      select a03 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a04') then
      select a04 into r.status from status_sensor where unit = r.unit;
      select a04 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a05') then
      select a05 into r.status from status_sensor where unit = r.unit;
      select a05 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a06') then
      select a06 into r.status from status_sensor where unit = r.unit;
      select a06 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a07') then
      select a07 into r.status from status_sensor where unit = r.unit;
      select a07 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a08') then
      select a08 into r.status from status_sensor where unit = r.unit;
      select a08 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a09') then
      select a09 into r.status from status_sensor where unit = r.unit;
      select a09 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a10') then
      select a10 into r.status from status_sensor where unit = r.unit;
      select a10 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a11') then
      select a11 into r.status from status_sensor where unit = r.unit;
      select a11 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a12') then
      select a12 into r.status from status_sensor where unit = r.unit;
      select a12 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a13') then
      select a13 into r.status from status_sensor where unit = r.unit;
      select a13 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a14') then
      select a14 into r.status from status_sensor where unit = r.unit;
      select a14 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'a15') then
      select a15 into r.status from status_sensor where unit = r.unit;
      select a15 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'i0') then
      select i0 into r.status from status_sensor where unit = r.unit;
      select i0 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'i1') then
      select i1 into r.status from status_sensor where unit = r.unit;
      select i1 into r.status from status_sensor where unit = r.unit;
    end if;
    if (r.sensor = 'i2') then
      select i2 into r.status from status_sensor where unit = r.unit;
      select i2 into r.status from status_sensor where unit = r.unit;
    end if;
    return next r; 
  end loop;
  return;
end;
$status_sensor_list_update$ language plpgsql;
alter function status_sensor_list_update() owner to controller;


create function unit_get_address_from_name(sname varchar) returns varchar as $$
declare
begin
  return (select address from unit where name = sname);
end;
$$ language plpgsql;
alter function unit_get_address_from_name(varchar) owner to controller;


create function update_unit() returns trigger as $update_unit$
declare
  s1 varchar;
begin
  new.updated = now();
  if (new.online <> old.online) then
    new.online_offline = now();
    if (new.online = true) then
      s1 := new.name || ' online';
    else s1 := new.name || ' offline';
    end if;
    insert into log (description, updated) values (s1, now());
  end if;
  return new;
end;
$update_unit$ language plpgsql;
alter function update_unit() owner to controller;



create function update_request_dio() returns trigger as $update_request_dio$
declare
  mode char(54);
  extra text;
begin
  select dio_mode into mode from unit where id = new.unit;
  --raise notice 'MODE %', mode;

  if (substring(mode from 1 for 1) <> '1') then new.d00 = old.d00;
  else if (new.d00 <> (select d00 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':00:' || new.d00::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 2 for 1) <> '1') then new.d01 = old.d01;
  else if (new.d01 <> (select d01 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':01:' || new.d01::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 3 for 1) <> '1') then new.d02 = old.d02;
  else if (new.d02 <> (select d02 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':02:' || new.d02::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 4 for 1) <> '1') then new.d03 = old.d03;
  else if (new.d03 <> (select d03 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':03:' || new.d03::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 5 for 1) <> '1') then new.d04 = old.d04;
  else if (new.d04 <> (select d04 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':04:' || new.d04::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 6 for 1) <> '1') then new.d05 = old.d05;
  else if (new.d05 <> (select d05 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':05:' || new.d05::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 7 for 1) <> '1') then new.d06 = old.d06;
  else if (new.d06 <> (select d06 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':06:' || new.d06::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 8 for 1) <> '1') then new.d07 = old.d07;
  else if (new.d07 <> (select d07 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':07:' || new.d07::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 9 for 1) <> '1') then new.d08 = old.d08;
  else if (new.d08 <> (select d08 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':08:' || new.d08::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 10 for 1) <> '1') then new.d09 = old.d09;
  else if (new.d09 <> (select d09 from status_dio where unit = new.unit)) then new.updated = now(); extra := new.unit::text || ':09:' || new.d09::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 11 for 1) <> '1') then new.d10 = old.d10;
  else if (new.d10 <> (select d10 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':10:' || new.d10::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 12 for 1) <> '1') then new.d11 = old.d11;
  else if (new.d11 <> (select d11 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':11:' || new.d11::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 13 for 1) <> '1') then new.d12 = old.d12;
  else if (new.d12 <> (select d12 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':12:' || new.d12::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 14 for 1) <> '1') then new.d13 = old.d13;
  else if (new.d13 <> (select d13 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':13:' || new.d13::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 15 for 1) <> '1') then new.d14 = old.d14;
  else if (new.d14 <> (select d14 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':14:' || new.d14::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 16 for 1) <> '1') then new.d15 = old.d15;
  else if (new.d15 <> (select d15 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':15:' || new.d15::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 17 for 1) <> '1') then new.d16 = old.d16;
  else if (new.d16 <> (select d16 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':16:' || new.d16::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 18 for 1) <> '1') then new.d17 = old.d17;
  else if (new.d17 <> (select d17 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':17:' || new.d17::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 19 for 1) <> '1') then new.d18 = old.d18;
  else if (new.d18 <> (select d18 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':18:' || new.d18::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 20 for 1) <> '1') then new.d19 = old.d19;
  else if (new.d19 <> (select d19 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':19:' || new.d19::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 21 for 1) <> '1') then new.d20 = old.d20;
  else if (new.d20 <> (select d20 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':20:' || new.d20::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 22 for 1) <> '1') then new.d21 = old.d21;
  else if (new.d21 <> (select d21 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':21:' || new.d21::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 23 for 1) <> '1') then new.d22 = old.d22;
  else if (new.d22 <> (select d22 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':22:' || new.d22::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 24 for 1) <> '1') then new.d23 = old.d23;
  else if (new.d23 <> (select d23 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':23:' || new.d23::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 25 for 1) <> '1') then new.d24 = old.d24;
  else if (new.d24 <> (select d24 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':24:' || new.d24::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 26 for 1) <> '1') then new.d25 = old.d25;
  else if (new.d25 <> (select d25 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':25:' || new.d25::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 27 for 1) <> '1') then new.d26 = old.d26;
  else if (new.d26 <> (select d26 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':26:' || new.d26::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 28 for 1) <> '1') then new.d27 = old.d27;
  else if (new.d27 <> (select d27 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':27:' || new.d27::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 29 for 1) <> '1') then new.d28 = old.d28;
  else if (new.d28 <> (select d28 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':28:' || new.d28::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 30 for 1) <> '1') then new.d29 = old.d29;
  else if (new.d39 <> (select d29 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':29:' || new.d29::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 31 for 1) <> '1') then new.d30 = old.d30;
  else if (new.d30 <> (select d30 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':30:' || new.d30::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 32 for 1) <> '1') then new.d31 = old.d31;
  else if (new.d31 <> (select d31 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':31:' || new.d31::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 33 for 1) <> '1') then new.d32 = old.d32;
  else if (new.d32 <> (select d32 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':32:' || new.d32::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 34 for 1) <> '1') then new.d33 = old.d33;
  else if (new.d33 <> (select d33 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':33:' || new.d33::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 35 for 1) <> '1') then new.d34 = old.d34;
  else if (new.d34 <> (select d34 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':34:' || new.d34::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 36 for 1) <> '1') then new.d35 = old.d35;
  else if (new.d35 <> (select d35 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':35:' || new.d35::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 37 for 1) <> '1') then new.d36 = old.d36;
  else if (new.d36 <> (select d36 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':36:' || new.d36::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 38 for 1) <> '1') then new.d37 = old.d37;
  else if (new.d37 <> (select d37 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':37:' || new.d37::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 39 for 1) <> '1') then new.d38 = old.d38;
  else if (new.d38 <> (select d38 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':38:' || new.d38::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 40 for 1) <> '1') then new.d39 = old.d39;
  else if (new.d39 <> (select d39 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':39:' || new.d39::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 41 for 1) <> '1') then new.d40 = old.d40;
  else if (new.d40 <> (select d40 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':40:' || new.d40::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 42 for 1) <> '1') then new.d41 = old.d41;
  else if (new.d41 <> (select d41 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':41:' || new.d41::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 43 for 1) <> '1') then new.d42 = old.d42;
  else if (new.d41 <> (select d42 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':42:' || new.d42::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 44 for 1) <> '1') then new.d43 = old.d43;
  else if (new.d43 <> (select d43 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':43:' || new.d43::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 45 for 1) <> '1') then new.d44 = old.d44;
  else if (new.d44 <> (select d44 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':44:' || new.d44::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 46 for 1) <> '1') then new.d45 = old.d45;
  else if (new.d45 <> (select d45 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':45:' || new.d45::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 47 for 1) <> '1') then new.d46 = old.d46;
  else if (new.d46 <> (select d46 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':46:' || new.d46::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 48 for 1) <> '1') then new.d47 = old.d47;
  else if (new.d47 <> (select d47 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':47:' || new.d47::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 49 for 1) <> '1') then new.d48 = old.d48;
  else if (new.d48 <> (select d48 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':48:' || new.d48::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 50 for 1) <> '1') then new.d49 = old.d49;
  else if (new.d49 <> (select d49 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':49:' || new.d49::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 51 for 1) <> '1') then new.d50 = old.d50;
  else if (new.d50 <> (select d50 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':50:' || new.d50::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 52 for 1) <> '1') then new.d51 = old.d51;
  else if (new.d51 <> (select d51 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':51:' || new.d51::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 53 for 1) <> '1') then new.d52 = old.d52;
  else if (new.d52 <> (select d52 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':52:' || new.d52::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  if (substring(mode from 54 for 1) <> '1') then new.d53 = old.d53;
  else if (new.d53 <> (select d53 from status_dio where address = new.address)) then new.updated = now(); extra := new.unit::text || ':53:' || new.d53::text; perform pg_notify('req_dio_arduino_mqtt', extra); end if;
  end if;
  --raise notice '%', extra;
  return new;
end;
$update_request_dio$ language plpgsql;
alter function update_request_dio() owner to controller;


create function update_status_dio() returns trigger as $update_status_dio$
declare
  extra text;
begin
  if (  (new.d00 <> old.d00) or (new.d01 <> old.d01) or (new.d02 <> old.d02) or (new.d03 <> old.d03) or (new.d04 <> old.d04) or (new.d05 <> old.d05) or (new.d06 <> old.d06) or (new.d07 <> old.d07) or
        (new.d08 <> old.d08) or (new.d09 <> old.d09) or (new.d10 <> old.d10) or (new.d11 <> old.d11) or (new.d12 <> old.d12) or (new.d13 <> old.d13) or (new.d14 <> old.d14) or (new.d15 <> old.d15) or 
        (new.d16 <> old.d16) or (new.d17 <> old.d17) or (new.d18 <> old.d18) or (new.d19 <> old.d19) or (new.d20 <> old.d20) or (new.d21 <> old.d21) or (new.d22 <> old.d22) or (new.d23 <> old.d23) or
        (new.d24 <> old.d24) or (new.d25 <> old.d25) or (new.d26 <> old.d26) or (new.d27 <> old.d27) or (new.d28 <> old.d28) or (new.d29 <> old.d29) or (new.d30 <> old.d30) or (new.d31 <> old.d31) or
        (new.d32 <> old.d32) or (new.d33 <> old.d33) or (new.d34 <> old.d34) or (new.d35 <> old.d35) or (new.d36 <> old.d36) or (new.d37 <> old.d37) or (new.d38 <> old.d38) or (new.d39 <> old.d39) or
        (new.d40 <> old.d40) or (new.d41 <> old.d41) or (new.d42 <> old.d42) or (new.d43 <> old.d43) or (new.d44 <> old.d44) or (new.d45 <> old.d45) or (new.d46 <> old.d46) or (new.d47 <> old.d47) or
        (new.d48 <> old.d48) or (new.d49 <> old.d49) or (new.d50 <> old.d50) or (new.d51 <> old.d51) or (new.d52 <> old.d52) or (new.d53 <> old.d53))
    then
    extra := lpad(new.unit::text, 2, '0') || ':';
    extra := extra || new.d00::text || new.d01::text || new.d02::text || new.d03::text || new.d04::text || new.d05::text || new.d06::text || new.d07::text;
    extra := extra || new.d08::text || new.d09::text || new.d10::text || new.d11::text || new.d12::text || new.d13::text || new.d14::text || new.d15::text;
    extra := extra || new.d16::text || new.d17::text || new.d18::text || new.d19::text || new.d20::text || new.d21::text || new.d22::text || new.d23::text;
    extra := extra || new.d24::text || new.d25::text || new.d26::text || new.d27::text || new.d28::text || new.d29::text || new.d30::text || new.d31::text;
    extra := extra || new.d32::text || new.d33::text || new.d34::text || new.d35::text || new.d36::text || new.d37::text || new.d38::text || new.d39::text;
    extra := extra || new.d40::text || new.d41::text || new.d42::text || new.d43::text || new.d44::text || new.d45::text || new.d46::text || new.d47::text;
    extra := extra || new.d48::text || new.d49::text || new.d50::text || new.d51::text || new.d52::text || new.d53::text || '|';
    extra := replace(extra, 'alse', '');
    extra := replace(extra, 'rue', '');
    perform pg_notify('status_dio_arduino_mqtt', extra);
    new.changed = now();
    --raise notice '%', extra;
  end if;
  new.updated = now();
  update unit set updated = now() where id = new.unit;
  return new;
end;
$update_status_dio$ language plpgsql;
alter function update_status_dio() owner to controller;


create function update_status_sensor() returns trigger as $update_status_sensor$
declare
  extra text;
begin
  if ((new.a00 <> old.a00) or (new.a01 <> old.a01) or (new.a02 <> old.a02) or (new.a03 <> old.a03) or (new.a04 <> old.a04) or (new.a05 <> old.a05) or (new.a06 <> old.a06) or (new.a07 <> old.a07) or
      (new.a08 <> old.a08) or (new.a09 <> old.a09) or (new.a10 <> old.a10) or (new.a11 <> old.a11) or (new.a12 <> old.a12) or (new.a13 <> old.a13) or (new.a14 <> old.a14) or (new.a15 <> old.a15))
  then
    extra := lpad(new.unit::text, 2, '0') || ':';
    extra := extra || new.a00::text || '|' || new.a01::text || '|' || new.a02::text || '|' || new.a03::text || '|' || new.a04::text || '|' || new.a05::text || '|' || new.a06 || '|' || new.a07 || '|';
    extra := extra || new.a08::text || '|' || new.a09::text || '|' || new.a10::text || '|' || new.a11::text || '|' || new.a12::text || '|' || new.a13::text || '|' || new.a14 || '|' || new.a15 || '|';
    perform pg_notify('status_ain_arduino_mqtt', extra);
    new.changed = now();
  end if;
  if ((new.i00 <> old.i00) or (new.i01 <> old.i01) or (new.i02 <> old.i02)) then
    extra := lpad(new.unit::text, 2, '0') || ':' || new.i00::text || '|' || new.i01::text || '|' || new.i02::text || '|';
    perform pg_notify('status_i2c_arduino_mqtt', extra);
    new.changed = now();
  end if;
  new.updated = now();
  update unit set updated = now() where id = new.unit;
  return new;
end;
$update_status_sensor$ language plpgsql;
alter function update_status_sensor() owner to controller;

create function insert_log() returns trigger as $insert_log$
declare
begin
  new.updated = now();
  return new;
end;
$insert_log$ language plpgsql;
alter function insert_log() owner to controller;







--TRIGGERS

create trigger update_unit before update on unit
  for each row execute procedure update_unit();

create trigger update_request_dio before update on request_dio
  for each row execute procedure update_request_dio();

create trigger update_status_dio before update on status_dio
  for each row execute procedure update_status_dio();

create trigger update_status_sensor before update on status_sensor
  for each row execute procedure update_status_sensor();

create trigger insert_log before insert on log
  for each row execute procedure insert_log();

create trigger status_dio_list_from_name_dio after update on name_dio
  for each statement execute procedure status_dio_list_rebuild();

create trigger status_dio_list_from_unit after update on unit
  for each statement execute procedure status_dio_list_rebuild();

create trigger status_sensor_list_from_name_sensor after update on name_sensor
  for each statement execute procedure status_sensor_list_rebuild();

create trigger status_sensor_list_from_unit after update on unit
  for each statement execute procedure status_sensor_list_rebuild();

--INITIAL INSERTIONS

--all units have MAC addresses starting at a8:61:0a:ae:WX:YZ

--production units without preconfigured MAC addresses - start at 9900 hex
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('1',  '006.050', '1000000000000000', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'bedroom guest',  'robotdyne leo eth, BME280, LM35 - in wall');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('2',  '006.051', '1000000000000000', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'bar',            'uno ethernet, BME280, LM35 - in wall near speaker');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('3',  '006.052', '1000000000000000', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'theater',        'uno ethernet, BME280, LM35 - in wall near pool table');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('4',  '006.053', '1000000000000000', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'bedroom master', 'robotdyne leo eth, BME280, LM35 - in wall');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('5',  '006.054', '1000000000000000', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'dining room',    'robotdyn leo eth, BME280, LM35 - in wall');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('6',  '006.055', '1000000000000000', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'kitchen',        'robotdyne leo eth, BME280, LM35 - in wall');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('7',  '006.056', '1000000000000000', '2222X22222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'attic driveway', 'uno, sunfounder eth shield');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('8',  '006.057', '1000000000000000', '2222X22222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'attic pathway',  'uno, sunfounder eth shield');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('9',  '006.058', '1000000000000000', '2222X22222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'garage 1',       'uno, sunfounder 4 relay shield, BME280, LM35 - this needs updating');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('10', '006.059', '1000000000000000', '1122XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '110000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'garage 2',       'uno, sunfounder 4 relay shield, BME280, LM35 - this needs updating');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('11', '006.060', '1000000000000000', '1111X22222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '111100000000000000000000000000000000000000000000000000', 'f', now(), now(), 'hvac 1',         'uno, sunfounder eth, sunfounder 4 relay shield, BME280, LM35 - basement furnace');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('12', '006.061', '1000000000000000', '1111X22222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '111100000000000000000000000000000000000000000000000000', 'f', now(), now(), 'hvac 2',         'uno, sunfounder eth, sunfounder 4 relay shield, BME280, LM35 - first floor furnace');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('13', '006.062', '1000000000000000', '2222X22222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'laundry 1',      'uno eth, BME280, LM35');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('14', '006.063', '1000000000000000', '2222X11122XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000001110000000000000000000000000000000000000000000000', 'f', now(), now(), 'laundry 2',      'uno eth, BME280, LM35');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('15', '006.064', '1000000000000000', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'exterior north', 'uno standalone eth, BME280, LM35 - above garage door');
--insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('', '', '', '0000000000000000', '2222222222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), '');

--TEST UNITS
--units with preconfigured MAC addresses
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('101', '006.040', '1000000000000000', '1111X22222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'test uno 1',   'genuino uno, arduino eth2, BME280, LM35');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('102', '006.041', '1000000000000000', '1111X22222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'test uno 2',   'genuino uno, arduino eth2, BME280, LM35');

--test units with assignable MAC addresses - start at 9800 hex
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('103', '006.042', '1000000000000000', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'test leo eth', 'robotdyne leo eth, BME280, LM35 - no room for DIO function');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('104', '006.043', '1000000000000000', '2222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'test mkr1010', 'mkr 1010, mkr eth5500, mkr env, lm35');
insert into unit (id, address, ain_active, dio_mode, dio_init, online, online_offline, updated, name, misc) values ('105', '006.044', '1000000000000000', '22222X2222XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '000000000000000000000000000000000000000000000000000000', 'f', now(), now(), 'test mega',    'mega eth5500, lm35');


--updates


--MKR1010 test
update name_dio    set 	d00 = 'test00', d01 = 'test01', d02 = 'test02', d03 = 'test03', d04 = 'test04', d05 = 'do not use', d06 = 'test06', d07 = 'test07', d08 = 'test08', d09 = 'test09'
  where unit = (select id from unit where name = 'test mkr1010');

update name_sensor set a00 = 'analog temp C', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', a06 = 'unset', a07 = 'unset', i00 = 'MKR ENV shield temp C', i01 = 'MKR ENV shield RH%', i02 = 'MKR ENV shield millibar'
  where unit = (select id from unit where name = 'test mkr1010');


--Uno test unit #1
update name_dio    set d00 = 'test00', d01 = 'test01', d02 = 'test02', d03 = 'test03', d04 = 'do not use', d05 = 'test05', d06 = 'test06', d07 = 'test07', d08 = 'test08', d09 = 'test09'
  where unit = (select id from unit where name = 'test uno 1');

update name_sensor set a00 = 'LM35', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', a06 = 'unset', a07 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'test uno 1');


--Uno test unit #2
update name_dio    set d00 = 'test00', d01 = 'test01', d02 = 'test02', d03 = 'test03', d04 = 'do not use', d05 = 'test05', d06 = 'test06', d07 = 'test07', d08 = 'test08', d09 = 'test09'
  where unit = (select id from unit where name = 'test uno 2');

update name_sensor set a00 = 'analog temp C', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', a06 = 'unset', a07 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'test uno 2');


--robotdyne leo eth test
update name_sensor set a00 = 'analog temp C', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', a06 = 'unset', a07 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'test leo eth');



--PRODUCTION UNITS

--bedroom guest
update name_sensor set a00 = 'analog temp C', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'bedroom guest');

--bedroom master
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'bedroom master');
--the analog sensor on this unit is a bit flaky, so disable...
update unit set ain_active = '0000000000000000' where name = 'bedroom master';


--bar
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'bar');

--kitchen
update name_sensor set a00 = 'analog temp C', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'kitchen');

--dining room
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'dining room');

--bedroom guest
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'theater');

--hvac 1
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'hvac 1');
update name_dio    set d00 = 'basement cool', d01 = 'basement heat', d02 = 'basement circ', d03 = 'basement humidifier', d04 = 'do not use', d05 = 'unset', d06 = 'unset', d07 = 'unset', d08 = 'unset', d09 = 'unset'
  where unit = (select id from unit where name = 'hvac 1');

--hvac 2
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'hvac 2');
update name_dio    set d00 = 'upstairs cool', d01 = 'upstairs heat', d02 = 'upstairs circ', d03 = 'upstairs humidifier', d04 = 'do not use', d05 = 'unset', d06 = 'unset', d07 = 'unset', d08 = 'unset', d09 = 'unset'
  where unit = (select id from unit where name = 'hvac 2');

--garage 1
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'garage 1');
update name_dio    set d00 = 'upstairs cool', d01 = 'upstairs heat', d02 = 'upstairs circ', d03 = 'upstairs humidifier', d04 = 'do not use', d05 = 'unset', d06 = 'unset', d07 = 'unset', d08 = 'unset', d09 = 'unset'
  where unit = (select id from unit where name = 'garage 1');

--garage 2
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'garage 2');
update name_dio    set d00 = '', d01 = '', d02 = '', d03 = '', d04 = 'do not use', d05 = 'unset', d06 = 'unset', d07 = 'unset', d08 = 'unset', d09 = 'unset'
  where unit = (select id from unit where name = 'garage 2');

--laundry 1
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'laundry 1');
update name_dio    set d00 = '', d01 = '', d02 = '', d03 = '', d04 = 'do not use', d05 = 'unset', d06 = 'unset', d07 = 'unset', d08 = 'unset', d09 = 'unset'
  where unit = (select id from unit where name = 'laundry 1');

--laundry 2
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'laundry 2');
update name_dio    set d00 = '', d01 = '', d02 = '', d03 = '', d04 = 'do not use', d05 = 'unset', d06 = 'unset', d07 = 'unset', d08 = 'unset', d09 = 'unset'
  where unit = (select id from unit where name = 'laundry 2');

--attic pathway
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'attic pathway');
update name_dio    set d00 = '', d01 = '', d02 = '', d03 = '', d04 = 'do not use', d05 = 'unset', d06 = 'unset', d07 = 'unset', d08 = 'unset', d09 = 'unset'
  where unit = (select id from unit where name = 'attic pathway');

--attic driveway
update name_sensor set a00 = 'analog temp F', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
  where unit = (select id from unit where name = 'attic driveway');
update name_dio    set d00 = '', d01 = '', d02 = '', d03 = '', d04 = 'do not use', d05 = 'unset', d06 = 'unset', d07 = 'unset', d08 = 'unset', d09 = 'unset'
  where unit = (select id from unit where name = 'attic driveway');






--blank template
--update name_dio    set d00 = 'unset', d01 = 'unset', d02 = 'unset', d03 = 'unset', d04 = 'unset', d05 = 'unset', d06 = 'unset', d07 = 'unset', d08 = 'unset', d09 = 'unset'
--  where unit = (select id from unit where name = '');

--update name_sensor set a00 = 'LM35', a01 = 'unset', a02 = 'unset', a03 = 'unset', a04 = 'unset', a05 = 'unset', a06 = 'unset', a07 = 'unset',
--                       i00 = 'BME280 temp C', i01 = 'BME280 RH%', i02 = 'BME280 millibar'
--  where unit = (select id from unit where name = '');

--update bias_sensor set a00 = '0', a01 = '0', a02 = '0', a03 = '0', a04 = '0', a05 = '0', a06 = 'unset', a07 = 'unset',
--			 i00 = '0', i01 = '0', i02 = '0'
--  where unit = (select id from unit where name = '');




import 'package:flutter/cupertino.dart';
import 'package:postgres/postgres.dart';


Future Main() async {
  final conn = PostgreSQLConnection('rc1b-tzf902fgo6tak7op.mdb.yandexcloud.net', 6432, 'pionerdb',username: 'user', password: '12345678',useSSL: true);
  await conn.open();
  print(conn);
  //await conn.query('''
  //INSERT INTO address (address_id, organization_id,address_type_id,subject_name,city_name,street_name,house_number,add_info) VALUES ('1','1','10','Samarskaya','Samara','Moskovskoe', '22','Мойка на тесте')

  //''');

  // await conn.query('''
  // INSERT INTO address_type (address_type_id,address_type_name) VALUES ('10','test')
  // ''');

  // await conn.query('''
  //INSERT INTO organization (organization_id,organization_full_name,organization_short_name,inn,kpp,ogrn,responsible_person_surname,responsible_person_name,responsible_person_email,responsible_person_phone_number,add_info) VALUES ('1','test','test','111','111','111', 'АНДРЕЕВ','МИХАИЛ','88005553535','TEST')

  //''');
  var results = await conn.query('SELECT * from address');
  var results1 = await conn.query('SELECT * from address_type');
  var results2 = await conn.query('SELECT * from organization');
  print (results);
  print (results1);
  print (results2);
  //await conn.close();
  //print(conn.close);
}

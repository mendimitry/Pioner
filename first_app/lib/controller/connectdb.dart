
import 'package:flutter/cupertino.dart';
import 'package:postgres/postgres.dart';


Future Main() async {
  final conn = PostgreSQLConnection('rc1b-tzf902fgo6tak7op.mdb.yandexcloud.net', 6432, 'pionerdb',username: 'user', password: '12345678',useSSL: true);
  await conn.open();
  print(conn);
  await conn.query('''
  CREATE TABLE test1 (name text)
  
  ''');
  await conn.query('''
  INSERT INTO test1 (name) VALUES ('Dmitry')
  
  ''');

  var results = await conn.query('SELECT * from test1');
  print (results);
  //await conn.close();
  //print(conn.close);
}

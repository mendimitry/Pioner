//Уточнение состава услуги(Мойка)

import 'dart:async';
import 'package:first_app/data/composition_of_services.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:first_app/models/service.dart';
import 'package:postgres/postgres.dart';
import 'Choosing_time_service.dart';
import 'choosing_organization_car_wash.dart';
import 'login_page.dart';
import 'dart:convert';
import 'package:first_app/controller/connectdb.dart';

class TestAdminka extends StatefulWidget {
  const TestAdminka({super.key});

  State<TestAdminka> createState() =>
      _TestAdminka();
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

class _TestAdminka extends State<TestAdminka> {
  Future<List<Service>> getServicesFromJSON() async {
    return await Future.delayed(const Duration(seconds: 0), () {
      List<dynamic> data = jsonDecode(jsonString);
      List<Service> services =
      data.map((dynamic data) => Service.fromJSON(data)).toList();
      return services;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[

            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 15, left: 0, right: 0),
              child: Center(

              ),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
                child: Text(
                  "Информационное меню:",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 0, left: 20, right: 20),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    Main();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black26,
                      fixedSize: const Size(300, 50)),
                  child: const Text('Выбрать',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future Main() async {
    final conn = PostgreSQLConnection(
        'rc1b-tzf902fgo6tak7op.mdb.yandexcloud.net', 6432, 'pionerdb',
        username: 'user', password: '12345678', useSSL: true);
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
    print(results);
    print(results1);
    print(results2);
  }
}
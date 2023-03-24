
import 'package:first_app/models/Address.dart';
import 'package:first_app/models/AggregatorSpecialist.dart';
import 'package:first_app/models/AggregatorSpecialistConnectorRequest.dart';
import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/models/Customer.dart';
import 'package:first_app/models/Organization.dart';
import 'package:first_app/models/ServiceRequest.dart';
import 'package:first_app/models/ServiceRequestDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';


class PionerDB {
  var dbConnection;

  initDatabaseConnection() async {
    dbConnection = PostgreSQLConnection('rc1b-tzf902fgo6tak7op.mdb.yandexcloud.net', 6432, 'pionerdb',username: 'user', password: '12345678',useSSL: true);
    await dbConnection.open().then((value) async {
      print("Database Connected!");
    });
  }

  closeDatabaseConnection() async{
    await dbConnection.close().then((value) async {
      print("Database Closed!");
    });
  }

// test
  Future<List<String>> getCityFromOneCity() async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await dbConnection.mappedResultsQuery('SELECT DISTINCT city_name from address');
    print(query);
    String _address;
    List<String> _addresses = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _address=subElement.toString();
        print(_address);

        _addresses.add(_address);
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _addresses;
  }
}

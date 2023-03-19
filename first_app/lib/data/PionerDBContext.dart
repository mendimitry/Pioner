
import 'package:first_app/models/Customer.dart';
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

  Future<List<Customer>> getAllCustomers() async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await dbConnection.mappedResultsQuery('SELECT * from customer');
    print(query);
    Customer _customer;
    List<Customer> _customers = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _customer=Customer.fromReqBody(subElement);
        _customer.printAttributes();

        _customers.add(_customer);
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _customers;
  }

  Future<Customer> getCustomerByID(int ID) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery('SELECT * from customer where customer_id = ' + ID.toString());
    print(query);
    //Нулевой объект
    Customer _customer = Customer(customer_id: 0, customer_phone_number: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _customer = Customer.fromReqBody(subElement);
        _customer.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _customer;
  }

  Future<Customer> getCustomerByPhoneNumber(String phoneNumber) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery("SELECT * from customer where customer_phone_number = '$phoneNumber'");
    print(query);
    //Нулевой объект
    Customer _customer = Customer(customer_id: 0, customer_phone_number: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _customer = Customer.fromReqBody(subElement);
        _customer.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _customer;
  }

  Future<int> postCustomer(String phoneNumber, String? name, String? surname) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    if (name == null || name == ""){
      name = "null";
    }
    if (surname == null || surname == ""){
      surname = "null";
    }

    var query = await dbConnection.mappedResultsQuery("INSERT INTO customer (customer_surname, customer_name, customer_phone_number) VALUES ('$surname', '$name', '$phoneNumber') RETURNING customer_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['customer_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return id;
  }

  Future<int> deleteCustomer(String phoneNumber) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    var query = await dbConnection.mappedResultsQuery("DELETE FROM customer WHERE customer_phone_number ='$phoneNumber';");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement;
        print(id);
      }
    }

    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return id;
  }

 /* Пока так
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
  */
}

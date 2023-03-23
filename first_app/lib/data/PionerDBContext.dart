
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

  //Запросы Customer
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

  //Запросы Organisation
  Future<int> postOrganization(String organization_full_name,String organization_short_name,String inn,String kpp,String ogrn,String responsible_person_surname,String responsible_person_name,String responsible_person_patronymic, String responsible_person_email,String responsible_person_phone_number,String add_info)
  async {
    await initDatabaseConnection();

    var query = await dbConnection.mappedResultsQuery(
        "INSERT INTO organization (organization_full_name,organization_short_name,inn,kpp,ogrn,responsible_person_surname,responsible_person_name,responsible_person_patronymic, responsible_person_email,responsible_person_phone_number,add_info) VALUES ('$organization_full_name','$organization_short_name','$inn','$kpp','$ogrn','$responsible_person_surname','$responsible_person_name','$responsible_person_patronymic','$responsible_person_email','$responsible_person_phone_number','$add_info') RETURNING organization_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['organization_id'];
        print(id);
      }
    }

    await closeDatabaseConnection();
    return id;
  }

  Future<List<Organization>> getAllOrganization() async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await dbConnection.mappedResultsQuery('SELECT * from organization');
    print(query);
    Organization _organization;
    List<Organization> _organizations = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _organization=Organization.fromReqBody(subElement);
        _organization.printAttributes();

        _organizations.add(_organization);
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _organizations;
  }

  Future<Organization> getOrganizationByID(int id) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery("SELECT * from organization where organization_id = '$id'");
    print(query);
    //Нулевой объект
    Organization _organization = Organization(organization_id: 0, inn: '', kpp: '', ogrn: '', responsible_person_phone_number: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _organization = Organization.fromReqBody(subElement);
        _organization.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _organization;
  }


  Future<Organization> getOrganizationByINNandOGRN(int inn, int ogrn) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery("SELECT * from organization where inn = '$inn' and ogrn='$ogrn'");
    print(query);
    //Нулевой объект
    Organization _organization = Organization(organization_id: 0, inn: '', kpp: '', ogrn: '', responsible_person_phone_number: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _organization = Organization.fromReqBody(subElement);
        _organization.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _organization;
  }
  //Запросы ConnectionRequest
  Future<int> postStatusOrganization(int organization_id,String reg_number,DateTime date_begin,String status) async {
    await initDatabaseConnection();

    var query = await dbConnection.mappedResultsQuery(
        "INSERT INTO connection_request (organization_id,reg_number,date_begin,status) VALUES ('$organization_id','$reg_number','$date_begin','$status') RETURNING connection_request_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['connection_request_id'];
        print(id);
      }
    }

    await closeDatabaseConnection();
    return id;
  }

  Future<ConnectionRequest> getStatusOrganizationByID(int organization_id) async {
    await initDatabaseConnection();

    var query = await dbConnection.mappedResultsQuery('SELECT * from connection_request where organization_id = ' + organization_id.toString());
    print(query);
    //Нулевой объект
    ConnectionRequest _connectionRequest = ConnectionRequest(connection_request_id: 0, organization_id: 0, reg_number: '', date_begin: DateTime(0), status: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _connectionRequest = ConnectionRequest.fromReqBody(subElement);
        _connectionRequest.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _connectionRequest;
  }

  //Запросы AggregatorSpecialist
  Future<List<AggregatorSpecialist>> getAllAggregatorSpecialists() async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await dbConnection.mappedResultsQuery('SELECT * from aggregator_specialist');
    print(query);
    AggregatorSpecialist _aggregatorSpecialist;
    List<AggregatorSpecialist> _aggregatorSpecialists = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _aggregatorSpecialist=AggregatorSpecialist.fromReqBody(subElement);
        _aggregatorSpecialist.printAttributes();

        _aggregatorSpecialists.add(_aggregatorSpecialist);
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialists;
  }

  Future<AggregatorSpecialist> getAggregatorSpecialistByID(int ID) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery('SELECT * from aggregator_specialist where aggregator_specialists_id = $ID');
    print(query);
    //Нулевой объект
    AggregatorSpecialist _aggregatorSpecialist = AggregatorSpecialist(aggregator_specialists_id: 0, aggregator_specialist_surname: '', aggregator_specialist_name: '',
        aggregator_specialists_department: '', aggregator_specialists_position: '', aggregator_specialists_phone_number: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _aggregatorSpecialist = AggregatorSpecialist.fromReqBody(subElement);
        _aggregatorSpecialist.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialist;
  }

  Future<AggregatorSpecialist> getAggregatorSpecialistByPhoneNumber(String phoneNumber) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery("SELECT * from aggregator_specialist where aggregator_specialist_phone_number = '$phoneNumber'");
    print(query);
    //Нулевой объект
    AggregatorSpecialist _aggregatorSpecialist = AggregatorSpecialist(aggregator_specialists_id: 0, aggregator_specialist_surname: '', aggregator_specialist_name: '',
        aggregator_specialists_department: '', aggregator_specialists_position: '', aggregator_specialists_phone_number: '');

    for (var element in query) {
      for (var subElement in element.values) {
        _aggregatorSpecialist = AggregatorSpecialist.fromReqBody(subElement);
        _aggregatorSpecialist.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialist;
  }

  Future<int> postAggregatorSpecialist(String aggregator_specialist_surname,String aggregator_specialist_name,
      String aggregator_specialist_department,String aggregator_specialist_position,String aggregator_specialist_phone_number, String? add_info) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    var query = await dbConnection.mappedResultsQuery("INSERT INTO aggregator_specialist (aggregator_specialist_surname, aggregator_specialist_name, aggregator_specialists_department, aggregator_specialists_position, aggregator_specialists_phone_number, add_info) "
        "VALUES ('$aggregator_specialist_surname', '$aggregator_specialist_name', '$aggregator_specialist_department','$aggregator_specialist_position', '$aggregator_specialist_phone_number','$add_info') RETURNING aggregator_specialists_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['aggregator_specialists_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных агрегаторов
    return id;
  }

  //Запросы AggregatorSpecialistConnectorRequest
  Future<List<AggregatorSpecialistConnectorRequest>> getAllAggregatorSpecialistConnectorRequest() async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await dbConnection.mappedResultsQuery('SELECT * from aggregator_specialist_connector_request');
    print(query);
    AggregatorSpecialistConnectorRequest _aggregatorSpecialistConnectorRequest;
    List<AggregatorSpecialistConnectorRequest> _aggregatorSpecialistConnectorRequests = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _aggregatorSpecialistConnectorRequest=AggregatorSpecialistConnectorRequest.fromReqBody(subElement);
        _aggregatorSpecialistConnectorRequest.printAttributes();

        _aggregatorSpecialistConnectorRequests.add(_aggregatorSpecialistConnectorRequest);
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialistConnectorRequests;
  }

  Future<AggregatorSpecialistConnectorRequest> getAggregatorSpecialistConnectorRequestByID(int ID) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery('SELECT * from aggregator_specialist_connector_request where aggregator_specialist_connector_request_id = $ID');
    print(query);
    //Нулевой объект
    AggregatorSpecialistConnectorRequest _aggregatorSpecialistConnectorRequest = AggregatorSpecialistConnectorRequest(aggregator_specialist_connector_request_id: 0, aggregator_specialists_id: 0, connection_request_id: 0);
    for (var element in query) {
      for (var subElement in element.values) {
        _aggregatorSpecialistConnectorRequest = AggregatorSpecialistConnectorRequest.fromReqBody(subElement);
        _aggregatorSpecialistConnectorRequest.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialistConnectorRequest;
  }

  Future<AggregatorSpecialistConnectorRequest> getAggregatorSpecialistConnectorRequestByRequestID(int ID) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery("SELECT * from aggregator_specialist_connector_request where connection_request_id = '$ID'");
    print(query);
    //Нулевой объект
    AggregatorSpecialistConnectorRequest _aggregatorSpecialistConnectorRequest = AggregatorSpecialistConnectorRequest(aggregator_specialist_connector_request_id: 0, aggregator_specialists_id: 0, connection_request_id: 0);

    for (var element in query) {
      for (var subElement in element.values) {
        _aggregatorSpecialistConnectorRequest = AggregatorSpecialistConnectorRequest.fromReqBody(subElement);
        _aggregatorSpecialistConnectorRequest.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialistConnectorRequest;
  }

  Future<int> postAggregatorSpecialistConnectorRequest(int aggregator_specialists_id, int connection_request_id) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    var query = await dbConnection.mappedResultsQuery("INSERT INTO aggregator_specialist_connector_request (aggregator_specialists_id, connection_request_id) VALUES ('$aggregator_specialists_id', '$connection_request_id') RETURNING aggregator_specialist_connector_request_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['aggregator_specialist_connector_request_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных агрегаторов
    return id;
  }

  //Запросы ServiceRequest
  Future<List<ServiceRequest>> getAllServiceRequest() async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await dbConnection.mappedResultsQuery('SELECT * from service_request');
    print(query);
    ServiceRequest _serviceRequest;
    List<ServiceRequest> _serviceRequests = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _serviceRequest=ServiceRequest.fromReqBody(subElement);
        _serviceRequest.printAttributes();

        _serviceRequests.add(_serviceRequest);
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequests;
  }

  Future<ServiceRequest> getServiceRequestByID(int ID) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery('SELECT * from service_request where service_request_id = $ID');
    print(query);
    //Нулевой объект
    ServiceRequest _serviceRequest = ServiceRequest(service_request_id: 0, customer_id: 0, organization_id: 0, date_service: DateTime(0));
    for (var element in query) {
      for (var subElement in element.values) {
        _serviceRequest = ServiceRequest.fromReqBody(subElement);
        _serviceRequest.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequest;
  }

  Future<ServiceRequest> getServiceRequestByCustomerID(int ID) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery("SELECT * from service_request where customer_id = '$ID'");
    print(query);
    //Нулевой объект
    ServiceRequest _serviceRequest = ServiceRequest(service_request_id: 0, customer_id: 0, organization_id: 0, date_service: DateTime(0));

    for (var element in query) {
      for (var subElement in element.values) {
        _serviceRequest = ServiceRequest.fromReqBody(subElement);
        _serviceRequest.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequest;
  }

  Future<int> postServiceRequest(int customer_id, int organization_id, DateTime date_service, add_info) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    var query = await dbConnection.mappedResultsQuery("INSERT INTO service_request (customer_id,  organization_id,  date_service, add_info) VALUES ('$customer_id', '$organization_id', '$date_service','$add_info') RETURNING service_request_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['service_request_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных агрегаторов
    return id;
  }




  //Запросы ServiceRequestDetail
  Future<List<ServiceRequestDetail>> getAllServiceRequestDetail() async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await dbConnection.mappedResultsQuery('SELECT * from service_request_detai');
    print(query);
    ServiceRequestDetail _serviceRequestDetail;
    List<ServiceRequestDetail> _serviceRequestDetails = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _serviceRequestDetail=ServiceRequestDetail.fromReqBody(subElement);
        _serviceRequestDetail.printAttributes();

        _serviceRequestDetails.add(_serviceRequestDetail);
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequestDetails;
  }

  Future<ServiceRequestDetail> getServiceRequestDetailByID(int ID) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery('SELECT * from service_request_detai where service_request_detail_id = $ID');
    print(query);
    //Нулевой объект
    ServiceRequestDetail _serviceRequestDetail = ServiceRequestDetail(service_request_detail_id: 0, service_request_id: 0, service_detail_id: 0);
    for (var element in query) {
      for (var subElement in element.values) {
        _serviceRequestDetail = ServiceRequestDetail.fromReqBody(subElement);
        _serviceRequestDetail.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequestDetail;
  }

  Future<ServiceRequestDetail> getServiceRequestDetailByRequestID(int ID) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await dbConnection.mappedResultsQuery("SELECT * from service_request_detai where service_request_id = '$ID'");
    print(query);
    //Нулевой объект
    ServiceRequestDetail _serviceRequestDetail = ServiceRequestDetail(service_request_detail_id: 0, service_request_id: 0, service_detail_id: 0);

    for (var element in query) {
      for (var subElement in element.values) {
        _serviceRequestDetail = ServiceRequestDetail.fromReqBody(subElement);
        _serviceRequestDetail.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequestDetail;
  }

  Future<int> postServiceRequestDetail(int service_request_detail_id, int service_request_id, int service_detail_id) async{
    //Подключаемся к БД
    await initDatabaseConnection();

    var query = await dbConnection.mappedResultsQuery("INSERT INTO service_request_detai (service_request_detail_id,  service_request_id,  service_detail_id) VALUES ('$service_request_detail_id', '$service_request_id', '$service_detail_id') RETURNING service_request_detail_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['service_request_detail_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await closeDatabaseConnection();

    //Возвращаем всех полученных агрегаторов
    return id;
  }



}

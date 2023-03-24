import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/ServiceRequest.dart';
import 'package:first_app/repository/ServiceRequest_Interface.dart';

class ServiceRequestRepository implements IServiceRequestRepository{
  PionerDB _pionerDB;
  ServiceRequestRepository(this._pionerDB);

  @override
  Future<List<ServiceRequest>> getAllServiceRequest() async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from service_request');
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequests;
  }

  @override
  Future<ServiceRequest> getServiceRequestByID(int ID) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from service_request where service_request_id = $ID');
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequest;
  }

  @override
  Future<ServiceRequest> getServiceRequestByCustomerID(int ID) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery("SELECT * from service_request where customer_id = '$ID'");
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequest;
  }

  @override
  Future<int> postServiceRequest(int customer_id, int organization_id, DateTime date_service, add_info) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery("INSERT INTO service_request (customer_id,  organization_id,  date_service, add_info) VALUES ('$customer_id', '$organization_id', '$date_service','$add_info') RETURNING service_request_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['service_request_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных агрегаторов
    return id;
  }
}
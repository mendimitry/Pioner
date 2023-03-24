import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/ServiceRequestDetail.dart';
import 'package:first_app/repository/ServiceRequestDetail_Interface.dart';

class ServiceRequestDetailRepository implements IServiceRequestDetailRepository{
  PionerDB _pionerDB;
  ServiceRequestDetailRepository(this._pionerDB);

  Future<List<ServiceRequestDetail>> getAllServiceRequestDetail() async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from service_request_detai');
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequestDetails;
  }

  Future<ServiceRequestDetail> getServiceRequestDetailByID(int ID) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from service_request_detai where service_request_detail_id = $ID');
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequestDetail;
  }

  Future<ServiceRequestDetail> getServiceRequestDetailByRequestID(int ID) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery("SELECT * from service_request_detai where service_request_id = '$ID'");
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _serviceRequestDetail;
  }

  Future<int> postServiceRequestDetail(int service_request_detail_id, int service_request_id, int service_detail_id) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery("INSERT INTO service_request_detai (service_request_detail_id,  service_request_id,  service_detail_id) VALUES ('$service_request_detail_id', '$service_request_id', '$service_detail_id') RETURNING service_request_detail_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['service_request_detail_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных агрегаторов
    return id;
  }
}
import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/ServiceDetail.dart';
import 'package:first_app/repository/ServiceDetail_Interface.dart';

class ServiceDetailRepository implements IServiceDetailRepository{
  final PionerDB _pionerDB;
  ServiceDetailRepository(this._pionerDB);

  @override
  Future<List<ServiceDetail>> getAllServiceDetail() async{
    await _pionerDB.initDatabaseConnection();

    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from service_detail');
    print(query);
    ServiceDetail _serviceDetail;
    List<ServiceDetail> _serviceDetails = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _serviceDetail=ServiceDetail.fromReqBody(subElement);
        _serviceDetail.printAttributes();

        _serviceDetails.add(_serviceDetail);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();
    //Возвращаем всех полученных пользователей
    return _serviceDetails;
  }

  @override
  Future<ServiceDetail> getServiceDetailByID(int service_detail_id) async {
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from service_detail where service_detail_id = $service_detail_id');
    print(query);

    //Нулевой объект
    ServiceDetail _servieDetail = ServiceDetail(service_detail_id: 0, type_id: 0, service_detail_code: '', servoce_detail_name: '', service_detail_cost: 0, service_detail_duration: 0);
    for (var element in query) {
      for (var subElement in element.values) {
        _servieDetail = ServiceDetail.fromReqBody(subElement);
        _servieDetail.printAttributes();
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    return _servieDetail;
  }

  @override
  Future<int> postServiceDetail(int type_id, String service_detail_code, String service_detail_name, int service_detail_cost, int service_detail_duration, String? add_info) async {
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery("INSERT INTO service_detail (type_id, service_detail_code, service_detail_name, service_detail_cost, service_detail_duration, add_info) "
        "VALUES ('$type_id', '$service_detail_code', '$service_detail_name','$service_detail_cost','$service_detail_duration','$add_info') RETURNING service_detail_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['service_detail_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    return id;
  }
}
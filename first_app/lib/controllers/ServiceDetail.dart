import 'package:first_app/models/ServiceDetail.dart';

import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/repository/ServiceDetail.dart';

class ServiceDetailController {
final ServiceDetailRepository _ServiceDetailRepository = ServiceDetailRepository(PionerDB());

PionerDB _pionerDB = PionerDB();

Future<List<Map<String, dynamic>>> getAllServiceDetail(String serviceValue) async{
  await _pionerDB.initDatabaseConnection();
  int Type;
  if (serviceValue=='Мойка'){
    Type = 1;
  }
  else {
    Type = 2;
  }
  List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from service_detail where type_id = $Type');
  print(query);
  Map<String, dynamic> _address;
  List<Map<String, dynamic>> _addresses = [];
  for (var element in query) {
    _address={'nameService': element['service_detail']['service_detail_name'], 'value': element['service_detail']['service_detail_cost'],'timeValue': element['service_detail']['service_detail_duration']};
    print(_address);
    _addresses.add(_address);
  }
  //Закрываем соединение с БД
  await _pionerDB.closeDatabaseConnection();

  return _addresses;
}



}
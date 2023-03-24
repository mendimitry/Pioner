import '../data/PionerDBContext.dart';
import '../models/ConnectionRequest.dart';
import 'AggregatorAdmin_Interface.dart';

class AggregatorAdminRepository implements IAggregatorAdminRepository {
  final PionerDB _pionerDB;

  AggregatorAdminRepository(this._pionerDB);

  Future<List<ConnectionRequest>> getAllAdminka() async {
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await _pionerDB.dbConnection
        .mappedResultsQuery('SELECT * from connection_request');
    print(query);
    ConnectionRequest _organization;
    List<ConnectionRequest> _organizations = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _organization = ConnectionRequest.fromReqBody(subElement);
        _organization.printAttributes();

        _organizations.add(_organization);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _organizations;
  }
}
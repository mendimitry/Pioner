import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/TypeOfService.dart';
import 'package:first_app/repository/TypeOfService_Interface.dart';

class TypeOfServiceRepository implements ITypeOfServiceRepository{
  final PionerDB _pionerDB;
  TypeOfServiceRepository(this._pionerDB);

  @override
  Future<List<TypeOfService>> getAllTypeOfService() async{
    await _pionerDB.initDatabaseConnection();

    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from type_of_service');
    print(query);

    TypeOfService _typeOfService;
    List<TypeOfService> _typeOfServices = [];

    for (var element in query) {
      for (var subElement in element.values) {
        _typeOfService=TypeOfService.fromReqBody(subElement);
        _typeOfService.printAttributes();

        _typeOfServices.add(_typeOfService);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    return _typeOfServices;
  }

  @override
  Future<TypeOfService> getTypeOfServiceByID(int type_id) async {
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from type_of_service where type_id = $type_id');
    print(query);

    //Нулевой объект
    TypeOfService _typeOfService = TypeOfService(type_id: 0, type_code: '', type_name: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _typeOfService = TypeOfService.fromReqBody(subElement);
        _typeOfService.printAttributes();
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    return _typeOfService;
  }

  @override
  Future<int> postTypeOfService(String type_code,String type_name) async {
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery("INSERT INTO type_service (type_code, type_name) VALUES ('$type_code', '$type_name') RETURNING type_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['type_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    return id;
  }
}
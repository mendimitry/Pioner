import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/AggregatorSpecialist.dart';
import 'package:first_app/repository/AggregatorSpecialist_Interface.dart';

class AggregatorSpecialistRepository implements IAggregatorSpecialistRepository{
  PionerDB _pionerDB;
  AggregatorSpecialistRepository(this._pionerDB);

  Future<List<AggregatorSpecialist>> getAllAggregatorSpecialists() async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from aggregator_specialist');
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialists;
  }

  Future<AggregatorSpecialist> getAggregatorSpecialistByID(int ID) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from aggregator_specialist where aggregator_specialists_id = $ID');
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialist;
  }

  Future<AggregatorSpecialist> getAggregatorSpecialistByPhoneNumber(String phoneNumber) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery("SELECT * from aggregator_specialist where aggregator_specialist_phone_number = '$phoneNumber'");
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialist;
  }

  Future<int> postAggregatorSpecialist(String aggregator_specialist_surname,String aggregator_specialist_name,
      String aggregator_specialist_department,String aggregator_specialist_position,String aggregator_specialist_phone_number, String? add_info) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery("INSERT INTO aggregator_specialist (aggregator_specialist_surname, aggregator_specialist_name, aggregator_specialists_department, aggregator_specialists_position, aggregator_specialists_phone_number, add_info) "
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных агрегаторов
    return id;
  }
}
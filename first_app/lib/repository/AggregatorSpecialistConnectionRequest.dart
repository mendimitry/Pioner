import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/AggregatorSpecialistConnectorRequest.dart';

class AggregatorSpecialistConnectionRequestRepository{
  PionerDB _pionerDB;
  AggregatorSpecialistConnectionRequestRepository(this._pionerDB);

  Future<List<AggregatorSpecialistConnectorRequest>> getAllAggregatorSpecialistConnectorRequest() async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from aggregator_specialist_connector_request');
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
    await _pionerDB.closeDatabaseConnection();

    return _aggregatorSpecialistConnectorRequests;
  }

  Future<AggregatorSpecialistConnectorRequest> getAggregatorSpecialistConnectorRequestByID(int ID) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from aggregator_specialist_connector_request where aggregator_specialist_connector_request_id = $ID');
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
    await _pionerDB.closeDatabaseConnection();

    return _aggregatorSpecialistConnectorRequest;
  }

  Future<AggregatorSpecialistConnectorRequest> getAggregatorSpecialistConnectorRequestByRequestID(int ID) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery("SELECT * from aggregator_specialist_connector_request where connection_request_id = '$ID'");
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _aggregatorSpecialistConnectorRequest;
  }

  Future<int> postAggregatorSpecialistConnectorRequest(int aggregator_specialists_id, int connection_request_id) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery("INSERT INTO aggregator_specialist_connector_request (aggregator_specialists_id, connection_request_id) VALUES ('$aggregator_specialists_id', '$connection_request_id') RETURNING aggregator_specialist_connector_request_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['aggregator_specialist_connector_request_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных агрегаторов
    return id;
  }
}
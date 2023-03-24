import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/repository/ConnectionRequest_Interface.dart';

class ConnectionRequestRepository implements IConnectionRequestRepository{
  PionerDB _pionerDB;
  ConnectionRequestRepository(this._pionerDB);

  @override
  Future<List<ConnectionRequest>> getAllConnectionRequest() async {
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from connection_request');
    //Нулевой объект
    ConnectionRequest _connectionRequest;
    List<ConnectionRequest> _conncetionRequests =[];
    for (var element in query) {
      for (var subElement in element.values) {
        _connectionRequest = ConnectionRequest.fromReqBody(subElement);
        _connectionRequest.printAttributes();

        _conncetionRequests.add(_connectionRequest);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _conncetionRequests;
  }

  @override
  Future<ConnectionRequest> getConnectionRequestByID(int organization_id) async {
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from connection_request where organization_id = ' + organization_id.toString());
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
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _connectionRequest;
  }

  @override
  Future<int> postConnectionRequest(int organization_id,String reg_number,DateTime date_begin,String status) async {
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery(
        "INSERT INTO connection_request (organization_id,reg_number,date_begin,status) VALUES ('$organization_id','$reg_number','$date_begin','$status') RETURNING connection_request_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['connection_request_id'];
        print(id);
      }
    }

    await _pionerDB.closeDatabaseConnection();
    return id;
  }
}
import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/AddressType.dart';
import 'package:first_app/repository/AddressType_Interface.dart';

class AddressTypeRepository implements IAddressTypeRepository{
  final PionerDB _pionerDB;
  AddressTypeRepository(this._pionerDB);

  @override
  Future<List<AddressType>> getAllAddressType() async{
    await _pionerDB.initDatabaseConnection();

    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from address_type');
    print(query);
    AddressType _addressType;
    List<AddressType> _addressTypes = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _addressType=AddressType.fromReqBody(subElement);
        _addressType.printAttributes();

        _addressTypes.add(_addressType);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();
    //Возвращаем всех полученных пользователей
    return _addressTypes;
  }

  @override
  Future<AddressType> getAddressTypeByID(int address_type_id) async {
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from address_type where address_type_id = $address_type_id');
    print(query);

    //Нулевой объект
    AddressType _addressType = AddressType(address_type_id: 0, address_type_name: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _addressType = AddressType.fromReqBody(subElement);
        _addressType.printAttributes();
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    return _addressType;
  }

  @override
  Future<int> postAddressType(String address_type_name, String? add_info) async {
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery("INSERT INTO address_type (address_type_name, add_info) VALUES ('$address_type_name', '$add_info') RETURNING address_type_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['address_type_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    return id;
  }
}
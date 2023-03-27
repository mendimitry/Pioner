import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/Address.dart';
import 'package:first_app/repository/Address_Interface.dart';

class AddressRepository implements IAddressRepository{
  final PionerDB _pionerDB;
  AddressRepository(this._pionerDB);

  @override
  Future<List<Address>> getAllAddresses() async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from address');
    print(query);
    Address _address;
    List<Address> _addresses = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _address=Address.fromReqBody(subElement);
        _address.printAttributes();

        _addresses.add(_address);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _addresses;
  }

  @override
  Future<List<Address>> getAllAddressesByOrganizationID(int organization_id) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from address where organization_id = $organization_id');
    print(query);
    Address _address;
    List<Address> _addresses = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _address=Address.fromReqBody(subElement);
        _address.printAttributes();

        _addresses.add(_address);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _addresses;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllCityFromAddresses() async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT DISTINCT city_name from address');
    print(query);
    Map<String, dynamic> _address;
    List<Map<String, dynamic>> _addresses = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _address={'city': subElement['city_name']};
        print(_address);
        _addresses.add(_address);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    return _addresses;
  }

  @override
  Future<int> postAddress(int organization_id,int address_type_id,String subject_name,String city_name,String street_name,String house_number,String? add_info)
  async {
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery(
        "INSERT INTO address (organization_id,address_type_id,subject_name,city_name,street_name,house_number,add_info) VALUES ('$organization_id','$address_type_id','$subject_name','$city_name','$street_name','$house_number','$add_info') RETURNING address_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['address_id'];
        print(id);
      }
    }

    await _pionerDB.closeDatabaseConnection();
    return id;
  }
}
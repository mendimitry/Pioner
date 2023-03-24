import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/Organization.dart';
import 'package:first_app/repository/Organization_Interface.dart';

class OrganizationRepository implements IOrganizationRepository{
  PionerDB _pionerDB;
  OrganizationRepository(this._pionerDB);

  @override
  Future<List<Organization>> getAllOrganization() async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from organization');
    print(query);
    Organization _organization;
    List<Organization> _organizations = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _organization=Organization.fromReqBody(subElement);
        _organization.printAttributes();

        _organizations.add(_organization);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _organizations;
  }

  @override
  Future<Organization> getOrganizationByID(int id) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery("SELECT * from organization where organization_id = '$id'");
    print(query);
    //Нулевой объект
    Organization _organization = Organization(organization_id: 0, inn: '', kpp: '', ogrn: '', responsible_person_phone_number: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _organization = Organization.fromReqBody(subElement);
        _organization.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _organization;
  }

  @override
  Future<Organization> getOrganizationByINNandOGRN(int inn, int ogrn) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery("SELECT * from organization where inn = '$inn' and ogrn='$ogrn'");
    print(query);
    //Нулевой объект
    Organization _organization = Organization(organization_id: 0, inn: '', kpp: '', ogrn: '', responsible_person_phone_number: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _organization = Organization.fromReqBody(subElement);
        _organization.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _organization;
  }

  @override
  Future<int> postOrganization(String organization_full_name,String organization_short_name,String inn,String kpp,String ogrn,String responsible_person_surname,String responsible_person_name,String responsible_person_patronymic, String responsible_person_email,String responsible_person_phone_number,String? add_info)
  async {
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery(
        "INSERT INTO organization (organization_full_name,organization_short_name,inn,kpp,ogrn,responsible_person_surname,responsible_person_name,responsible_person_patronymic, responsible_person_email,responsible_person_phone_number,add_info) VALUES ('$organization_full_name','$organization_short_name','$inn','$kpp','$ogrn','$responsible_person_surname','$responsible_person_name','$responsible_person_patronymic','$responsible_person_email','$responsible_person_phone_number','$add_info') RETURNING organization_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['organization_id'];
        print(id);
      }
    }

    await _pionerDB.closeDatabaseConnection();
    return id;
  }
}
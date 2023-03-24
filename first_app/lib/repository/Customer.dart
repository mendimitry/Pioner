import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/Customer.dart';
import 'package:first_app/repository/Customer_Interface.dart';

class CustomerRepository implements ICustomerRepository{
  PionerDB _pionerDB;
  CustomerRepository(this._pionerDB);

  @override
  Future<List<Customer>> getAllCustomers() async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from customer');
    print(query);
    Customer _customer;
    List<Customer> _customers = [];
    for (var element in query) {
      for (var subElement in element.values) {
        _customer=Customer.fromReqBody(subElement);
        _customer.printAttributes();

        _customers.add(_customer);
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _customers;
  }

  @override
  Future<Customer> getCustomerByID(int ID) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery('SELECT * from customer where customer_id = ' + ID.toString());
    print(query);
    //Нулевой объект
    Customer _customer = Customer(customer_id: 0, customer_phone_number: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _customer = Customer.fromReqBody(subElement);
        _customer.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _customer;
  }

  @override
  Future<Customer> getCustomerByPhoneNumber(String phoneNumber) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    //Получаем список всех пользователей
    var query = await _pionerDB.dbConnection.mappedResultsQuery("SELECT * from customer where customer_phone_number = '$phoneNumber'");
    print(query);
    //Нулевой объект
    Customer _customer = Customer(customer_id: 0, customer_phone_number: '');
    for (var element in query) {
      for (var subElement in element.values) {
        _customer = Customer.fromReqBody(subElement);
        _customer.printAttributes();
      }
    }
    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return _customer;
  }

  @override
  Future<int> postCustomer(String phoneNumber, String? name, String? surname) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    if (name == null || name == ""){
      name = "null";
    }
    if (surname == null || surname == ""){
      surname = "null";
    }

    var query = await _pionerDB.dbConnection.mappedResultsQuery("INSERT INTO customer (customer_surname, customer_name, customer_phone_number) VALUES ('$surname', '$name', '$phoneNumber') RETURNING customer_id;");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement['customer_id'];
        print(id);
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return id;
  }

  @override
  Future<int> deleteCustomer(String phoneNumber) async{
    //Подключаемся к БД
    await _pionerDB.initDatabaseConnection();

    var query = await _pionerDB.dbConnection.mappedResultsQuery("DELETE FROM customer WHERE customer_phone_number ='$phoneNumber';");
    print(query);

    int id = -1;

    for (var element in query) {
      for (var subElement in element.values) {
        id = subElement;
        print(id);
      }
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    //Возвращаем всех полученных пользователей
    return id;
  }
}
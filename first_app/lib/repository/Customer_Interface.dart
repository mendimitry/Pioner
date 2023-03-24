import 'package:first_app/models/Customer.dart';

abstract class ICustomerRepository{
  Future<List<Customer>> getAllCustomers();

  Future<Customer> getCustomerByID(int ID);

  Future<Customer> getCustomerByPhoneNumber(String phoneNumber);

  Future<int> postCustomer(String phoneNumber, String? name, String? surname);

  Future<int> deleteCustomer(String phoneNumber);
}
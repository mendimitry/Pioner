import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/Customer.dart';
import 'package:first_app/repository/Customer.dart';

class AutoUserRegisterPageController{
  CustomerRepository _customerRepository = CustomerRepository(PionerDB());

  Future<Customer> getCustomerByPhoneNumber(String phoneNumber) async {
    return _customerRepository.getCustomerByPhoneNumber(phoneNumber);
  }
}
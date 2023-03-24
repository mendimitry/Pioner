import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/Address.dart';
import 'package:first_app/models/AddressType.dart';
import 'package:first_app/models/ServiceDetail.dart';
import 'package:first_app/models/TypeOfService.dart';
import 'package:first_app/repository/Address.dart';
import 'package:first_app/repository/AddressType.dart';
import 'package:first_app/repository/ServiceDetail.dart';
import 'package:first_app/repository/TypeOfService.dart';

class ButtonController{
  final ServiceDetailRepository _serviceDetailRepository = ServiceDetailRepository(PionerDB());
  final AddressTypeRepository _addressTypeRepository = AddressTypeRepository(PionerDB());
  final TypeOfServiceRepository _typeOfServiceRepository = TypeOfServiceRepository(PionerDB());
  final AddressRepository _addressRepository = AddressRepository(PionerDB());

  Future<List<ServiceDetail>> getAllServiceDetails(){
    return _serviceDetailRepository.getAllServiceDetail();
  }

  Future<List<AddressType>> getAllAddressType(){
    return _addressTypeRepository.getAllAddressType();
  }

  Future<List<TypeOfService>> getAllTypeOfService(){
    return _typeOfServiceRepository.getAllTypeOfService();
  }

  Future<List<Address>> getAllAddresses(){
    return _addressRepository.getAllAddresses();
  }
}
import 'package:first_app/models/AddressType.dart';

abstract class IAddressTypeRepository{

  Future<List<AddressType>> getAllAddressType();
  Future<AddressType> getAddressTypeByID(int service_detail_id);
  Future<int> postAddressType(String address_type_name,String? add_info);
}
import 'package:first_app/models/Address.dart';

abstract class IAddressRepository{

  Future<List<Address>> getAllAddresses();

  Future<List<Address>> getAllAddressesByOrganizationID(int organization_id);

  Future<List<Map<String, dynamic>>> getAllCityFromAddresses();

  Future<int> postAddress(int organization_id,int address_type_id,String subject_name,String city_name,String street_name,String house_number,String? add_info);
}
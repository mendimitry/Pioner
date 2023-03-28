import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/pages/form_composition_services_car_wash/composition_services.dart';
import 'package:first_app/repository/Address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ChoosingOrganizationAddressController {
  PionerDB _pionerDB = PionerDB();
  final AddressRepository _addressRepository = AddressRepository(PionerDB());

  Future<List<Map<String, dynamic>>> getAllAddressFromCity(String city) async{
    await _pionerDB.initDatabaseConnection();

    List<Map<String, dynamic>> query = await _pionerDB.dbConnection.mappedResultsQuery("SELECT city_name, organization_short_name, street_name, house_number  from address, organization where city_name = '$city' and address.organization_id = organization.organization_id");
    print(query);
    Map<String, dynamic> _address;
    List<Map<String, dynamic>> _addresses = [];
    for (var element in query) {
        _address={'name': element['organization']['organization_short_name'], 'address': '${element['address']['street_name']} ${element['address']['house_number']}', 'city': element['address']['city_name']};
        print(_address);
        _addresses.add(_address);
    }

    //Закрываем соединение с БД
    await _pionerDB.closeDatabaseConnection();

    return _addresses;
  }

}

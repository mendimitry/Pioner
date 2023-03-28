import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/pages/form_composition_services_car_wash/composition_services.dart';
import 'package:first_app/repository/Address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ChoosingOrganizationController {
  final AddressRepository _addressRepository = AddressRepository(PionerDB());

  Future<List<Map<String, dynamic>>> getAllCityFromAddresses() async{
    return _addressRepository.getAllCityFromAddresses();
  }

}

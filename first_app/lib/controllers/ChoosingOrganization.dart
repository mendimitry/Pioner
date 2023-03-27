import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/pages/form_composition_services_car_wash/composition_services.dart';
import 'package:first_app/repository/Address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ChoosingOrganizationController {
  final AddressRepository _addressRepository = AddressRepository(PionerDB());

  String textFlex = 'Введите город';
  String cityText = '';
  String addressText = '';
  String nameText = '';
  List<Map<String, dynamic>> findList = [];
  List<String> cityFind = [];
  List<Map<String, dynamic>> _listType = [];
  List<Map<String, dynamic>> _resultAddress = []; // ВЫХОДНЫЕ ДАННЫЕ
  List<Map<String, dynamic>> _listCity = [];
  List<Map<String, dynamic>> _listOrganization = [];
  String _serviceValue = "";

  Container ListAdress(List<Map<String, dynamic>> _list) {
    return Container(


            );
  }


  }

// Выборо организации(Мойка)

import 'package:first_app/controllers/ChoosingOrganization.dart';
import 'package:first_app/pages/form_chooising_organization/choosing_orgznization_address.dart';
import 'package:first_app/pages/form_chooising_service/choosing_service.dart';
import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;




class ChoosingOrganization extends StatefulWidget {
  final String serviceValue;
  const ChoosingOrganization({super.key, required this.serviceValue});

  @override
  State<ChoosingOrganization> createState() => _ChoosingOrganization();
}
/*
List<Map<String, dynamic>> _listCityCarWash = [
  // ДАННЫЕ МОЙКИ
  {"city": "Самара"},
  {"city": "Москва"},
  {"city": "Саратов"},
];

List<Map<String, dynamic>> _listCityTireService = [
  // ДАННЫЕ ШИНОМОНТАЖКИ
  {"city": "Питер"},
  {"city": "Казань"},
  {"city": "Пенза"},
];
*/
ChoosingOrganizationController _choosingOrganizationController = ChoosingOrganizationController();
Future<List<Map<String, dynamic>>> cities = _choosingOrganizationController.getAllCityFromAddresses();

class _ChoosingOrganization extends State<ChoosingOrganization> {

  String textFlex = 'Введите город';
  List<Map<String, dynamic>> findList = [];
  List<String> cityFind = [];
  List<Map<String, dynamic>> _listCity = [];
  String _serviceValue = "";

  @override
  void initState() {
   _serviceValue = widget.serviceValue;
    // TODO: implement initState
    super.initState();
  }

  void _filterValue(String enteredKeyword, List<Map<String, dynamic>> _list) {
    List<Map<String, dynamic>> result = [];
      result = _list
          .where((element) => element["city"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    setState(() {
      findList = result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(children: <Widget>[
              transition(context),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        onChanged: (value) => _filterValue(value, _listCity),
                        decoration: InputDecoration(hintText: textFlex, suffixIcon: Icon(Icons.search)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListAdress(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ])),
      ),
      backgroundColor: Colors.grey,
    );
  }

  Container ListAdress() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 470,
        color: Colors.white10,
        child: FutureBuilder<List<Map<String,dynamic>>>(
            future: cities,
            builder: (context, snapshot){
              List<Map<String,dynamic>> city = snapshot.data ?? [];
              return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: city.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return listInformation(city, index);
                  });}));
  }

  Widget listInformation(List<Map<String, dynamic>> _list, int index) {
      return TextButton(
          onPressed: () {
            setState(() {
             // _resultAddress.add(findList[index]);
              print(_list[index]);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChoosingOrganizationAddress(serviceValue: _serviceValue, resultAddress: _list[index])));
            });
          },
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              _list[index]["city"].toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ));
    }

  Row transition(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Transform.rotate(
              angle: 180 * math.pi / 180,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChoosingServices()));
                  },
                  icon: const Icon(Icons.logout))),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: const Icon(Icons.logout))
        ]);
  }
}

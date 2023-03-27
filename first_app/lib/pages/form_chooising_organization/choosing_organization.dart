// Выборо организации(Мойка)

import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../form_chooising_service/choosing_service.dart';
import '../form_composition_services_car_wash/composition_services.dart';




class ChoosingOrganization extends StatefulWidget {
  final String serviceValue;
  const ChoosingOrganization({super.key, required this.serviceValue});

  @override
  State<ChoosingOrganization> createState() => _ChoosingOrganization();
}
List<Map<String, dynamic>> _listOrganizationCarWash = [
  // ДАННЫЕ МОЙКИ
  {"name": "АвтоМир", "address": "ул. Чекистов, д. 3"},
  {"name": "АвтоМssир", "address": "ул. Чекистов, д. 5"},
  {"name": "Авто", "address": "ул. Чекистов, д. 6"},
  {"name": "Автsdfо", "address": "ул. Чекистов, д. 6"},
];

List<Map<String, dynamic>> _listOrganizationTireService = [
  // ДАННЫЕ ШИНОМОНТАЖКИ
  {"name": "Автофыв", "address": "ул. выа, д. 3"},
  {"name": "Авфывр", "address": "ул. Чекиспатов, д. 5"},
  {"name": "Аывавы", "address": "ул. Чеавпавпкистов, д. 6"},
  {"name": "Авва", "address": "ул. авпап, д. 6"},
];

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

class _ChoosingOrganization extends State<ChoosingOrganization> {

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

  @override
  void initState() {
    _serviceValue = widget.serviceValue;
    if (_serviceValue == "Мойка") {
      _listCity = _listCityCarWash;
      _listOrganization = _listOrganizationCarWash;
    } else if (_serviceValue == "Шиномонтаж") {
      _listCity = _listCityTireService;
      _listOrganization = _listOrganizationTireService;
    }
    _listType = _listCity;
    findList = _listCity;
    // TODO: implement initState
    super.initState();
  }

  void _filterValue(String enteredKeyword, List<Map<String, dynamic>> _list) {
    List<Map<String, dynamic>> result = [];
    if (enteredKeyword.isEmpty) {
      result = _list;
    } else if (_listCity == _listType) {
      result = _list
          .where((element) => element["city"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    } else if (_listOrganization == _listType) {
      result = _list
          .where((element) => element["name"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textCity(),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        onChanged: (value) => _filterValue(value, _listType),
                        decoration: InputDecoration(
                            hintText: textFlex, suffixIcon: Icon(Icons.search)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListAdress(findList),
                    SizedBox(
                      height: 20,
                    ),
                    // buttonBackNext(context)
                  ],
                ),
              ),
            ])),
      ),
      backgroundColor: Colors.grey,
    );
  }

  Container ListAdress(List<Map<String, dynamic>> _list) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 470,
        color: Colors.white10,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              return listInformation(_list, index);
            }));
  }

  Widget listInformation(List<Map<String, dynamic>> _list, int index) {
    if (_listCity == _listType) {
      return TextButton(
          onPressed: () {
            setState(() {
              cityText = _list[index]["city"].toString();
              textFlex = "Введите адрес";
              _resultAddress.add(findList[index]);
              _listType = _listOrganization;
              findList = _listOrganization;
              _list = _listOrganization;
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
    } else {
      return TextButton(
          onPressed: () {
            setState(() {
              nameText = _list[index]["name"].toString();
              addressText = _list[index]["address"].toString();
              _resultAddress.add(findList[index]);
              print(_resultAddress); // _resultAddress нужно передать в push
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CompositionServices(resultAddress: _resultAddress, serviceValue: _serviceValue))); // ПЕРЕХОД НА СЛЕД. ФОРМУ
            });
          },
          child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                  title: Text(
                    _list[index]["name"].toString(), // НАЗВАНИЕ ОРГАНИЗАЦИИ
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    _list[index]["address"].toString(), // АДРЕС ОРГАНИЗАЦИИ
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic),
                  )

                  //  textAlign: TextAlign.right,
                  )));
    }
  }
  Row textCity() {
    return Row(
      children: [
        Text(
          "$cityText",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ],
    );
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

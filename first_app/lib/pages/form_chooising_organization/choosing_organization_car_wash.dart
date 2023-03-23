// Выборо организации(Мойка)

import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'dart:math' as math;
import 'package:first_app/pages/form_chooising_service/choosing_service.dart';
import 'package:first_app/pages/form_composition_services_car_wash/composition_services_car_wash.dart';

class ChoosingOrganizationCarWash extends StatefulWidget {
  const ChoosingOrganizationCarWash({super.key});

  @override
  State<ChoosingOrganizationCarWash> createState() =>
      _ChoosingOrganizationCarWash();
}

List<Map<String, dynamic>> _listOrganization = [
  {"name": "АвтоМир", "adress": "ул. Чекистов, д. 3"},
  {"name": "АвтоМssир", "adress": "ул. Чекистов, д. 5"},
  {"name": "Авто", "adress": "ул. Чекистов, д. 6"},
  {"name": "Автsdfо", "adress": "ул. Чекистов, д. 6"},
];

List<Map<String, dynamic>> _listCity = [
  {"city": "Самара"},
  {"city": "Москва"},
  {"city": "Саратов"},
];

class _ChoosingOrganizationCarWash extends State<ChoosingOrganizationCarWash> {
  bool _visibleButtonNext = false;

  String textFlex = 'Введите город';
  String cityText = '';
  String adresText = '';
  String nameText = '';
  List<Map<String, dynamic>> findList = [];
  List<String> cityFind = [];
  List<Map<String, dynamic>> _listType = [];
  List<Map<String, dynamic>> _resultAddress = []; // ВЫХОДНЫЕ ДАННЫЕ

  @override
  void initState() {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textCity(),
                    SizedBox(height: 15),
                    textOrganization(),
                    SizedBox(height: 15),
                    textAddress(),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextField(
                            onChanged: (value) =>
                                _filterValue(value, _listType),
                            decoration: InputDecoration(
                                hintText: textFlex,
                                suffixIcon: Icon(Icons.search)),
                          ),
                        ),
                      ],
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
    } else if (_listType == _listOrganization) {
      return TextButton(
          onPressed: () {
            setState(() {
              nameText = _list[index]["name"].toString();
              adresText = _list[index]["adress"].toString();
              _resultAddress.add(findList[index]);
              print(_list[index].toString());
              _visibleButtonNext = true;
              print(_resultAddress);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const CompositionServicesCarWash()));// ПЕРЕХОД НА СЛЕД. ФОРМУ
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
                    _list[index]["adress"].toString(), // АДРЕС ОРГАНИЗАЦИИ
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic),
                  )

                  //  textAlign: TextAlign.right,
                  )));
    } else
      return Text("data");
  }

  /* Row buttonBackNext(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _visibleButtonNext
              ? () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CompositionServicesCarWash()));
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26, fixedSize: const Size(150, 50)),
          child: const Text('Далее',
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }*/

  Text textAddress() {
    return Text(
      "Адрес: $adresText",
      style: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  Text textOrganization() {
    return Text(
      "Наименование оганизации: $nameText",
      style: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  Row textCity() {
    return Row(
      children: [
        Text(
          "Город: ",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Text(
          "$cityText",
          style: TextStyle(
            fontSize: 16,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChoosingSerice()));
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

//Уточнение состава услуги(Мойка)

import 'package:first_app/pages/form_chooising_organization/choosing_orgznization_address.dart';
import 'package:first_app/repository/ServiceDetail.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:first_app/controllers/ServiceDetail.dart';
import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/ServiceDetail.dart';
import 'package:first_app/pages/form_chooising_organization/choosing_organization.dart';
import 'package:first_app/pages/form_chooising_time/Choosing_time_service.dart';
import 'package:first_app/pages/form_login_page/login_page.dart';

import '../form_chooising_service/choosing_service.dart';

class CompositionServices extends StatefulWidget {
  Map<String, dynamic> resultAddress;
  String serviceValue;
  CompositionServices({super.key, required this.resultAddress, required this.serviceValue});

  State<CompositionServices> createState() => _CompositionServices();
}

ServiceDetailController _service = ServiceDetailController();
late Future<List<Map<String, dynamic>>> services;

class _CompositionServices extends State<CompositionServices> {
  /*
  final List<Map<String, dynamic>> _listServiceCarWash = [
    // как сделать так, чтобы у меня массив был динамическим??
    {"nameService": "Сезонная перекидка", "value": 500, "timeValue": 35},
    {"nameService": "Правка литых дисков", "value": 600, "timeValue": 15},
    {"nameService": "Правка стальных дисков", "value": 500, "timeValue": 10},
    {"nameService": "Дошиповка шин", "value": 300, "timeValue": 15},
    {"nameService": "Дошиповка шин", "value": 300, "timeValue": 15},
    {"nameService": "Дошиповка шин", "value": 300, "timeValue": 15}, // если указываю пустые массивы, крашиться страница со временем, надо сделать так чтобы страница со временем считывала данные из этой страницы но не массив Руса
  ];
  final List<Map<String, dynamic>> _listServiceTireService = [
    {"nameService": "Сезонная перекидка", "value": 500, "timeValue": 35},
    {"nameService": "Правка литых дисков", "value": 600, "timeValue": 15},
    {"nameService": "Правка стальных дисков", "value": 500, "timeValue": 10},
    {"nameService": "Дошиповка шин", "value": 300, "timeValue": 15},
  ];
   */

  List<Map<String, dynamic>> _listService = [];
  List<Map<String, dynamic>> _listTypeIsCheck = [];
  List<Map<String, dynamic>> _listServiceResult = [];
  late Map<String, dynamic> _resultAddress;

  String _textResult = "";
  String _textNameOrganization = "";
  num _resultValue = 0;
  bool isCheck = false;
  String _serviceValue = "";

  _resultValueCount(bool _isCheck, num _value) {
    if (_isCheck == true) {
      _resultValue += _value;
      return _resultValue;
    } else {
      _resultValue -= _value;
      return _resultValue;
    }
  }

  List<Map<String, dynamic>> _resultList(List<Map<String, dynamic>> _list, List<Map<String, dynamic>> _list2) {
    List<Map<String, dynamic>> _listResult = [];
    for (int i = 0; i < _listService.length; i++) {
      if (_list[i]["isCheck"] == true) {
        _listResult.add({
          "nameService": _listService[i]["nameService"],
          "timeValue": _listService[i]["timeValue"],
          "value": _listService[i]["value"]
        });
      }
    }
    print(_listResult);
    return _listResult;
  }

  List<Map<String, dynamic>> _list(list) {
    for (int i = 0; i < list.length; i++) {
      _listTypeIsCheck.add({
        "nameService": list[i]["nameService"],
        "timeValue": list[i]["timeValue"],
        "value": list[i]["value"],
        "isCheck": false
      });
    }
    return _listTypeIsCheck;
  }

  @override
  void initState() {
    _resultAddress = widget.resultAddress;
    print(_resultAddress);
    _serviceValue = widget.serviceValue;
    _textNameOrganization = widget.resultAddress["name"];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    services = _service.getAllServiceDetail();
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChoosingOrganizationAddress(resultAddress: _resultAddress, serviceValue: _serviceValue)));
                            },
                            icon: Icon(Icons.logout))),
                  ]),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: 15, left: 0, right: 0),
                        child: Center(
                          child: Text(
                            "$_serviceValue: $_textNameOrganization",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Итого: $_textResult",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListServices(),
                      buttonNext(context),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Container ListServices() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 470,
        color: Colors.white10,
        child: FutureBuilder <List<Map<String, dynamic>>>(
            future: services,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                // return: show loading widget
              }
              if (snapshot.hasError) {
                // return: show error widget
              }
              List<Map<String, dynamic>> list = snapshot.data ?? [];
              _listService = list;
              _listTypeIsCheck = _list(list);
              return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _listTypeIsCheck.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                  return listInfo(_listTypeIsCheck, index);
                  });
            }));
  }

  Widget listInfo(List<Map<String, dynamic>> service, int index){
    return  CheckboxListTile(
        checkColor: Colors.lightBlue,
        title: Text(service[index]['nameService']),
        controlAffinity: ListTileControlAffinity.leading,
        subtitle: Text("${service[index]['value']} RUB, ${service[index]['timeValue']} мин"),
        value: service[index]["isCheck"],
        onChanged: (bool? newcheck) {
          setState(() {
            service[index]["isCheck"] = newcheck!;
            _textResult = _resultValueCount(service[index]["isCheck"], service[index]['value'],).toString();
          });
        });
  }

  Padding buttonNext(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 0, left: 20, right: 20),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            _listServiceResult = _resultList(_listTypeIsCheck, _listService);
            print(
                _listServiceResult); // _listServiceResult нужно передать в push
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChoosingTimeService(
                        listServiceResult: _listServiceResult,
                        resultValue: _resultValue,
                        serviceValue: _serviceValue,
                        resultAddress: _resultAddress)));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26, fixedSize: const Size(300, 50)),
          child: const Text('Выбрать',
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

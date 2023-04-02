//Уточнение состава услуги(Мойка)

import 'package:first_app/repository/ServiceDetail.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../controllers/ServiceDetail.dart';
import '../../data/PionerDBContext.dart';
import '../../models/ServiceDetail.dart';
import '../form_chooising_organization/choosing_organization.dart';
import '../form_chooising_time/Choosing_time_service.dart';
import '../form_login_page/login_page.dart';

class CompositionServices extends StatefulWidget {
  Map<String, dynamic> resultAddress;
  String serviceValue;
  CompositionServices(
      {super.key, required this.resultAddress, required this.serviceValue});

  State<CompositionServices> createState() => _CompositionServices();
}

PionerDB _pionerDB = PionerDB();
ServiceDetailController _service = ServiceDetailController();
Future<List<Map<String, dynamic>>> cities = _service.getAllServiceDetail();

ServiceDetailRepository _service1 = ServiceDetailRepository(_pionerDB);
Future<List<ServiceDetail>> cities1 = _service1.getAllServiceDetail();

class _CompositionServices extends State<CompositionServices> {
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
  List<Map<String, dynamic>> _listService = [];
  List<Map<String, dynamic>> _listTypeIsCheck = [];
  List<Map<String, dynamic>> _listServiceResult = [];
  late Map<String, dynamic> _resultAddress;

  String _textResult = "";
  String _textResult1 = "";
  String _textResult2 = "";
  String _textResult3 = "";
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

  List<Map<String, dynamic>> _list() {
    for (int i = 0; i < _listService.length; i++) {
      _listTypeIsCheck.add({
        "nameService": _listService[i]["nameService"],
        "timeValue": _listService[i]["timeValue"],
        "value": _listService[i]["value"],
        "isCheck": false
      });
    }
    return _listTypeIsCheck;
  }

  List<Map<String, dynamic>> _resultList(
      List<Map<String, dynamic>> _list, List<Map<String, dynamic>> _list2) {
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

  @override
  void initState() {
    _resultAddress = widget.resultAddress;
    print(_resultAddress);
    _serviceValue = widget.serviceValue;
    _textNameOrganization = widget.resultAddress["name"];
    if (_serviceValue == "Мойка") {
      _listService =
          _listServiceCarWash; // без обьявления каких либо данных - услуги не показываются
    } else if (_serviceValue == "Шиномонтаж") {
      _listService = _listServiceTireService;
    }
    _list();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                      builder: (context) => LoginPage()));
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
        child: FutureBuilder<List<ServiceDetail>>(
            future: cities1,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                // return: show loading widget
              }
              if (snapshot.hasError) {
                // return: show error widget
              }
              List<ServiceDetail> users = snapshot.data ?? [];

              return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: users.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    final service = _listTypeIsCheck[index];
                    ServiceDetail user = users[index];
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CheckboxListTile(
                          checkColor: Colors.lightBlue,
                          title: Text(user.servoce_detail_name),
                          controlAffinity: ListTileControlAffinity.leading,
                          subtitle: Text(
                              "${user.service_detail_cost} RUB, ${user.service_detail_duration} мин"),
                          value: service["isCheck"],
                          onChanged: (bool? newcheck) {
                            setState(() {
                              service["isCheck"] = newcheck!;
                              _textResult = _resultValueCount(
                                _listTypeIsCheck[index]["isCheck"],
                                user.service_detail_cost,
                              ).toString();

                            });
                          }),
                    );
                  });
            }));
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

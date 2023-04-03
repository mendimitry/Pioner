import 'package:first_app/pages/form_end/record_confirmation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:first_app/pages/form_composition_services_car_wash/composition_services.dart';
import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';

import 'package:first_app/pages/form_chooising_service/choosing_service.dart';

class ChoosingTimeService extends StatefulWidget {
  Map<String, dynamic> resultAddress;
  List<Map<String, dynamic>> listServiceResult;
  String serviceValue;
  num resultValue;

  ChoosingTimeService(
      {super.key,
      required this.listServiceResult,
      required this.resultAddress,
      required this.serviceValue,
      required this.resultValue});

  State<ChoosingTimeService> createState() => _ChoosingTimeService();
}

class _ChoosingTimeService extends State<ChoosingTimeService> {
  num _valueTime = 0;
  var _listTime;
  var _indexTimes = 0;
  String _resultTime = "";
  String _days = "Сегодня";
  List<Map<String, dynamic>> _listServiceResult = [];
  String _serviceValue = "";
  num _resultValue = 0;
  List<Map<String, dynamic>> _listService = [];
  late Map<String, dynamic> _resultAddress;
  String _addressText = '';
  String _nameText = '';
  void _resultValueTime() {
    for (int i = 0; i < _listService.length; i++) {
      _valueTime += _listService[i]["timeValue"];
    }

  }

  void _resultValueName() {
    for (int i = 0; i < _listService.length; i++) {
      _serviceValue += _listService[i]["nameService"];
    }

  }


  final _timesTodayCarWash = [
    "11:20",
    "13:40",
    "14:20",
    "15:40",
    "16:25",
    "11:20",
    "13:40",
    "14:20",
    "15:40",
    "16:25"
  ];
  final _timesTomorrowCarWash = [
    "11:25",
    "12:40",
    "14:20",
    "15:40",
    "16:25",
    "15:40",
    "16:25",
    "11:20",
    "13:40",
    "14:20",
    "14:20",
    "14:20",
  ];
  final _timesTomorrowTireService = [
    "11:",
    "12:0",
    "14:20",
    "15:0",
    "16:25",
    "15:40",
    "16:25",
    "11:20",
    "13:40",
    "14:20",
    "14:20",
    "14:20",
  ];
  final _timesTodayTireService = [
    "11:20",
    "13:10",
    "14:10",
    "15:10",
    "16:15",
    "11:10",
    "13:10",
    "14:10",
    "15:10",
    "16:15"
  ];
  var _timesToday = [];
  var _timesTomorrow = [];

  @override
  void initState() {
    _resultAddress = widget.resultAddress;
    _listService = widget.listServiceResult;
    _serviceValue = widget.serviceValue;
    _resultValue = widget.resultValue;
    _addressText = _resultAddress["address"];
    _nameText = _resultAddress["name"];
    if (_serviceValue == "Мойка") {
      _timesToday = _timesTodayCarWash;
      _timesTomorrow = _timesTomorrowCarWash;
    } else if (_serviceValue == "Шиномонтаж") {
      _timesToday = _timesTodayTireService;
      _timesTomorrow = _timesTomorrowTireService;
    }
    _resultValueTime();
    _resultValueName();
    _listTime = _timesToday;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            builder: (context) => ChoosingServices()));
                                  },
                                  icon: Icon(Icons.logout))),

                        ]),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            location(),
                            SizedBox(height: 12),
                            ListService(),
                            Divider(
                              color: Colors.black,
                            ),
                            ResultRow(),
                            SizedBox(
                              height: 10,
                            ),
                            ButtonDays(),
                            Center(
                                child: Text(
                              "Время записи",
                              style: TextStyle(fontSize: 18),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: ListTime(_listTime),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ButtonNext(context),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ))
                  ]))),
    );
  }









  Center ButtonNext(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _resultTime = _listTime[_indexTimes];
          print(_resultTime); // _resultTime и _days нужно передать в push
          print(_days);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecordConfirmation(resultAddress: _resultAddress, listService: _listService, serviceValue: _serviceValue, days: _days, resultTime: _resultTime)));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black26, fixedSize: Size(300, 50)),
        child: Text('Выбрать',
            style: TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center),
      ),
    );
  }










  ListView location() {
    return ListView(shrinkWrap: true, padding: EdgeInsets.zero, children: [
      Text(
        _nameText,
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 5),
      Text(
      _addressText,
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 12),
      Text(
        "Услуги:",
        style: TextStyle(fontSize: 18),
      ),
    ]);
  }

  Row ButtonDays() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
            onPressed: () {
              setState(() {
                if (_listTime == _timesTomorrow) {
                  _listTime = _timesToday;
                  _days = "Сегодня";
                }
              });
            },
            child: Text(
              "Сегодня",
              style: TextStyle(fontSize: 22, color: Colors.indigo),
            )),
        TextButton(
            style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
            onPressed: () {
              setState(() {
                if (_listTime == _timesToday) {
                  _listTime = _timesTomorrow;
                  _days = "Завтра";
                }
              });
            },
            child: Text("Завтра",
                style: TextStyle(fontSize: 22, color: Colors.indigo)))
      ],
    );
  }

  Row ResultRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Итого",
          style: TextStyle(fontSize: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "$_resultValue RUB",
              style: TextStyle(
                  height: 1.2 ,// the height between text, default is null
                  letterSpacing: -0.9 // the white space between letter, default is 0.0/You can set your custom height here
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "$_valueTime мин",
              style: TextStyle(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }

  Container ListTime(var _listTime) {
    return Container(
      width: 180,
      height: 380,
      color: Colors.black12,
      child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            FlutterRadioGroup(
                titleStyle: TextStyle(fontSize: 22),
                activeColor: Colors.blue,
                titles: _listTime,
                defaultSelected: _indexTimes,
                onChanged: (index) {
                  setState(() {
                    _indexTimes = index!;
                  });
                })
          ]),
    );
  }



  ListView ListService() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: _listService.length,
        itemBuilder: (BuildContext context, int index) {
          final service = _listService[index];
          return ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text((index + 1).toString() + "."),

                        Text(
                          service["nameService"],
                            style: TextStyle(fontSize: 10 ,fontWeight:FontWeight.bold,color: Colors.black) , )

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${service["value"]} RUB",
                            style: TextStyle(
                                height: 1.2 ,// the height between text, default is null
                                letterSpacing: -0.9 // the white space between letter, default is 0.0/You can set your custom height here
                            ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${service["timeValue"]} мин",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                )
              ]);
        });
  }
}

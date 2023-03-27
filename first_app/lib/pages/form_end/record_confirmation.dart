import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordConfirmation extends StatefulWidget {
  List<Map<String, dynamic>> resultAddress;
  List<Map<String, dynamic>> listService;
  String serviceValue;
  String days;
  String resultTime;
  RecordConfirmation(
      {super.key,
        required this.listService,
        required this.resultAddress,
        required this.serviceValue,
        required this.resultTime,
        required this.days});
  State<RecordConfirmation> createState() => _RecordConfirmation();
}

class _RecordConfirmation extends State<RecordConfirmation> {
  List<Map<String, dynamic>> _resultAddress = []; // {годод, название орг-ции, адрес}
  List<Map<String, dynamic>> _listService = []; // Лист услуг
  String _serviceValue =""; // {Мойка, шинка}
  String _days ="";
  String _resultTime ="";
  List<Map<String, dynamic>> listResult = []; // выходные данные в бд
  @override
  void initState() {
    _resultAddress = widget.resultAddress;
    _listService = widget.listService;
    _serviceValue = widget.serviceValue;
    _days = widget.days;
    _resultTime = widget.resultTime;
    listResult = [
      {"name": _resultAddress[0]["name"], "address": _resultAddress[0]["address"],"city": _resultAddress[0]["city"], "days": _days, "time": _resultTime, "serviceValue": _serviceValue},
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
          child: Container(
              padding: EdgeInsets.only(left: 80, right: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Ждем вас " +
                        _days +
                        " в " +
                        _resultTime +
                        " в " +
                        _resultAddress[0]["name"].toString() +
                        " по адресу: " +
                        _resultAddress[0]["address"].toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  IconButton(
                      iconSize: 150,
                      onPressed: () {
                        print(listResult);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      icon: Icon(Icons.task_alt_outlined))
                ],
              ))),
    );
  }
}

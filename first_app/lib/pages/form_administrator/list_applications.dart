import 'package:first_app/controllers/ListApplication.dart';
import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/pages/form_administrator/user_administrator.dart';
import 'package:first_app/pages/form_chooising_service/choosing_service.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:first_app/controllers/ConnectingOrganization.dart';
import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/pages/form_organization/connecting_organization.dart';
import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:first_app/pages/form_organization/organization_register.dart';

class ListApplication extends StatefulWidget {
  const ListApplication({super.key});

  @override
  State<ListApplication> createState() => _ListApplication();
}

PionerDB pionerDB = PionerDB();
final TextEditingController regNumberTextController = TextEditingController();
final TextEditingController DateCreateTextController = TextEditingController();
final TextEditingController kratkoeTextController = TextEditingController();
ListApplicationController _listApplicationController = ListApplicationController();

Future<List<ConnectionRequest>> usersFuture = _listApplicationController.getAllConnectionRequest();

var listStatus = [
  "НОВАЯ",
  "В РАБОТЕ",
  "ИСПОЛНЕНА",
  "ОТКЛОНЕНА",
];

String listStatusValue = listStatus.first;
Future? _future;

@override
void initState() {}

class _ListApplication extends State<ListApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(children: <Widget>[
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
                    child: Container(
                      color: Colors.white38,
                      child: Padding(
                          padding:
                          EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Column(children: [
                            Row(
                              children: [
                                Text("Текущий статус: ",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54)),
                                DropdownButton<String>(
                                  value: listStatusValue,
                                  underline: Container(
                                    height: 1,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  items: listStatus
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      listStatusValue = value!;
                                    });
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 340,
                              child: Column(
                                children: [
                                  Container(
                                      width: 340,
                                      height: 50,
                                      color: Colors.white24,
                                      child: const Center(
                                        child: Text(
                                          "Список форм в выбранном статусе",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      )),
                                  Container(
                                      child: Table(
                                        border: TableBorder.symmetric(
                                            inside: BorderSide(
                                                width: 1, color: Colors.black)),
                                        columnWidths: const <int, TableColumnWidth>{
                                          0: FixedColumnWidth(40),
                                          1: FixedColumnWidth(200),
                                        },
                                        children: [
                                          TableRow(
                                              decoration: BoxDecoration(
                                                  color: Colors.black12),
                                              children: [
                                                Container(
                                                  // color: Colors.white,
                                                  height: 60,
                                                  child: Text(
                                                    "Рег. №",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Container(
                                                  //  color: Colors.white,
                                                  height: 60,
                                                  child: Text("Дата создания",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white)),
                                                ),
                                                Container(
                                                  // color: Colors.white,
                                                  height: 60,
                                                  child: Text(
                                                      "Краткое\n"
                                                          "наим. -е\nорганизации",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white)),
                                                ),
                                              ])
                                        ],
                                      )),
                                  _listApplicationController.list_organization()
                                ],
                              ),
                            ),
                          ])),
                    ),
                  )
                ]))));
  }
}


import 'package:first_app/pages/form_administrator/user_administrator.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../data/PionerDBContext.dart';
import '../form_organization/connecting_organization.dart';
import '../login_page.dart';

class ListApplication extends StatefulWidget {
  const ListApplication({super.key});

  @override
  State<ListApplication> createState() => _ListApplication();
}

  PionerDB pionerDB = PionerDB();
  final TextEditingController regNumberTextController = TextEditingController();
  final TextEditingController DateCreateTextController = TextEditingController();
  final TextEditingController kratkoeTextController = TextEditingController();


var status = [
  "НОВАЯ",
  "В РАБОТЕ",
  "ИСПОЛНЕНА",
  "ОТКЛОНЕНА",
];

var organization1 = [
  "1",
  "08.03.2023",
  "Белый лед",
];
var organization2 = [
  "2",
  "18.01.2023",
  "Ласточка",
];
var organization3 = [
  "3",
  "26.04.2023",
  "Каприз",
];
var mass = [organization1, organization2, organization3];


class _ListApplication extends State<ListApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(children: <Widget>[
              transition(context),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    children: [
                      Container(
                          width: 340,
                          height: 50,
                          color: Colors.white24,
                          child: const Center(
                            child: Text(
                              "Фильтр по значению статуса",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                      Container(
                          width: 340,
                          height: 200,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                          color: Colors.white38,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: status.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          status[index],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                              fontStyle: FontStyle.italic),
                                          textAlign: TextAlign.right,
                                        )));
                              })),
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
                                0: FixedColumnWidth(70),
                                1: FixedColumnWidth(100),
                              },
                              children: [
                                TableRow(
                                    decoration:
                                        BoxDecoration(color: Colors.black12),
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
                            list_organization()
                          ],
                        ),
                      )
                    ],
                  ))
            ])),
      ),
      backgroundColor: Colors.grey,
    );
  }

  Container list_organization() {
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: mass.length,
            itemBuilder: (context, index) {
              var vector = mass[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Table(
                    border: TableBorder(
                        top: BorderSide(width: 1, color: Colors.black)),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(70),
                      1: FixedColumnWidth(100),
                    },
                    children: [
                      TableRow(
                          decoration: BoxDecoration(color: Colors.white),
                          children: [
                            Container(
                                // color: Colors.white,b
                                height: 40,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    vector[0],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                )),
                            Container(
                                // color: Colors.white,
                                height: 40,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    vector[1],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                )),
                            Container(
                                // color: Colors.white,
                                height: 40,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    vector[2],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                )),
                          ])
                    ],
                  ),
                ],
              );
            }));
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
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(Icons.logout))),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserAdministrator()));
              },
              icon: Icon(Icons.logout))
        ]);
  }
}

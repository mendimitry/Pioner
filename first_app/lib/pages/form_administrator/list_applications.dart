import 'package:first_app/pages/form_administrator/user_administrator.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../login_page.dart';

class ListApplication extends StatefulWidget {
  const ListApplication({super.key});

  @override
  State<ListApplication> createState() => _ListApplication();
}

var status = [
  "НОВАЯ",
  "В РАБОТЕ",
  "ИСПОЛНЕНА",
  "ОТКЛОНЕНА",
];

var organization1 = [
  "08.03.2023",
  "Белый лед",
];
var organization2 = [
  "18.01.2023",
  "Ласточка",
];

class _ListApplication extends State<ListApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child:
        Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(children: <Widget>[
              transition(context),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.white24,
                          child: const Center(
                            child: Text(
                              "Фильтр по значению статуса",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                      Container(
                          height: 225,
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                          color: Colors.white38,
                          child: ListView.builder(
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
                                          ),
                                          textAlign: TextAlign.right,
                                        )));
                              })),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                color: Colors.white24,
                                child: const Center(
                                  child: Text(
                                    "Список форм в выбранном статусе",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: 120,
                                  height: 50,
                                  child: Text("data"),
                                ),
                                Container(
                                  color: Colors.white,
                                  width: 120,
                                  height: 50,
                                  child: Text("data"),
                                ),
                                Container(
                                  color: Colors.white,
                                  width: 120,
                                  height: 50,
                                  child: Text("data"),
                                ),
                              ],
                            ),
                            // ListView.builder(
                            //     itemCount: city.length,
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return Container(
                            //         // height: 50,
                            //           child: TextButton(
                            //               onPressed: () {
                            //                 setState(() {
                            //                   _visibleCity = false;
                            //                   _visibleAdress = true;
                            //                 });
                            //               },
                            //               child: Align(
                            //                   alignment: Alignment.bottomLeft,
                            //                   child: Text(
                            //                     city[index],
                            //                     style: TextStyle(
                            //                       fontSize: 16,
                            //                       color: Colors.black87,
                            //                     ),
                            //                     textAlign: TextAlign.right,
                            //                   ))));
                            //     })
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserAdministrator()));
              },
              icon: Icon(Icons.logout))
        ]);
  }
}

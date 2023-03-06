// Выборо организации(Мойка)

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'choosing_service.dart';
import 'composition_services_car_wash.dart';

class ChoosingOrganizationCarWash extends StatefulWidget {
  const ChoosingOrganizationCarWash({super.key});

  @override
  State<ChoosingOrganizationCarWash> createState() =>
      _ChoosingOrganizationCarWash();
}

var city = [
  "Самара",
  "Москва",
  "Саратов",
  "Казань",
  "Уфа",
  "Челябинск",
  "Сызрань",
  "Нижний-Новгород",
  "Самара",
  "Москва",
  "Саратов",
  "Казань",
  "Уфа",
  "Челябинск",
  "Сызрань",
  "Нижний-Новгород"
];
var adress = [
  "ул. Чекистов, д. 3",
  "ул. Стара-Загора, д. 5",
  "ул. Карла-Маркса, д. 19"
];
bool _visibleCity = true;
bool _visibleAdress = false;

class _ChoosingOrganizationCarWash extends State<ChoosingOrganizationCarWash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(children: <Widget>[
            transition(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Введите город',
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Введите адрес',
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.search))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListCity(),
                  ListAdress()
                ],
              ),
            ),
          ])),
      backgroundColor: Colors.grey,
    );
  }

  Visibility ListCity() {
    return Visibility(
        maintainAnimation: true,
        maintainState: true,
        visible: _visibleCity,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 500,
            color: Colors.black12,
            child: ListView.builder(
                itemCount: city.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // height: 50,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              _visibleCity = false;
                              _visibleAdress = true;
                            });
                          },
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                city[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.right,
                              ))));
                })));
  }

  Visibility ListAdress() {
    return Visibility(
        maintainAnimation: true,
        maintainState: true,
        visible: _visibleAdress,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 500,
            color: Colors.black12,
            child: ListView.builder(
                itemCount: adress.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // height: 50,
                      child: TextButton(
                          onPressed: () {},
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                adress[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.right,
                              ))));
                })));
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const CompositionServicesCarWash()));
              },
              icon: const Icon(Icons.logout))
        ]);
  }
}

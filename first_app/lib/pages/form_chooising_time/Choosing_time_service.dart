import 'dart:async';
import 'package:first_app/data/composition_of_services.dart';
import 'package:first_app/pages/form_end/record_confirmation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:first_app/models/service.dart';
import '../form_chooising_organization/choosing_organization_car_wash.dart';
import '../form_composition_services_car_wash/composition_services_car_wash.dart';
import '../form_login_page/login_page.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';

class ChoosingTimeService extends StatefulWidget {
  const ChoosingTimeService({super.key});

  State<ChoosingTimeService> createState() => _ChoosingTimeService();
}

var _timesToday = [
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
var _timesTomorrow = [
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
];
var _indexTimesToday = 0;
var _indexTimesTomorrow = 0;
bool _visibleToday = true;
bool _visibleTomorrow = false;

class _ChoosingTimeService extends State<ChoosingTimeService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body:
      SingleChildScrollView(
          child:
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    transition(context),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            location(),
                            SizedBox(height: 12),
                            TextInformation(),
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
                            Row(
                              children: [ListTimsToday(), ListTimsToomorrow()],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ButtonNext(context),
                          ],
                        ))
                  ]))
      ),
    );
  }

  Center ButtonNext(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecordConfirmation()));
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
    return ListView(shrinkWrap: true, children: [
      Text(
        "Авангард",
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 5),
      Text(
        "Походный проезд д.10",
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
                if (_visibleToday == false) {
                  _visibleTomorrow = !_visibleTomorrow;
                  _visibleToday = !_visibleToday;
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
                if (_visibleTomorrow == false) {
                  _visibleTomorrow = !_visibleTomorrow;
                  _visibleToday = !_visibleToday;
                }
              });
            },
            child: Text("Завтра",
                style: TextStyle(fontSize: 22, color: Colors.indigo)))
      ],
    );
  }

  ListView TextInformation() {
    return ListView(
      // scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Мойка днища",
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "200 RUB",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10,),
                Text(
                  "20 мин",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )

          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Мойка двигателя",
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "250 RUB",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10,),
                Text(
                  "15 мин",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )

          ],
        ),
        Divider(
          color: Colors.black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Итого",
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "450 RUB",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10,),
                Text(
                  "35 мин",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )

          ],
        ),
      ],
    );
  }

  Visibility ListTimsToday() {
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _visibleToday,
        child: Container(
          width: 180,
          height: 400,
          color: Colors.black12,
          child: (ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              FlutterRadioGroup(
                  titleStyle: TextStyle(fontSize: 22),
                  activeColor: Colors.blue,
                  titles: _timesToday,
                  defaultSelected: _indexTimesToday,
                  onChanged: (index) {
                    setState(() {
                      _indexTimesToday = index!;
                    });
                  })
            ],
          )),
        ));
  }

  Visibility ListTimsToomorrow() {
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _visibleTomorrow,
        child: Container(
          width: 180,
          height: 400,
          color: Colors.black12,
          child: (ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                FlutterRadioGroup(
                    titleStyle: TextStyle(fontSize: 22),
                    activeColor: Colors.blue,
                    titles: _timesTomorrow,
                    defaultSelected: _indexTimesTomorrow,
                    onChanged: (index) {
                      setState(() {
                        _indexTimesTomorrow = index!;
                      });
                    })
              ])),
        ));
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
                            builder: (context) =>
                                CompositionServicesCarWash()));
                  },
                  icon: Icon(Icons.logout))),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout))
        ]);
  }
}

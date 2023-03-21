//Уточнение состава услуги(Мойка)

import 'dart:async';
import 'package:first_app/data/composition_of_services.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:first_app/models/service.dart';
import 'Choosing_time_service.dart';
import 'choosing_organization_car_wash.dart';
import 'login_page.dart';
import 'dart:convert';

class CompositionServicesCarWash extends StatefulWidget {
  const CompositionServicesCarWash({super.key});

  State<CompositionServicesCarWash> createState() =>
      _CompositionServicesCarWash();
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

class _CompositionServicesCarWash extends State<CompositionServicesCarWash> {
  Future<List<Service>> getServicesFromJSON() async {
    return await Future.delayed(const Duration(seconds: 0), () {
      List<dynamic> data = jsonDecode(jsonString);
      List<Service> services =
      data.map((dynamic data) => Service.fromJSON(data)).toList();
      return services;
    });
  }

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
            children: <Widget>[
              transition(context),
              const Padding(
                padding: EdgeInsets.only(top: 0, bottom: 15, left: 0, right: 0),
                child: Center(
                  child: Text(
                    "МОЙКА: Авангард",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
                  child: Text(
                    "Итого:",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListChoosing(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 0, left: 20, right: 20),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChoosingTimeService()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26,
                        fixedSize: const Size(300, 50)),
                    child: const Text('Выбрать',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  Container ListChoosing() {
    return Container(
      width: 500,
      height: 570,
      child: FutureBuilder<List<Service>>(
        future: getServicesFromJSON(),
        builder: (context, dynamic data) {
          if (data.hasData) {
            var serviceList = data.data;
            bool? check = false;
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 20, right: 20),
                itemCount: serviceList.length,
                itemBuilder: (context, index) {
                  var serviceData = serviceList[index];
                  CheckBoxState check = CheckBoxState(
                      name: serviceData.name,
                      time: serviceData.time,
                      value: serviceData.value);

                  return Container(
                      color: Colors.black12,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 0, right: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CheckboxListTile(
                                  title: Text("${index + 1}. ${check.name}"),
                                  controlAffinity:
                                  ListTileControlAffinity.leading,
                                  subtitle: Text(
                                      "${serviceData.value} RUB, ${serviceData.time} мин"),
                                  value: check.isChecked,
                                  // value: check.isChecked,
                                  onChanged: (bool? newcheck) {
                                    setState(() {
                                      check.isChecked = newcheck;
                                    });
                                  })
                            ],
                          )));
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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
                            builder: (context) =>
                            const ChoosingOrganizationCarWash()));
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
// Widget buildSingleCheckBox(CheckBoxState checkBox) => CheckboxListTile(
//     title: Text(checkBox.title),
//     value: checkBox.value,
//     onChanged: (value) => setState(() {
//       checkBox.value = value!;
//       }
//       )
//     );
}

class CheckBoxState {
  final String name;
  final int value, time;
  bool? isChecked;

  CheckBoxState(
      {required this.name,
        required this.time,
        this.isChecked = false,
        required this.value});
}

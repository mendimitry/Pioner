// Выбор услуги

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'auto_user_register_page.dart';
import 'choosing_organization_car_wash.dart';
import 'choosing_organization_tire_service.dart';

enum services { car_wash, tire_service }

class ChoosingSerice extends StatefulWidget {
  const ChoosingSerice({super.key});

  @override
  State<ChoosingSerice> createState() => _ChoosingSerice();
}

class _ChoosingSerice extends State<ChoosingSerice> {
  services? _service = services.car_wash;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(children: <Widget>[
              transition(context),
              Padding(padding: EdgeInsets.only(top: 25)),
              Container(
                constraints: BoxConstraints.tightFor(width: 325, height: 600),
                color: const Color.fromRGBO(255, 228, 225, 0.6),
                child: Column(children: [
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Text('Услуги',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  RadioCarWash(),
                  RadioTireService(),
                  Padding(padding: EdgeInsets.only(top: 300)),
                  ButtonChoosingService(context),
                ]),
              ),
            ])),
      ),
      backgroundColor: Colors.grey,
    );
  }

  ElevatedButton ButtonChoosingService(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (_service == services.car_wash) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChoosingOrganizationCarWash()));
          } else
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChoosingOrganizationTireService()));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black26, fixedSize: Size(300, 50)),
        child: Text('Выбрать услугу',
            style: TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center));
  }

  ListTile RadioTireService() {
    return ListTile(
      title: const Text('Шиномонаж'),
      leading: Radio<services>(
        value: services.tire_service,
        groupValue: _service,
        onChanged: (services? value) {
          setState(() {
            _service = value;
          });
        },
      ),
    );
  }

  ListTile RadioCarWash() {
    return ListTile(
      title: const Text('Мойка'),
      leading: Radio<services>(
        value: services.car_wash,
        groupValue: _service,
        onChanged: (services? value) {
          setState(() {
            _service = value;
          });
        },
      ),
    );
  }

  Align transition(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            icon: Icon(Icons.logout)));
  }
}

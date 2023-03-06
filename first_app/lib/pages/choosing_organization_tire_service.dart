// Выборо организации(Шиномонтаж)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'auto_user_register_page.dart';
import 'choosing_service.dart';
import 'login_page.dart';

class ChoosingOrganizationTireService extends StatefulWidget {
  const ChoosingOrganizationTireService({super.key});

  @override
  State<ChoosingOrganizationTireService> createState() =>
      _ChoosingOrganizationTireService();
}

class _ChoosingOrganizationTireService
    extends State<ChoosingOrganizationTireService> {
  @override
  Widget build(BuildContext context) {
    bool check = false;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(children: <Widget>[
            transition(context),
          ])),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChoosingSerice()));
                  },
                  icon: Icon(Icons.logout))),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout))
        ]);
  }
}

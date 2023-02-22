// Выборо организации(Мойка)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'choosing_service.dart';
import 'login_page.dart';

class ChoosingOrganizationCarWash extends StatefulWidget {
  const ChoosingOrganizationCarWash({super.key});

  @override
  State<ChoosingOrganizationCarWash> createState() => _ChoosingOrganizationCarWash();
}

class _ChoosingOrganizationCarWash extends State<ChoosingOrganizationCarWash>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Transform.rotate(angle: 180 * math.pi / 180,
                          child: IconButton(
                              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosingSerice()));}, icon: Icon(Icons.logout))),
                      IconButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));}, icon: Icon(Icons.logout))
                    ]
                )
              ]
          )
      ),
      backgroundColor: Colors.grey,
    );
  }
}
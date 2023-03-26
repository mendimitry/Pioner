import 'package:first_app/controllers/Button.dart';
import 'package:first_app/models/Customer.dart';
import 'package:flutter/material.dart';
import 'package:first_app/data/PionerDBContext.dart';

import '../controllers/ConnectingOrganization.dart';
import 'form_login_page/login_page.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _Button();
}
ButtonController _buttonController = ButtonController();

ConnectingOrganizationController _connectingOrganizationController = ConnectingOrganizationController();

class _Button extends State<Button> {
  PionerDB pionerDB = PionerDB();
  late Future<List<Customer>> customers;
  String data = "null";
  int ID = 2;
  String phoneNumber = "89140213561";
  String name = "Боба";
  String surname = "Абобав";
  String phoneNumber2 = "89123456789";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(children: <Widget>[
            transition(context),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {_connectingOrganizationController.getAllConnectionRequest();
                                },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('Получить пользователей',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {_connectingOrganizationController.getConnectionRequestByID(66);},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('Получить пользователя с ID 2',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('Получить пользователя по номеру телефона',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ))
          ])),
      backgroundColor: Colors.grey,
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

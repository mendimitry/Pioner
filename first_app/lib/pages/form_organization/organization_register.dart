import 'package:first_app/pages/form_organization/connecting_organization.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OrganizationRegister extends StatefulWidget {
  const OrganizationRegister({super.key});

  @override
  State<OrganizationRegister> createState() => _OrganizationRegister();
}

class _OrganizationRegister extends State<OrganizationRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  transition(context),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 80, horizontal: 25),
                    child: Container(
                      width: double.infinity,
                      height: 500,
                      color: Colors.white60,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                        child:
                        Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Вход',
                                    style: TextStyle(fontSize: 32, color: Colors.black),
                                    textAlign: TextAlign.center),
                                SizedBox(
                                  height: 50,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'ИНН',
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'ОГРН',
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black26,
                                            fixedSize: Size(110, 50)),
                                        child: Text('Вход',
                                            style: TextStyle(
                                                fontSize: 18, color: Colors.white),
                                            textAlign: TextAlign.center)),
                                    ElevatedButton(
                                        onPressed: () {

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ConnectingOrganization()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black26,
                                            fixedSize: Size(150, 50)),
                                        child: Text('Регистрация',
                                            style: TextStyle(
                                                fontSize: 18, color: Colors.white),
                                            textAlign: TextAlign.center)),
                                  ],
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                  )
                ]),
          )),
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
                    Navigator.pop(context);
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

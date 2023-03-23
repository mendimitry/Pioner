import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/models/Organization.dart';
import 'package:first_app/pages/form_organization/connecting_organization.dart';
import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OrganizationRegister extends StatefulWidget {
  const OrganizationRegister({super.key});

  @override
  State<OrganizationRegister> createState() => _OrganizationRegister();
}
PionerDB pionerDB=PionerDB();
late Organization organization;
late ConnectionRequest connectionRequest;

TextEditingController innController =   TextEditingController();
TextEditingController ogrnController =   TextEditingController();
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
                                  controller: innController,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'ОГРН',
                                  ),controller: ogrnController,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          organization = await pionerDB.getOrganizationByINNandOGRN(int.parse(innController.text), int.parse(ogrnController.text));
                                          if (organization.organization_id != 0)
                                          {
                                            connectionRequest = await pionerDB.getStatusOrganizationByID(organization.organization_id);
                                            await Navigator.pushReplacementNamed(context, 'user_organization', arguments: [connectionRequest, organization]);
                                          }
                                          else {
                                            Widget okButton = TextButton(
                                              child: Text("OK"),
                                              onPressed: () {Navigator.pop(context);},
                                            );

                                            // set up the AlertDialog
                                            AlertDialog alert = AlertDialog(
                                              title: Text("Ошибка"),
                                              content: Text("Организация с данными ИНН ${innController.text} и ОГРН ${ogrnController.text} не существует"),
                                              actions: [
                                                okButton,
                                              ],
                                            );

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          }
                                        },
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

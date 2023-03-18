import 'package:first_app/pages/auto_user_register_page.dart';
import 'package:first_app/pages/button.dart';
import 'package:first_app/pages/form_administrator/list_applications.dart';
import 'package:first_app/pages/form_organization/connecting_organization.dart';
import 'package:first_app/pages/post_list_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.logout),
                alignment: Alignment(40, 5)),
            Padding(padding: EdgeInsets.only(top: 150)),
            Text('PIONEER',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 300),
                child: Text('предоставление услуг транспортным средствам',
                    style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
            Padding(padding: EdgeInsets.only(top: 50)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AutoUserRegister(value: 2)));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black26, fixedSize: Size(300, 50)),
                child: Text('Владельцам транспортных средств',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center)),
            Padding(padding: EdgeInsets.only(top: 50)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConnectingOrganization()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black26, fixedSize: Size(300, 50)),
                child: Text('Организациям - партнёрам',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center)),
            Padding(padding: EdgeInsets.only(top: 50)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListApplication()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black26, fixedSize: Size(300, 50)),
                child: Text('Администрирование',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center)),
            Padding(padding: EdgeInsets.only(top: 50)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Button()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black26, fixedSize: Size(300, 50)),
                child: Text('Кнопочки для Ивана',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center)),
          ])),
      backgroundColor: Colors.grey,
    );
  }
}

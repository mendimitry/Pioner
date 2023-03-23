import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

class RecordConfirmation extends StatefulWidget {
  State<RecordConfirmation> createState() => _RecordConfirmation();
}

class _RecordConfirmation extends State<RecordConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
          child: Container(
              padding: EdgeInsets.only(left: 80, right: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Ждем вас сегодня в 19:30 в Авангард по адресу: Походный проезд д. 3",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  IconButton(
                      iconSize: 150,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      icon: Icon(Icons.task_alt_outlined))
                ],
              ))),
    );
  }
}

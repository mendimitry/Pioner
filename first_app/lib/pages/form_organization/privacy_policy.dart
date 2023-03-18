import 'package:first_app/pages/form_organization/connecting_organization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../login_page.dart';
class PrivacyPolicy extends StatefulWidget{
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicy();
}
class _PrivacyPolicy extends State<PrivacyPolicy>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: EdgeInsets.only(top: 15),
    child: Column(children: <Widget>[
    transition(context),
      Center(
        child: Text("Политика Конфиденциальности", style: TextStyle(fontSize: 18),),
      )
  ]
    )
    )
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ConnectingOrganization()));
                  },
                  icon: Icon(Icons.logout))),

        ]);
  }

}
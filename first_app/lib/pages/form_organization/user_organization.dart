import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/pages/form_organization/connecting_organization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:first_app/pages/form_organization/privacy_policy.dart';
import 'package:flutter/gestures.dart';
import '../../data/PionerDBContext.dart';
import '../login_page.dart';
class UserOrganization extends StatefulWidget{
  const UserOrganization({super.key});

  @override
  State<UserOrganization> createState() => _UserOrganization();
}

class _UserOrganization extends State<UserOrganization>{
  PionerDB pionerDB = PionerDB();
  late ConnectionRequest connectionRequest;
  final TextEditingController connection_request_id = TextEditingController();
  final TextEditingController organization_id = TextEditingController();
  final TextEditingController reg_number = TextEditingController();
  final TextEditingController date_begin = TextEditingController();
  final TextEditingController date_end = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController add_info = TextEditingController();

  int o_id = 1;

  getStatusOrganizationByID(int id){
    connectionRequest = pionerDB.getStatusOrganizationByID(id) as ConnectionRequest;
  }
  //postOrganization() {
  //  pionerDB.postStatusOrganization(organization_id.text, reg_number.text, date_begin.text as DateTime, date_end.text as DateTime,
  //      status.text, add_info.text);
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(children: <Widget>[
            transition(context),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  color: Colors.white38,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Текущий статус: ", style: TextStyle(fontSize: 16, color: Colors.black54)),
                          ],

                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text("Дата создания: ", style: TextStyle(fontSize: 16, color: Colors.black54)),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text("Дата испольнения/отклонения: ", style: TextStyle(fontSize: 16, color: Colors.black54)),
                          ],
                        ),
                        SizedBox(height: 12),
                        text_named_organization(),
                        SizedBox(height: 8),
                        text_polnoe(),
                        SizedBox(height: 8),
                        textField_kratkoe(),
                        SizedBox(height: 8),
                        texField_INN(),
                        SizedBox(height: 8),
                        textField_KPP(),
                        SizedBox(height: 8),
                        textFiled_OGRN(),
                        SizedBox(height: 8),
                        Row(
                          children: const [
                            Text(
                              "Контактное лицо:",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        textField_famil(),
                        SizedBox(height: 8),
                        textField_name(),
                        SizedBox(height: 8),
                        textField_Otch(),
                        SizedBox(height: 8),
                        textField_email(),
                        SizedBox(height: 8),
                        textField_phoneNumber(),
                        SizedBox(height: 8),
                        textField_addInformation(),
                      ],
                    ),
                  )),
            ),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ConnectingOrganization()));
                  },
                  icon: Icon(Icons.logout))),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout))
        ]);
  }

  Row textField_addInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "доп.\nинформация",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row textField_phoneNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "номер\nтелефона",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row textField_email() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "email",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row textField_Otch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "отчество",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row textField_name() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "имя",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row textField_famil() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "фамилия",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row textFiled_OGRN() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "ОГРН",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row textField_KPP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "КПП",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row texField_INN() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "ИНН",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row textField_kratkoe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "краткое",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row text_polnoe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "полное",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row text_named_organization() {
    return Row(
      children: const [
        Text(
          "Наименование организации:",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

}
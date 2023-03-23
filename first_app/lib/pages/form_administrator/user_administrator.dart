import 'package:first_app/pages/form_administrator/list_applications.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../form_login_page/login_page.dart';

const List<String> listStatus = <String>[
  "НОВАЯ",
  "В РАБОТЕ",
  "ИСПОЛНЕНА",
  "ОТКЛОНЕНА"
];

class UserAdministrator extends StatefulWidget {
  const UserAdministrator({super.key});

  @override
  State<UserAdministrator> createState() => _UserAdministrator();
}

class _UserAdministrator extends State<UserAdministrator> {
  String listStatusValue = listStatus.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(children: <Widget>[
              transition(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    color: Colors.white38,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Текущий статус: ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54)),
                              DropdownButton<String>(
                                value: listStatusValue,
                                underline: Container(
                                  height: 1,
                                  color: Colors.deepPurpleAccent,
                                ),
                                items: listStatus.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    listStatusValue = value!;
                                  });
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 0),
                          Row(
                            children: [
                              Text("Дата создания: ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54)),
                              Text("18.12.2023",
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text("Дата испольнения/отклонения: ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54)),
                              Text("25.12.2023",
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 8),
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
                          SizedBox(height: 8),
                          button(),
                        ],
                      ),
                    )),
              ),
            ])),
      ),
      backgroundColor: Colors.grey,
    );
  }

  Row transition(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
        Widget>[
      Transform.rotate(
          angle: 180 * math.pi / 180,
          child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListApplication()));
              },
              icon: Icon(Icons.logout))),
      IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
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

  ElevatedButton button() {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black26, fixedSize: Size(280, 45)),
        child: Text('Сохранить',
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center));
  }
}

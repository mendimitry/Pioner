import 'dart:math' as math;

import 'package:first_app/controllers/ConnectingOrganization.dart';
import 'package:first_app/pages/form_organization/privacy_policy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:first_app/data/PionerDBContext.dart';

import '../../models/ConnectionRequest.dart';
import '../../models/Organization.dart';
import '../form_login_page/login_page.dart';
import '../form_organization/organization_register.dart';

late int organization_id;
late int post_id;

class UserAdministrator extends StatefulWidget {
  const UserAdministrator({super.key});

  @override
  State<UserAdministrator> createState() => _ConnectingOrganization();
}

class _ConnectingOrganization extends State<UserAdministrator> {

  bool buttonCheck = true;

  ConnectingOrganizationController _connectingOrganizationController = ConnectingOrganizationController();
  static const List<String> listStatus = <String>[
    "Новый",
    "В работе",
    "Отклонен",
    "Завершен"
  ];

  String listStatusValue = listStatus.first;
  final DateTime date2 = DateTime.parse('2023-01-01');
  final DateTime date3 = DateTime.parse('2023-03-26');

  final dDay = DateTime.utc(2000, 1, 1);

  @override
  Widget build(BuildContext context) {
    List<Object?> arg = ModalRoute.of(context)!.settings.arguments as List<Object>;
    connectionRequest = arg[0] as ConnectionRequest;
    organization = arg[1] as Organization;

    connectionRequest.printAttributes();
    organization.printAttributes();


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
                        children: [Text("ПОЛЬЗОВАТЕЛЬ - АДМИНИСТРАТОР: ",
                            style: TextStyle(
                                fontSize: 17, color: Colors.black54)),
                    Row(

                    children: [

                    Text("Измененный статус: ",
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
                          Row(
                            children: [
                              Text("Текущий статус: ${connectionRequest.status}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                            ],

                          ),
                  Row(
                    children: [
                      Text("Дата создания: ${connectionRequest.date_begin}",
                          style: TextStyle(
                              fontSize: 16, color: Colors.black54)),
                      Text("",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Дата испольнения/отклонения: ${connectionRequest.date_end}",
                          style: TextStyle(
                              fontSize: 12, color: Colors.black54)),
                      Text("",
                          style: TextStyle(fontSize: 9)),
                    ],
                  ),
                       Column(
                        children: [
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
                    ])),
              ),
      )])),
      ),
      backgroundColor: Colors.grey,
    );
  }

  ElevatedButton button() {
    return ElevatedButton(
        onPressed: buttonCheck
            ? () async {
          if (listStatusValue.toString() == "Отклонен") {
            post_id =
            await _connectingOrganizationController.UpdateConnectionRequest(
                connectionRequest.connection_request_id,
                listStatusValue.toString(), DateTime.now());


            await _connectingOrganizationController.getConnectionRequestByID(
                post_id);

            Widget okButton = TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Обновление данных"),
              content: Text("Статус организации ${organization
                  .organization_full_name} обновлен"),
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
          if (listStatusValue.toString() == "Завершен") {
            post_id =
            await _connectingOrganizationController.UpdateConnectionRequest(
                connectionRequest.connection_request_id,
                listStatusValue.toString(), DateTime.now());


            await _connectingOrganizationController.getConnectionRequestByID(
                post_id);

            Widget okButton = TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Обновление данных"),
              content: Text("Статус организации ${organization
                  .organization_full_name} обновлен"),
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

          if (listStatusValue.toString() == "В работе") {
// написал изменение статуса

            post_id =
            await _connectingOrganizationController
                .UpdateConnectionRequestNotDate(
                connectionRequest.connection_request_id,
                listStatusValue.toString());


            await _connectingOrganizationController.getConnectionRequestByID(
                post_id);
            Widget okButton = TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Обновление данных"),
              content: Text("Статус организации ${organization
                  .organization_full_name} обновлен"),
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

          if (listStatusValue.toString() == "Новый") {
// написал изменение статуса

            post_id =
            await _connectingOrganizationController
                .UpdateConnectionRequestNotDate(
                connectionRequest.connection_request_id,
                listStatusValue.toString());


            await _connectingOrganizationController.getConnectionRequestByID(
                post_id);
            Widget okButton = TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Обновление данных"),
              content: Text("Статус организации ${organization
                  .organization_full_name} обновлен"),
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
        }


            : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black26, fixedSize: Size(320, 50)),
        child: const Text('Отправить',
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center));
  }


  Row textField_addInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "доп.\nинформация",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.add_info,
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
      children: [
        Text(
          "номер\nтелефона",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.responsible_person_phone_number,
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
      children: [
        Text(
          "email",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.responsible_person_email,
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
      children: [
        const Text(
          "отчество",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.responsible_person_patronymic,
            decoration: const InputDecoration(
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
      children: [
        const Text(
          "имя",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.responsible_person_name,
            decoration: const InputDecoration(
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
      children: [
        const Text(
          "фамилия",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.responsible_person_surname,
            decoration: const InputDecoration(
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
      children: [
        const Text(
          "ОГРН",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.ogrn,
            decoration: const InputDecoration(
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
      children: [
        const Text(
          "КПП",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.kpp,
            decoration: const InputDecoration(
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
      children: [
        const Text(
          "ИНН",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.inn,
            decoration: const InputDecoration(
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
      children: [
        const Text(
          "краткое",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.organization_short_name,
            decoration: const InputDecoration(
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
      children: [
        const Text(
          "полное",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.organization_full_name,
            decoration: const InputDecoration(
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout))
        ]);
  }
}

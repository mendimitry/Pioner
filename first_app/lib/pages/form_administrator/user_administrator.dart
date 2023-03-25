import 'dart:math' as math;

import 'package:first_app/controllers/ConnectingOrganization.dart';
import 'package:first_app/pages/form_organization/privacy_policy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:first_app/data/PionerDBContext.dart';

import '../form_login_page/login_page.dart';

late int organization_id;
late int post_id;

class UserAdministrator extends StatefulWidget {
  const UserAdministrator({super.key});

  @override
  State<UserAdministrator> createState() => _ConnectingOrganization();
}

class _ConnectingOrganization extends State<UserAdministrator> {
  bool value = false;
  bool buttonCheck = false;

  ConnectingOrganizationController _connectingOrganizationController = ConnectingOrganizationController();
  static const List<String> listStatus = <String>[
    "НОВАЯ",
    "В РАБОТЕ",
    "ИСПОЛНЕНА",
    "ОТКЛОНЕНА"
  ];
  final TextEditingController polnoeTextController = TextEditingController();
  final TextEditingController kratkoeTextController = TextEditingController();
  final TextEditingController innTextController = TextEditingController();
  final TextEditingController kppTextController = TextEditingController();
  final TextEditingController ogrnTextController = TextEditingController();
  final TextEditingController surnameTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController patronymicTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneNumberTextController = TextEditingController();
  final TextEditingController additionalInfoTextController = TextEditingController();
  String listStatusValue = listStatus.first;
  /*
  postOrganization() async {
    organization_id = await pionerDB.postOrganization(polnoeTextController.text, kratkoeTextController.text, innTextController.text, kppTextController.text,
        ogrnTextController.text, surnameTextController.text, nameTextController.text, patronymicTextController.text, emailTextController.text,
        phoneNumberTextController.text, additionalInfoTextController.text);


    post_id = await pionerDB.postStatusOrganization(organization_id, (organization_id + 1).toString(), DateTime.now(), "Новый");
  }
*/


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
                          check_privacyPolicy(context),
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
          // todo я хз как нормально написать апдейт для статуса
          organization_id = await _connectingOrganizationController.UpdateOrganization(
              polnoeTextController.text,
              kratkoeTextController.text,
              innTextController.text,
              kppTextController.text,
              ogrnTextController.text,
              surnameTextController.text,
              nameTextController.text,
              patronymicTextController.text,
              emailTextController.text,
              phoneNumberTextController.text,
              additionalInfoTextController.text);

          post_id = await _connectingOrganizationController.UpdateConnectionRequest(organization_id,
              (organization_id + 1).toString(), DateTime.now(), "Новый");

          await Navigator.pushReplacementNamed(context, 'user_organization',
              arguments: [
                await _connectingOrganizationController.getConnectionRequestByID(post_id),
                await _connectingOrganizationController.getOrganizationByID(organization_id)
              ]);
        }
            : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black26, fixedSize: Size(320, 50)),
        child: const Text('Отправить',
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center));
  }

  Row check_privacyPolicy(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: value,
            onChanged: (bool? newValue) {
              setState(() {
                value = newValue!;
                buttonCheck = value;
              });
            }),
        Flexible(
            child: RichText(
              text: TextSpan(
                  text: 'Принимаю условия ',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'политики конфиденциальности',
                        style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                            decoration: TextDecoration.underline),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivacyPolicy()));
                          })
                  ]),
            )),
      ],
    );
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
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
            controller: additionalInfoTextController,
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
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
            controller: phoneNumberTextController,
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
          child: TextField(
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
            controller: emailTextController,
          ),
        ),
      ],
    );
  }

  Row textField_Otch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            controller: patronymicTextController,
          ),
        ),
      ],
    );
  }

  Row textField_name() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            controller: nameTextController,
          ),
        ),
      ],
    );
  }

  Row textField_famil() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            controller: surnameTextController,
          ),
        ),
      ],
    );
  }

  Row textFiled_OGRN() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            controller: ogrnTextController,
          ),
        ),
      ],
    );
  }

  Row textField_KPP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            controller: kppTextController,
          ),
        ),
      ],
    );
  }

  Row texField_INN() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            controller: innTextController,
          ),
        ),
      ],
    );
  }

  Row textField_kratkoe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            controller: kratkoeTextController,
          ),
        ),
      ],
    );
  }

  Row text_polnoe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            controller: polnoeTextController,
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

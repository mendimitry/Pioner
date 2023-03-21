import 'dart:math' as math;

import 'package:first_app/pages/form_organization/privacy_policy.dart';
import 'package:first_app/pages/form_organization/user_organization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:first_app/models/Organization.dart';
import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/data/PionerDBContext.dart';

import '../login_page.dart';
late int organization_id;
late int post_id;
class ConnectingOrganization extends StatefulWidget {
  const ConnectingOrganization({super.key});

  @override
  State<ConnectingOrganization> createState() => _ConnectingOrganization();
}


class _ConnectingOrganization extends State<ConnectingOrganization> {
  bool value = false;
  PionerDB pionerDB = PionerDB();
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
    return Scaffold(resizeToAvoidBottomInset: false,
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
                        button()
                      ],
                    ),
                  )),
            ),
          ])),
      backgroundColor: Colors.grey,
    );
  }

  ElevatedButton button() {
    return ElevatedButton(onPressed: () async {
      organization_id = await pionerDB.postOrganization(polnoeTextController.text, kratkoeTextController.text, innTextController.text, kppTextController.text,
          ogrnTextController.text, surnameTextController.text, nameTextController.text, patronymicTextController.text, emailTextController.text,
          phoneNumberTextController.text, additionalInfoTextController.text);

      post_id = await pionerDB.postStatusOrganization(organization_id, (organization_id + 1).toString(), DateTime.now(), "Новый");

      await Navigator.pushReplacementNamed(context, 'user_organization', arguments: [await pionerDB.getStatusOrganizationByID(post_id), await pionerDB.getOrganizationByID(organization_id)]);
    },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black26,
            fixedSize:  Size(320, 50)),
        child: const Text('Отправить',
            style: TextStyle(
                fontSize: 12, color: Colors.white),
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
              });
            }),
        Flexible(
            child: RichText(
          text: TextSpan(
              text: 'Принимаю условия ',
              style: TextStyle(fontSize: 20, color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: 'политики конфиденциальности',
                    style: const TextStyle(
                        color: Colors.blueAccent,
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
      children: const[
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
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

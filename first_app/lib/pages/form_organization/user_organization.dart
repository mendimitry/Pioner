import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/models/Organization.dart';
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
  late Organization organization;

  @override
  void initState() {
    super.initState();
  }

  getFullInfoAboutStatusOfOrganization(int post_id,int organization_id) async{
    connectionRequest = await pionerDB.getStatusOrganizationByID(post_id);
    organization = await pionerDB.getOrganizationByID(organization_id);
  }

  @override
  Widget build(BuildContext context) {

    List<Object?> arg = ModalRoute.of(context)!.settings.arguments as List<Object>;
    connectionRequest = arg[0] as ConnectionRequest;
    organization = arg[1] as Organization;

    connectionRequest.printAttributes();
    organization.printAttributes();

    return Scaffold(resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(children: <Widget>[
            transition(context),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  color: Colors.white38,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Текущий статус: ${connectionRequest.status}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                          ],

                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text("Дата создания: ${connectionRequest.date_begin}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text("Дата испольнения/отклонения: ${connectionRequest.date_end}", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        text_named_organization(),
                        const SizedBox(height: 8),
                        text_polnoe(),
                        const SizedBox(height: 8),
                        textField_kratkoe(),
                        const SizedBox(height: 8),
                        texField_INN(),
                        const SizedBox(height: 8),
                        textField_KPP(),
                        const SizedBox(height: 8),
                        textFiled_OGRN(),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Text(
                              "Контактное лицо:",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        textField_famil(),
                        const SizedBox(height: 8),
                        textField_name(),
                        const SizedBox(height: 8),
                        textField_Otch(),
                        const SizedBox(height: 8),
                        textField_email(),
                        const SizedBox(height: 8),
                        textField_phoneNumber(),
                        const SizedBox(height: 8),
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
                        MaterialPageRoute(builder: (context) => const ConnectingOrganization()));
                  },
                  icon: const Icon(Icons.logout))),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: const Icon(Icons.logout))
        ]);
  }

  Row textField_addInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "доп.\nинформация",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.add_info,
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

  Row textField_phoneNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "номер\nтелефона",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.responsible_person_phone_number,
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

  Row textField_email() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "email",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: organization.responsible_person_email,
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

}
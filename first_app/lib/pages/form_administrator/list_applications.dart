import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/pages/form_administrator/user_administrator.dart';
import 'package:first_app/pages/form_chooising_service/choosing_service.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../controllers/ConnectingOrganization.dart';
import '../../data/PionerDBContext.dart';
import '../form_organization/connecting_organization.dart';
import '../form_login_page/login_page.dart';

class ListApplication extends StatefulWidget {
  const ListApplication({super.key});

  @override
  State<ListApplication> createState() => _ListApplication();
}

PionerDB pionerDB = PionerDB();
final TextEditingController regNumberTextController = TextEditingController();
final TextEditingController DateCreateTextController = TextEditingController();
final TextEditingController kratkoeTextController = TextEditingController();
ConnectingOrganizationController _connectingOrganizationController = ConnectingOrganizationController();
Future<List<ConnectionRequest>> getAllConnectionRequest() async {
  await pionerDB.initDatabaseConnection();

  var query = await pionerDB.dbConnection
      .mappedResultsQuery('SELECT * from connection_request');
  //Нулевой объект
  ConnectionRequest _connectionRequest;
  List<ConnectionRequest> _conncetionRequests = [];
  for (var element in query) {
    for (var subElement in element.values) {
      _connectionRequest = ConnectionRequest.fromReqBody(subElement);
      _connectionRequest.printAttributes();

      _conncetionRequests.add(_connectionRequest);
    }
  }
  //Закрываем соединение с БД
  await pionerDB.closeDatabaseConnection();

  //Возвращаем всех полученных пользователей
  return _conncetionRequests;
}

Future<List<ConnectionRequest>> usersFuture = getAllConnectionRequest();
var listStatus = [
  "НОВАЯ",
  "В РАБОТЕ",
  "ИСПОЛНЕНА",
  "ОТКЛОНЕНА",
];

var organization1 = [
  "1",
  "08.03.2023",
  "Белый лед",
];
var organization2 = [
  "2",
  "18.01.2023",
  "Ласточка",
];
var organization3 = [
  "3",
  "26.04.2023",
  "Каприз",
];
var mass = [organization1, organization2, organization3];
String listStatusValue = listStatus.first;

class _ListApplication extends State<ListApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
                          SizedBox(
                            height: 20,
                          ),
                    Container(
                      width: 340,
                      child: Column(
                        children: [
                          Container(
                              width: 340,
                              height: 50,
                              color: Colors.white24,
                              child: const Center(
                                child: Text(
                                  "Список форм в выбранном статусе",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                          Container(
                              child: Table(
                                border: TableBorder.symmetric(
                                    inside: BorderSide(
                                        width: 1, color: Colors.black)),
                                columnWidths: const <int, TableColumnWidth>{
                                  0: FixedColumnWidth(40),
                                  1: FixedColumnWidth(200),
                                },
                                children: [
                                  TableRow(
                                      decoration:
                                      BoxDecoration(color: Colors.black12),
                                      children: [
                                        Container(
                                          // color: Colors.white,
                                          height: 60,
                                          child: Text(
                                            "Рег. №",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          //  color: Colors.white,
                                          height: 60,
                                          child: Text("Дата создания",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ),
                                        Container(
                                          // color: Colors.white,
                                          height: 60,
                                          child: Text(
                                              "Краткое\n"
                                                  "наим. -е\nорганизации",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ),
                                      ])
                                ],
                              )),
                          list_organization()
                        ],
                      ),
                    ),

            ])),
      ),
    )]))));
  }
}

Container list_organization() {
  return Container(
    child: FutureBuilder<List<ConnectionRequest>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // return: show loading widget
          }
          if (snapshot.hasError) {
            // return: show error widget
          }
          List<ConnectionRequest> users = snapshot.data ?? [];
          return ListView.builder(
              itemCount: users.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ConnectionRequest user = users[index];
                return ListTile(
                  title: new Text('${user.reg_number}' +
                      "      " +
                      '${user.date_begin}' +
                      "      " +
                      '${user.organization_id}'),
                  onTap: () async {
                    await Navigator.pushReplacementNamed(context, 'user_administrator',
                        arguments: [
                         // await _connectingOrganizationController.getConnectionRequestByID(post_id),
                          await _connectingOrganizationController.getOrganizationByID(user.organization_id)
                        ]);
                 //   Navigator.push(
                    //    context,
                     //   new MaterialPageRoute(
                     //       builder: (context) => UserAdministrator()));
                  },

                  // onTap: () {
                  //  Navigator.push(context,
                  //      new MaterialPageRoute(builder: (context) => new ChoosingSerice()));
                );
              });
        }),
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
                  MaterialPageRoute(builder: (context) => UserAdministrator()));
            },
            icon: Icon(Icons.logout))
      ]);
}

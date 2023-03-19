import 'package:first_app/models/Customer.dart';
import 'package:flutter/material.dart';
import 'package:first_app/data/PionerDBContext.dart';

import 'login_page.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _Button();
}


class _Button extends State<Button> {
  PionerDB pionerDB = PionerDB();
  late Future<List<Customer>> customers;

  int ID = 2;
  String phoneNumber = "89140213561";
  String name = "Боба";
  String surname = "Абобав";
  String phoneNumber2 = "89123456789";

  @override
  initState() {
    super.initState();
  }

  getAllCustomers() {
    pionerDB.getAllCustomers();
  }

  getCustomerByID(int ID){
    pionerDB.getCustomerByID(ID);
  }

  getCustomerByPhoneNumber(String phoneNumber){
    pionerDB.getCustomerByPhoneNumber(phoneNumber);
  }

  postCustomer(String? name, String? surname, String phoneNumber2){
    pionerDB.postCustomer(phoneNumber2, name, surname);
  }

  deleteCustomer(String phoneNumber2){
    pionerDB.deleteCustomer(phoneNumber2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(children: <Widget>[
            transition(context),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {getAllCustomers();},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('Получить пользователей',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {getCustomerByID(ID);},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('Получить пользователя с ID 2',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {getCustomerByPhoneNumber(phoneNumber);},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('Получить пользователя по номеру телефона',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {postCustomer(name, surname, phoneNumber2);},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('Добавить пользователя',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {deleteCustomer(phoneNumber2);},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('Удалить пользователя',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('button6',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('button7',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('button8',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('button9',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('button10',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('button11',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  fixedSize: Size(120, 50)),
                              child: Text('button12',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                        ]),
                  ],
                ))
          ])),
      backgroundColor: Colors.grey,
    );
  }

  Align transition(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            icon: Icon(Icons.logout)));
  }
}

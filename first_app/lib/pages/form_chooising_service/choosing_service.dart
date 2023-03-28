// Выбор услуги
import 'package:first_app/models/Customer.dart';
import 'package:first_app/pages/form_chooising_organization/choosing_organization.dart';
import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


enum services { car_wash, tire_service }

class ChoosingServices extends StatefulWidget {
  const ChoosingServices({super.key});

  @override
  State<ChoosingServices> createState() => _ChoosingServices();
}

/*
late Customer customer;
late var token;
*/

class _ChoosingServices extends State<ChoosingServices> {
  String _serviceValue = "Мойка";
  services? _service = services.car_wash;


  @override
  Widget build(BuildContext context) {
    /*
    Данные необходимые для полноценной работы авторизации
    List<Object?> arg = ModalRoute.of(context)!.settings.arguments as List<Object?>;

    token = arg[0];
    customer = arg[1] as Customer;
     */

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            icon: Icon(Icons.logout))),

                  ]),
              

              Padding(padding: EdgeInsets.only(top: 25)),
              Container(
                constraints: BoxConstraints.tightFor(width: 325, height: 600),
                color: const Color.fromRGBO(255, 228, 225, 0.6),
                child: Column(children: [
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Text('Услуги',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  RadioCarWash(),
                  RadioTireService(),
                  Padding(padding: EdgeInsets.only(top: 300)),
                  ButtonChoosingService(context),
                ]),
              ),
            ])),
      ),
      backgroundColor: Colors.grey,
    );
  }

  ElevatedButton ButtonChoosingService(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          print(_serviceValue); // _serviceValue нужно передать в push
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                     ChoosingOrganization(serviceValue: _serviceValue)));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black26, fixedSize: Size(300, 50)),
        child: Text('Выбрать услугу',
            style: TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center));
  }

  ListTile RadioTireService() {
    return ListTile(
      title: const Text('Шиномонаж'),
      leading: Radio<services>(
        value: services.tire_service,
        groupValue: _service,
        onChanged: (services? value) {
          setState(() {
            _service = value;
            _serviceValue = "Шиномонтаж";
          });
        },
      ),
    );
  }

  ListTile RadioCarWash() {
    return ListTile(
      title: const Text('Мойка'),
      leading: Radio<services>(
        value: services.car_wash,
        groupValue: _service,
        onChanged: (services? value) {
          setState(() {
            _serviceValue = "Мойка";
            _service = value;
          });
        },
      ),
    );
  }


}

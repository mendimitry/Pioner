import 'dart:convert';

import 'package:first_app/data/PionerDBContext.dart';


class Customer
{
  final int customer_id;
  final String? customer_surname;
  final String? customer_name;
  final String customer_phone_number;

  Customer ({required this.customer_id,this.customer_surname,this.customer_name,required this.customer_phone_number});

  //Обрабатываем ответ из БД, формируем объект
  factory Customer.fromReqBody(Map<String, dynamic> json){

      return Customer(
          customer_id:json['customer_id'] as int,
          customer_surname:json['customer_surname'] as String,
          customer_name:json['customer_name'] as String,
          customer_phone_number:json['customer_phone_number'] as String
      );
  }

  void printAttributes() {
    print("customer_id: ${this.customer_id}\n");
    print("customer_surname: ${this.customer_surname}\n");
    print("customer_name: ${this.customer_name}\n");
    print("customer_phone_number: ${this.customer_phone_number}\n");
  }

}
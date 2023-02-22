import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/pages/choosing_service.dart';
import 'package:first_app/pages/post_list_page.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:get/get_core/src/get_main.dart';

import 'main.dart';
import 'otp.dart';


class AutoUserRegister extends StatefulWidget {
  const AutoUserRegister({Key? key, required Object value}) : super(key: key) ;

  @override
  State<AutoUserRegister> createState() => _MyPhoneState();
}

bool rememberMe = false;

class _MyPhoneState extends State<AutoUserRegister> {
  TextEditingController countryController = TextEditingController();
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  var phone = '';
  var code = '';
  var showPrefix = false.obs;
  var isLogin = true;
  var phoneNo = "".obs;
  var otp = "".obs;
  var isOtpSent = false.obs;
  var resendAfter = 30.obs;
  var resendOTP = false.obs;
  var firebaseVerificationId = "";
  var statusMessage = "".obs;
  var statusMessageColor = Colors.black.obs;

  var timer;
  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+7";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Transform.rotate(angle: 180 * math.pi / 180,
                          child: IconButton(
                              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));}, icon: Icon(Icons.logout))),
                      IconButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosingSerice()));}, icon: Icon(Icons.logout))
                    ]
                ),
                Padding(padding: EdgeInsets.only(top: 25)),
                Container(constraints: BoxConstraints.tightFor(
                    width: 325, height: 600),
                    color: const Color.fromRGBO(255, 228, 225, 0.6),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Text('Регистрация', style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),

                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text('Номер телефона', textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20),),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextField(onChanged: (value) {
                          phone = value;
                        },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '8 (900) 000 00 00',
                                fillColor: Colors.black12,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    top: 5, right: 20, left: 20))),

                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text('SMS-код', textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 20)),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextField(onChanged: (value) {
                          code = value;
                        },decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '999999',
                            fillColor: Colors.black12,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                top: 5, right: 20, left: 20))),
                        Padding(padding: EdgeInsets.only(top: 50)),

                        Row(
                          children: [
                            Checkbox(value: rememberMe,
                                onChanged: (bool? newValue) {}),
                            Flexible(child: RichText(text: TextSpan(
                                text: 'Принимаю условия ', style: TextStyle(
                                fontSize: 20, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(text: 'политики конфиденциальности',
                                    style: const TextStyle(
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline),
                                  )
                                ]
                            ),
                            )
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 75)),

                        ElevatedButton(onPressed: () async {
                          FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '${countryController.text + phone}',
                            verificationCompleted: (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent: (String verificationId, int? resendToken) {
                              firebaseVerificationId = verificationId;
                              isOtpSent.value = true;
                              statusMessage.value = "OTP sent to +7" + phone;
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );
                        },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black26,
                                fixedSize: Size(300, 50)),
                            child: Text('Получить код', style: TextStyle(
                                fontSize: 18, color: Colors.white),
                                textAlign: TextAlign.center)

                        ),
                        ElevatedButton(onPressed: () async {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          statusMessage.value = "Verifying... " + code;
                          // Create a PhoneAuthCredential with the code
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(
                              verificationId: firebaseVerificationId, smsCode: code);
                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PostListPage()));

                        },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black26,
                                fixedSize: Size(300, 50)),
                            child: Text('Verification Test', style: TextStyle(
                                fontSize: 18, color: Colors.white),
                                textAlign: TextAlign.center)
                        )
                      ],
                    )
                )
              ]
          )
      ),
      backgroundColor: Colors.grey,
    );
  }


}
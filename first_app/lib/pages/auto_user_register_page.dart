import 'package:flutter/material.dart';
import 'dart:math' as math;

class AutoUserRegister extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column (
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Transform.rotate(angle: 180 * math.pi / 180, child: IconButton(onPressed: () {}, icon: Icon(Icons.logout))),
                      IconButton(onPressed: () {}, icon: Icon(Icons.logout))
                    ]),
          ConstrainedBox(constraints: BoxConstraints.tightFor(width: 300),
              child: Text('Текст')
          )
              ]
          )
      ),
      backgroundColor: Colors.grey,
    );
  }
}
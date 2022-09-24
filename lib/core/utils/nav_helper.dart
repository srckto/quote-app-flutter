


import 'package:flutter/material.dart';

class NavHelper{
  static push(BuildContext context, Widget screen){
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static pushReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
  }
}
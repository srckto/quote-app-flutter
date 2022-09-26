import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quote/core/utils/assets_manager.dart';
import 'package:quote/core/utils/nav_helper.dart';
import 'package:quote/features/layout/presentation/screens/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(Duration(seconds: 2));
    NavHelper.pushReplacement(context, LayoutScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(ImgAssets.quote)),
    );
  }
}

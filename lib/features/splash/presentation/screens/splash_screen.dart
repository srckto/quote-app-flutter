import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quote/core/utils/assets_manager.dart';
import 'package:quote/core/utils/nav_helper.dart';
import 'package:quote/features/quotes/presentation/screens/quotes_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      Duration(seconds: 2),
      () {
        NavHelper.pushReplacement(context, QuotesScreen());
        // NavHelper.pushReplacement(context, RandomQuoteScreen());
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  _cancelTimer() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(ImgAssets.quote)),
    );
  }
}

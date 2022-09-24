import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/app.dart';
import 'package:quote/bloc_observer.dart';
import 'package:quote/injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

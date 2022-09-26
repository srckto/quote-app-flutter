import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/features/layout/domain/entities/layout.dart';
import 'package:quote/features/quotes/presentation/screens/quotes_screen.dart';
import 'package:quote/features/random_quote/presentation/screens/random_quote_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  final List<LayoutObject> items = [
    LayoutObject(
      title: AppStrings.randomQuoteScreen,
      icon: Icon(Icons.touch_app),
      screen: RandomQuoteScreen(),
    ),
    LayoutObject(
      title: AppStrings.quotesScreen,
      icon: Icon(Icons.touch_app_outlined),
      screen: QuotesScreen(),
    ),
  ];
  int index = 0;

  LayoutCubit() : super(LayoutInitial());

  void onChanges(int newIndex) {
    emit(LayoutInitial());
    index = newIndex;
    emit(LayoutIsChanged());
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quote/core/usecases/usecase.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/features/splash/domain/usecases/change_lang.dart';
import 'package:quote/features/splash/domain/usecases/get_saved_lang.dart';

part 'local_state.dart';

class LocalCubit extends Cubit<LocalState> {
  GetSavedLangUseCase getSavedLangUseCase;
  ChangeLangUseCase changeLangUseCase;
  LocalCubit({
    required this.changeLangUseCase,
    required this.getSavedLangUseCase,
  }) : super(ChangeLocaleState(locale: Locale(AppStrings.en)));

  String currentLangCode = AppStrings.en;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase(NoParams());
    response.fold(
      (failure) => debugPrint(AppStrings.cacheFailure),
      (langCode) {
        currentLangCode = langCode;
        emit(ChangeLocaleState(locale: Locale(currentLangCode)));
      },
    );
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLangUseCase(langCode);
    response.fold(
      (failure) => debugPrint(AppStrings.cacheFailure),
      (value) {
        currentLangCode = langCode;
        emit(ChangeLocaleState(locale: Locale(currentLangCode)));
      },
    );
  }

  void toEnglish() => _changeLang(AppStrings.en);
  void toArabic() => _changeLang(AppStrings.ar);
}

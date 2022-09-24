import 'package:get_storage/get_storage.dart';
import 'package:quote/core/error/exceptions.dart';
import 'package:quote/core/utils/app_strings.dart';

abstract class LangLocalDataSource {
  Future<bool> changeLang(String langCode);
  Future<String> getSavedLang();
}

class LangLocalDataSourceImpl implements LangLocalDataSource {
  GetStorage getStorage;

  LangLocalDataSourceImpl({
    required this.getStorage,
  });

  @override
  Future<bool> changeLang(String langCode) async {
    try {
      await getStorage.write(AppStrings.locale, langCode);
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<String> getSavedLang() async {
    try {
      return getStorage.read(AppStrings.locale) ?? AppStrings.en;
    } catch (e) {
      throw CacheException();
    }
  }
}

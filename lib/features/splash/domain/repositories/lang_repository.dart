import 'package:dartz/dartz.dart';
import 'package:quote/core/error/failures.dart';

abstract class LangRepository {
  Future<Either<Failure, bool>> changeLang(String langCode);
  Future<Either<Failure, String>> getSavedLang();
}

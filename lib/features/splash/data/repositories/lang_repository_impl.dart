import 'package:dartz/dartz.dart';
import 'package:quote/core/error/exceptions.dart';

import 'package:quote/core/error/failures.dart';
import 'package:quote/features/splash/data/datasources/lang_local_data_source.dart';
import 'package:quote/features/splash/domain/repositories/lang_repository.dart';

class LangRepositoryImpl implements LangRepository {
  LangLocalDataSource langLocalDataSource;
  LangRepositoryImpl({
    required this.langLocalDataSource,
  });

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      String lang = await langLocalDataSource.getSavedLang();
      return Right(lang);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> changeLang(String langCode) async {
    try {
      bool langIsChanged = await langLocalDataSource.changeLang(langCode);
      return Right(langIsChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}

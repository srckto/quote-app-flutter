import 'package:dartz/dartz.dart';

import 'package:quote/core/error/failures.dart';
import 'package:quote/core/usecases/usecase.dart';
import 'package:quote/features/splash/domain/repositories/lang_repository.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  LangRepository langRepository;
  ChangeLangUseCase({
    required this.langRepository,
  });
  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await langRepository.changeLang(langCode);
}

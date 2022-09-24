import 'package:dartz/dartz.dart';

import 'package:quote/core/error/failures.dart';
import 'package:quote/core/usecases/usecase.dart';
import 'package:quote/features/splash/domain/repositories/lang_repository.dart';

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  LangRepository langRepository;
  GetSavedLangUseCase({
    required this.langRepository,
  });
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return langRepository.getSavedLang();
  }
}

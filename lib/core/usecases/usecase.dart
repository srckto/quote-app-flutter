import 'package:dartz/dartz.dart';
import 'package:quote/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}


class NoParams {}

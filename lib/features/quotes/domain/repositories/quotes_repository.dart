import 'package:dartz/dartz.dart';
import 'package:quote/core/error/failures.dart';
import 'package:quote/features/random_quote/domain/entities/quote.dart';

abstract class QuotesRepository {
  Future<Either<Failure, List<Quote>>> getQuotes();
}

import 'package:dartz/dartz.dart';

import 'package:quote/core/error/failures.dart';
import 'package:quote/core/usecases/usecase.dart';
import 'package:quote/features/random_quote/domain/entities/quote.dart';
import 'package:quote/features/random_quote/domain/repositories/random_quote_repository.dart';

class GetRandomQuote implements UseCase<Quote, NoParams> {
  final RandomQuoteRepository quoteRepository;
  GetRandomQuote({
    required this.quoteRepository,
  });
  @override
  Future<Either<Failure, Quote>> call(NoParams params) {
    return quoteRepository.getRandomQuote();
  }
}

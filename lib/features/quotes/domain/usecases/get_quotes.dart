import 'package:dartz/dartz.dart';

import 'package:quote/core/error/failures.dart';
import 'package:quote/core/usecases/usecase.dart';
import 'package:quote/features/quotes/domain/repositories/quotes_repository.dart';
import 'package:quote/features/random_quote/domain/entities/quote.dart';

class GetQuotes implements UseCase<List<Quote>, NoParams> {
  final QuotesRepository quotesRepository;
  GetQuotes({
    required this.quotesRepository,
  });
  @override
  Future<Either<Failure, List<Quote>>> call(NoParams params) {
    return quotesRepository.getQuotes();
  }
}

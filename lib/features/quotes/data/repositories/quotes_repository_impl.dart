import 'package:dartz/dartz.dart';
import 'package:quote/core/error/exceptions.dart';

import 'package:quote/core/error/failures.dart';
import 'package:quote/core/network/network_info.dart';
import 'package:quote/features/quotes/data/datasources/quotes_local_data_source.dart';
import 'package:quote/features/quotes/data/datasources/quotes_remote_data_source.dart';
import 'package:quote/features/quotes/domain/repositories/quotes_repository.dart';
import 'package:quote/features/random_quote/domain/entities/quote.dart';

class QuotesRepositoryImpl implements QuotesRepository {
  final NetworkInfo networkInfo;
  final QuotesLocalDataSource quotesLocalDataSource;
  final QuotesRemoteDataSource quotesRemoteDataSource;
  QuotesRepositoryImpl({
    required this.networkInfo,
    required this.quotesLocalDataSource,
    required this.quotesRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<Quote>>> getQuotes() async {
    if (await networkInfo.isConnected) {
      try {
        var quotes = await quotesRemoteDataSource.getQuotes();
        await quotesLocalDataSource.cacheQuotes(quotes);
        return Right(quotes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        var quotes = await quotesLocalDataSource.getLastQuotes();
        return Right(quotes);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:quote/core/error/exceptions.dart';

import 'package:quote/core/error/failures.dart';
import 'package:quote/core/network/network_info.dart';
import 'package:quote/features/random_quote/data/datasources/random_quote_local_data_source.dart';
import 'package:quote/features/random_quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:quote/features/random_quote/domain/entities/quote.dart';
import 'package:quote/features/random_quote/domain/repositories/random_quote_repository.dart';

class RandomQuoteRepositoryImpl extends RandomQuoteRepository {
  final NetworkInfo networkInfo;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;

  RandomQuoteRepositoryImpl({
    required this.networkInfo,
    required this.randomQuoteRemoteDataSource,
    required this.randomQuoteLocalDataSource,
  });
  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRandomQuote = await randomQuoteRemoteDataSource.getRandomQuote();
        randomQuoteLocalDataSource.cacheRandomQuote(remoteRandomQuote);
        return Right(remoteRandomQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRandomQuote = await randomQuoteLocalDataSource.getLastRandomQuote();
        return Right(localRandomQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

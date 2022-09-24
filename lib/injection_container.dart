import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quote/core/api/api_consumer.dart';
import 'package:quote/core/api/app_interceptors.dart';
import 'package:quote/core/api/dio_consumer.dart';
import 'package:quote/core/network/network_info.dart';
import 'package:quote/features/quotes/data/datasources/quotes_local_data_source.dart';
import 'package:quote/features/quotes/data/datasources/quotes_remote_data_source.dart';
import 'package:quote/features/quotes/data/repositories/quotes_repository_impl.dart';
import 'package:quote/features/quotes/domain/repositories/quotes_repository.dart';
import 'package:quote/features/quotes/domain/usecases/get_quotes.dart';
import 'package:quote/features/quotes/presentation/cubit/quotes_cubit.dart';
import 'package:quote/features/random_quote/data/datasources/random_quote_local_data_source.dart';
import 'package:quote/features/random_quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:quote/features/random_quote/data/repositories/random_quote_repository_impl.dart';
import 'package:quote/features/random_quote/domain/repositories/random_quote_repository.dart';
import 'package:quote/features/random_quote/domain/usecases/get_random_quote.dart';
import 'package:quote/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:quote/features/splash/data/datasources/lang_local_data_source.dart';
import 'package:quote/features/splash/data/repositories/lang_repository_impl.dart';
import 'package:quote/features/splash/domain/repositories/lang_repository.dart';
import 'package:quote/features/splash/domain/usecases/change_lang.dart';
import 'package:quote/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:quote/features/splash/presentation/cubit/local_cubit.dart';

final sl = GetIt.instance;

void init() {
  //! Features
  // Blocs
  sl.registerFactory(() => RandomQuoteCubit(getRandomQuoteUseCase: sl()));
  sl.registerFactory(
    () => LocalCubit(
      changeLangUseCase: sl(),
      getSavedLangUseCase: sl(),
    ),
  );
  sl.registerFactory(() => QuotesCubit(getQuotesUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));
  sl.registerLazySingleton(() => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton(() => ChangeLangUseCase(langRepository: sl()));
  sl.registerLazySingleton(() => GetQuotes(quotesRepository: sl()));

  // Repositories
  sl.registerLazySingleton<RandomQuoteRepository>(
    () => RandomQuoteRepositoryImpl(
      networkInfo: sl(),
      randomQuoteLocalDataSource: sl(),
      randomQuoteRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<LangRepository>(() => LangRepositoryImpl(langLocalDataSource: sl()));
  sl.registerLazySingleton<QuotesRepository>(
    () => QuotesRepositoryImpl(
      networkInfo: sl(),
      quotesLocalDataSource: sl(),
      quotesRemoteDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
      () => RandomQuoteRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
      () => RandomQuoteLocalDataSourceImpl(getStorage: sl()));

  sl.registerLazySingleton<QuotesLocalDataSource>(
      () => QuotesLocalDataSourceImpl(getStorage: sl()));
  sl.registerLazySingleton<QuotesRemoteDataSource>(
      () => QuotesRemoteDataSourceImpl(apiConsumer: sl()));

  sl.registerLazySingleton<LangLocalDataSource>(() => LangLocalDataSourceImpl(getStorage: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ));
}

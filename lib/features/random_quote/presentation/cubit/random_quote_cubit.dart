import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quote/core/error/failures.dart';
import 'package:quote/core/usecases/usecase.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/features/random_quote/domain/entities/quote.dart';
import 'package:quote/features/random_quote/domain/usecases/get_random_quote.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  RandomQuoteCubit({required this.getRandomQuoteUseCase}) : super(RandomQuoteInitial());

  final GetRandomQuote getRandomQuoteUseCase;

  Future<void> getRandomQuote() async {
    emit(RandomQuoteIsLoading());
    final Either<Failure, Quote> response = await getRandomQuoteUseCase(NoParams());
    emit(response.fold(
      (failure) => RandomQuoteError(message: _mapFailureToMsg(failure)),
      (quote) => RandomQuoteIsLoaded(quote: quote),
    ));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unknownFailure;
    }
  }
}

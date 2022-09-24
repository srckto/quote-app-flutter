import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quote/core/error/failures.dart';
import 'package:quote/core/usecases/usecase.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/features/quotes/domain/usecases/get_quotes.dart';
import 'package:quote/features/random_quote/domain/entities/quote.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  final GetQuotes getQuotesUseCase;
  QuotesCubit({required this.getQuotesUseCase}) : super(QuotesInitial());

  Future<void> getQuotes() async {
    emit(QuotesIsLoading());
    Either<Failure, List<Quote>> response = await getQuotesUseCase(NoParams());
    emit(
      response.fold(
        (failure) => QuotesError(message: _handleFailure(failure)),
        (quotes) => QuotesIsLoaded(quotes: quotes),
      ),
    );
  }

  String _handleFailure(Failure failure) {
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

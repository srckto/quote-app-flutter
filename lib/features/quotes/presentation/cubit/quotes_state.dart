part of 'quotes_cubit.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object> get props => [];
}

class QuotesInitial extends QuotesState {}

class QuotesIsLoading extends QuotesState {}

class QuotesIsLoaded extends QuotesState {
  final List<Quote> quotes;
  QuotesIsLoaded({
    required this.quotes,
  });
  @override
  List<Object> get props => [quotes];
}

class QuotesError extends QuotesState {
  final String message;
  QuotesError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

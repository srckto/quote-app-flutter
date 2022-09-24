part of 'random_quote_cubit.dart';

abstract class RandomQuoteState extends Equatable {
  const RandomQuoteState();

  @override
  List<Object> get props => [];
}

class RandomQuoteInitial extends RandomQuoteState {}

class RandomQuoteIsLoading extends RandomQuoteState {}

class RandomQuoteIsLoaded extends RandomQuoteState {
  final Quote quote;
  RandomQuoteIsLoaded({
    required this.quote,
  });
  @override
  List<Object> get props => [quote];
}

class RandomQuoteError extends RandomQuoteState {
  final String message;
  RandomQuoteError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

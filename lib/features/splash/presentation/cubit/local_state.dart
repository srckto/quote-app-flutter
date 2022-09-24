part of 'local_cubit.dart';

abstract class LocalState extends Equatable {
    final Locale locale;

  const LocalState({required this.locale});

  @override
  List<Object> get props => [locale];
}

class ChangeLocaleState extends LocalState {
  ChangeLocaleState({required super.locale});
}

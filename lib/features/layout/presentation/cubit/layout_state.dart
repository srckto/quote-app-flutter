part of 'layout_cubit.dart';

abstract class LayoutState extends Equatable {
  const LayoutState();

  @override
  List<Object> get props => [];
}

class LayoutInitial extends LayoutState {}

class LayoutIsChanged extends LayoutState {}

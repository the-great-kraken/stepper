part of 'bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TabChange extends HomeEvent {
  const TabChange(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

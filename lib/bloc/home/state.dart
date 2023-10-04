part of 'bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.index,
  });

  factory HomeState.initial() {
    return const HomeState(
      index: 0,
    );
  }

  final int index;

  @override
  List<Object> get props => [index];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<TabChange>(changeTab);
  }

  void changeTab(TabChange event, Emitter<HomeState> emit) async {
    emit(HomeState(index: event.index));
  }
}

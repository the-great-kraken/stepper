import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pedometer/pedometer.dart';

class StepCountEvent {
  const StepCountEvent({required this.step});

  final int step;
}

class StepCountState {
  StepCountState(this.stepCount);

  final int stepCount;
}

Stream<StepCount> stepCountStream = Pedometer.stepCountStream;

class StepCountBloc extends Bloc<StepCountEvent, StepCountState> {
  StepCountBloc() : super(StepCountState(0)) {
    stepCountStream.listen((event) {
      add(StepCountEvent(step: event.steps));
      print(event.steps);
    });
    on<StepCountEvent>(onStepCount);
  }

  Future<void> onStepCount(
      StepCountEvent event, Emitter<StepCountState> emit) async {
    emit(StepCountState(event.step));
  }
}

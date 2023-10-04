part of 'bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogout extends AppEvent {}

class AppSignUp extends AppEvent {
  const AppSignUp(this.email, this.password);

  final String email, password;

  @override
  List<Object> get props => [email, password];
}

class AppLogin extends AppEvent {
  const AppLogin(this.email, this.password);

  final String email, password;

  @override
  List<Object> get props => [email, password];
}

class AddAchievement extends AppEvent {
  const AddAchievement(this.index);

  final String index;

  @override
  List<Object> get props => [index];
}

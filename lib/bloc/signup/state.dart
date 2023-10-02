part of 'bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    required this.email,
    required this.password,
  });

  factory SignUpState.initial() {
    return SignUpState(
      email: TextEditingController(text: ''),
      password: TextEditingController(text: ''),
    );
  }

  final TextEditingController email;
  final TextEditingController password;

  @override
  List<Object> get props => [email];
}

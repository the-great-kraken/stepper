part of 'bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    required this.email,
    required this.password,
    required this.name,
  });

  factory SignUpState.initial() {
    return SignUpState(
      email: TextEditingController(text: ''),
      password: TextEditingController(text: ''),
      name: TextEditingController(text: ''),
    );
  }

  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController name;

  @override
  List<Object> get props => [email];
}

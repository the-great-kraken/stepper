part of 'bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState({
    required this.status,
    this.user = User.empty,
  });

  factory AppState.initial() {
    User currentUser = const User();
    String status = 'unauthenticated';

    firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      status = 'authenticated';
      currentUser = User(
        email: user.email,
        name: user.displayName,
        photo: user.photoURL,
      );
    }

    return AppState(status: status, user: currentUser);
  }

  final String status;
  final User user;

  @override
  List<Object> get props => [status, user];
}

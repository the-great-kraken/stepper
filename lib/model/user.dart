import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.email,
    this.name,
    this.photo,
    this.items = const [],
  });

  final String? email;
  final String? name;
  final String? photo;
  final List<String>? items;

  static const empty = User();

  bool get isEmpty => this == User.empty;

  @override
  List<Object?> get props => [email, name, photo, items];
}

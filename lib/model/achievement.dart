import 'package:equatable/equatable.dart';

class Achievement extends Equatable {
  const Achievement({
    required this.id,
    required this.name,
    required this.description,
    this.photo,
  });

  final String id;
  final String name;
  final String description;
  final String? photo;

  @override
  List<Object?> get props => [id, name, description, photo];
}

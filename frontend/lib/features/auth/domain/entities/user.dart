import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String role;
  final String? phoneNumber;

  const User({
    required this.id,
    required this.email,
    required this.role,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, email, role, phoneNumber];
}

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String mobile;
  final String? name;
  final String? email;
  final String kycStatus; // NONE, MINIMUM, FULL
  final bool isPinSet;

  const User({
    required this.id,
    required this.mobile,
    this.name,
    this.email,
    this.kycStatus = 'NONE',
    this.isPinSet = false,
  });

  @override
  List<Object?> get props => [id, mobile, name, email, kycStatus, isPinSet];
}
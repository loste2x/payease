import '../repositories/auth_repository.dart';

class SendOtp {
  final AuthRepository repository;

  SendOtp(this.repository);

  Future<void> call(String mobile) {
    return repository.sendOtp(mobile);
  }
}
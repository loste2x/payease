import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> sendOtp(String mobile) => remoteDataSource.sendOtp(mobile);

  @override
  Future<User> verifyOtp({required String mobile, required String otp}) =>
      remoteDataSource.verifyOtp(mobile: mobile, otp: otp);
}

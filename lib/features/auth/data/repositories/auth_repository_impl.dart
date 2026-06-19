import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> sendOtp(String mobile) async {
    return await remoteDataSource.sendOtp(mobile);
  }

  @override
  Future<User> verifyOtp({
    required String mobile,
    required String otp,
  }) async {
    return await remoteDataSource.verifyOtp(mobile: mobile, otp: otp);
  }
}
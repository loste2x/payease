import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/send_otp.dart';
import 'features/auth/domain/usecases/verify_otp.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ═══════════════════════════════════════════════════
  // 🔐 AUTH MODULE
  // ═══════════════════════════════════════════════════

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton(() => SendOtp(sl<AuthRepository>()));
  sl.registerLazySingleton(() => VerifyOtp(sl<AuthRepository>()));

  // Blocs (Factory — new instance each time)
  sl.registerFactory(
    () => AuthBloc(
      sendOtp: sl<SendOtp>(),
      verifyOtp: sl<VerifyOtp>(),
    ),
  );
}
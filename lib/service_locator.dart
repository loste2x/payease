import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/send_otp.dart';
import 'features/auth/domain/usecases/verify_otp.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

import 'features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'features/wallet/data/repositories/wallet_repository_impl.dart';
import 'features/wallet/domain/repositories/wallet_repository.dart';
import 'features/wallet/domain/usecases/add_money.dart';
import 'features/wallet/domain/usecases/get_balance.dart';
import 'features/wallet/domain/usecases/send_money.dart';
import 'features/wallet/domain/usecases/withdraw_money.dart';
import 'features/wallet/presentation/bloc/wallet_bloc.dart';

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

  // ═══════════════════════════════════════════════════
  // 💳 WALLET MODULE
  // ═══════════════════════════════════════════════════

  // Data Sources
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(remoteDataSource: sl<WalletRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetBalance(sl<WalletRepository>()));
  sl.registerLazySingleton(() => AddMoney(sl<WalletRepository>()));
  sl.registerLazySingleton(() => SendMoney(sl<WalletRepository>()));
  sl.registerLazySingleton(() => WithdrawMoney(sl<WalletRepository>()));

  // Blocs
  sl.registerFactory(
    () => WalletBloc(
      getBalance: sl<GetBalance>(),
      addMoney: sl<AddMoney>(),
      sendMoney: sl<SendMoney>(),
      withdrawMoney: sl<WithdrawMoney>(),
    ),
  );
}
#!/bin/bash

echo "🚀 PayEase Auth Module Setup Starting..."

# ===== route_names.dart =====
cat > lib/config/routes/route_names.dart << 'FILE1'
class RouteNames {
  static const String login = '/login';
  static const String otp = '/otp';
  static const String home = '/home';
}
FILE1
echo "✅ route_names.dart"

# ===== service_locator.dart =====
cat > lib/service_locator.dart << 'FILE2'
import 'package:get_it/get_it.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/send_otp.dart';
import 'features/auth/domain/usecases/verify_otp.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<AuthRemoteDataSource>()));
  sl.registerLazySingleton(() => SendOtp(sl<AuthRepository>()));
  sl.registerLazySingleton(() => VerifyOtp(sl<AuthRepository>()));
  sl.registerFactory(() => AuthBloc(sendOtp: sl<SendOtp>(), verifyOtp: sl<VerifyOtp>()));
}
FILE2
echo "✅ service_locator.dart"

# ===== app_router.dart =====
cat > lib/app_router.dart << 'FILE3'
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'config/routes/route_names.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/otp_page.dart';
import 'features/home/presentation/pages/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.login,
    routes: [
      GoRoute(path: RouteNames.login, builder: (context, state) => const LoginPage()),
      GoRoute(
        path: RouteNames.otp,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpPage(mobile: extra?['mobile'] as String? ?? '');
        },
      ),
      GoRoute(path: RouteNames.home, builder: (context, state) => const HomePage()),
    ],
  );
}
FILE3
echo "✅ app_router.dart"

# ===== app.dart =====
cat > lib/app.dart << 'FILE4'
import 'package:flutter/material.dart';
import 'app_router.dart';

class PayEaseApp extends StatelessWidget {
  const PayEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PayEase',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    );
  }
}
FILE4
echo "✅ app.dart"

# ===== main.dart =====
cat > lib/main.dart << 'FILE5'
import 'package:flutter/material.dart';
import 'app.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const PayEaseApp());
}
FILE5
echo "✅ main.dart"

# ===== user entity =====
cat > lib/features/auth/domain/entities/user.dart << 'FILE6'
class User {
  final String id;
  final String name;
  final String mobile;
  const User({required this.id, required this.name, required this.mobile});
}
FILE6
echo "✅ user.dart"

# ===== auth_repository.dart =====
cat > lib/features/auth/domain/repositories/auth_repository.dart << 'FILE7'
import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> sendOtp(String mobile);
  Future<User> verifyOtp({required String mobile, required String otp});
}
FILE7
echo "✅ auth_repository.dart"

# ===== send_otp.dart =====
cat > lib/features/auth/domain/usecases/send_otp.dart << 'FILE8'
import '../repositories/auth_repository.dart';

class SendOtp {
  final AuthRepository repository;
  SendOtp(this.repository);
  Future<void> call(String mobile) => repository.sendOtp(mobile);
}
FILE8
echo "✅ send_otp.dart"

# ===== verify_otp.dart =====
cat > lib/features/auth/domain/usecases/verify_otp.dart << 'FILE9'
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class VerifyOtp {
  final AuthRepository repository;
  VerifyOtp(this.repository);
  Future<User> call({required String mobile, required String otp}) =>
      repository.verifyOtp(mobile: mobile, otp: otp);
}
FILE9
echo "✅ verify_otp.dart"

# ===== user_model.dart =====
cat > lib/features/auth/data/models/user_model.dart << 'FILE10'
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.name, required super.mobile});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], name: json['name'], mobile: json['mobile']);
  }
}
FILE10
echo "✅ user_model.dart"

# ===== auth_remote_datasource.dart =====
cat > lib/features/auth/data/datasources/auth_remote_datasource.dart << 'FILE11'
import '../models/user_model.dart';

class AuthRemoteDataSource {
  Future<void> sendOtp(String mobile) async {
    await Future.delayed(const Duration(seconds: 1));
    if (mobile.length != 10) throw Exception('Enter valid 10-digit number');
  }

  Future<UserModel> verifyOtp({required String mobile, required String otp}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (otp != '123456') throw Exception('Invalid OTP. Demo OTP: 123456');
    return UserModel(id: 'user_001', name: 'PayEase User', mobile: mobile);
  }
}
FILE11
echo "✅ auth_remote_datasource.dart"

# ===== auth_repository_impl.dart =====
cat > lib/features/auth/data/repositories/auth_repository_impl.dart << 'FILE12'
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
FILE12
echo "✅ auth_repository_impl.dart"

# ===== auth_event.dart =====
cat > lib/features/auth/presentation/bloc/auth_event.dart << 'FILE13'
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String mobile;
  const SendOtpEvent(this.mobile);
  @override
  List<Object?> get props => [mobile];
}

class VerifyOtpEvent extends AuthEvent {
  final String mobile;
  final String otp;
  const VerifyOtpEvent({required this.mobile, required this.otp});
  @override
  List<Object?> get props => [mobile, otp];
}
FILE13
echo "✅ auth_event.dart"

# ===== auth_state.dart =====
cat > lib/features/auth/presentation/bloc/auth_state.dart << 'FILE14'
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

class OtpSentState extends AuthState {
  final String mobile;
  const OtpSentState(this.mobile);
  @override
  List<Object?> get props => [mobile];
}

class AuthenticatedState extends AuthState {
  final User user;
  const AuthenticatedState(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthErrorState extends AuthState {
  final String message;
  const AuthErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
FILE14
echo "✅ auth_state.dart"

# ===== auth_bloc.dart =====
cat > lib/features/auth/presentation/bloc/auth_bloc.dart << 'FILE15'
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtp sendOtp;
  final VerifyOtp verifyOtp;

  AuthBloc({required this.sendOtp, required this.verifyOtp}) : super(AuthInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await sendOtp(event.mobile);
        emit(OtpSentState(event.mobile));
      } catch (e) {
        emit(AuthErrorState(e.toString().replaceFirst('Exception: ', '')));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await verifyOtp(mobile: event.mobile, otp: event.otp);
        emit(AuthenticatedState(user));
      } catch (e) {
        emit(AuthErrorState(e.toString().replaceFirst('Exception: ', '')));
      }
    });
  }
}
FILE15
echo "✅ auth_bloc.dart"

# ===== login_page.dart =====
cat > lib/features/auth/presentation/pages/login_page.dart << 'FILE16'
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_names.dart';
import '../../../../service_locator.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileCtrl = TextEditingController();

  @override
  void dispose() { mobileCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpSentState) {
            context.go(RouteNames.otp, extra: {'mobile': state.mobile});
          }
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_balance_wallet, size: 72, color: Colors.indigo),
                      const SizedBox(height: 16),
                      const Text('PayEase', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Payments Made Easy!', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 32),
                      TextField(
                        controller: mobileCtrl,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: '',
                          prefixText: '+91 ',
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: state is AuthLoading ? null : () {
                                final m = mobileCtrl.text.trim();
                                if (m.length != 10) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Enter valid 10-digit number')));
                                  return;
                                }
                                context.read<AuthBloc>().add(SendOtpEvent(m));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: state is AuthLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text('Send OTP', style: TextStyle(fontSize: 16)),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('Demo OTP: 123456', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
FILE16
echo "✅ login_page.dart"

# ===== otp_page.dart =====
cat > lib/features/auth/presentation/pages/otp_page.dart << 'FILE17'
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_names.dart';
import '../../../../service_locator.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class OtpPage extends StatefulWidget {
  final String mobile;
  const OtpPage({super.key, required this.mobile});
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otpCtrl = TextEditingController();

  @override
  void dispose() { otpCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) context.go(RouteNames.home);
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Verify OTP')),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.sms, size: 64, color: Colors.indigo),
                    const SizedBox(height: 16),
                    Text('OTP sent to +91 ${widget.mobile}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 24),
                    TextField(
                      controller: otpCtrl,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, letterSpacing: 8),
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Enter 6-digit OTP',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: state is AuthLoading ? null : () {
                              final otp = otpCtrl.text.trim();
                              if (otp.length != 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Enter valid 6-digit OTP')));
                                return;
                              }
                              context.read<AuthBloc>().add(
                                VerifyOtpEvent(mobile: widget.mobile, otp: otp));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: state is AuthLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text('Verify OTP', style: TextStyle(fontSize: 16)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Demo OTP: 123456', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
FILE17
echo "✅ otp_page.dart"

# ===== home_page.dart =====
mkdir -p lib/features/home/presentation/pages
cat > lib/features/home/presentation/pages/home_page.dart << 'FILE18'
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PayEase'), centerTitle: true),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text('Login Successful!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Welcome to PayEase', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
FILE18
echo "✅ home_page.dart"

echo ""
echo "🎉🎉🎉 ALL AUTH FILES CREATED SUCCESSFULLY! 🎉🎉🎉"
echo ""
echo "Now run:"
echo "  flutter pub get"
echo "  flutter run -d web-server --web-hostname=0.0.0.0 --web-port=3000"

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

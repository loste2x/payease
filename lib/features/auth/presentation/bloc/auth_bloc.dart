import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtp sendOtp;
  final VerifyOtp verifyOtp;

  AuthBloc({
    required this.sendOtp,
    required this.verifyOtp,
  }) : super(const AuthInitial()) {
    on<SendOtpRequested>(_onSendOtpRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<AuthReset>(_onAuthReset);
  }

  Future<void> _onSendOtpRequested(
    SendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await sendOtp(event.mobile);
      emit(OtpSentSuccess(event.mobile));
    } catch (e) {
      emit(AuthFailure(_cleanError(e.toString())));
    }
  }

  Future<void> _onVerifyOtpRequested(
    VerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await verifyOtp(
        VerifyOtpParams(mobile: event.mobile, otp: event.otp),
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthFailure(_cleanError(e.toString())));
    }
  }

  void _onAuthReset(AuthReset event, Emitter<AuthState> emit) {
    emit(const AuthInitial());
  }

  String _cleanError(String error) {
    return error.replaceFirst('Exception: ', '');
  }
}
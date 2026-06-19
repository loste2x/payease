import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../service_locator.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class OtpPage extends StatelessWidget {
  final String mobile;

  const OtpPage({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: _OtpView(mobile: mobile),
    );
  }
}

class _OtpView extends StatefulWidget {
  final String mobile;

  const _OtpView({required this.mobile});

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  final _otpController = TextEditingController();
  String _otp = '';
  int _timerSeconds = AppConstants.otpTimerSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timerSeconds = AppConstants.otpTimerSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timerSeconds > 0) {
            _timerSeconds--;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  void _onResendOtp() {
    _otpController.clear();
    setState(() => _otp = '');
    context.read<AuthBloc>().add(SendOtpRequested(widget.mobile));
    _startTimer();
    context.showSnackBar('OTP resent successfully');
  }

  void _onVerifyOtp() {
    if (_otp.length == AppConstants.otpLength) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
            VerifyOtpRequested(mobile: widget.mobile, otp: _otp),
          );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(RouteNames.home);
        } else if (state is AuthFailure) {
          context.showSnackBar(state.message, isError: true);
          _otpController.clear();
          setState(() => _otp = '');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.xxl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppSizes.maxFormWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),

                    // Icon
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: context.colors.primaryContainer,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(
                          Icons.sms_outlined,
                          color: context.colors.primary,
                          size: 40,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSizes.xxl),

                    // Heading
                    Text(
                      'Verification Code',
                      textAlign: TextAlign.center,
                      style: context.textStyles.headlineSmall,
                    ),

                    const SizedBox(height: AppSizes.sm),

                    // Subheading
                    Text.rich(
                      TextSpan(
                        text: 'We sent a 6-digit code to\n',
                        style: context.textStyles.bodyMedium,
                        children: [
                          TextSpan(
                            text: Formatters.mobile(widget.mobile),
                            style: context.textStyles.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: context.colors.onSurface,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppSizes.xxxl),

                    // OTP Input
                    PinCodeTextField(
                      appContext: context,
                      length: AppConstants.otpLength,
                      controller: _otpController,
                      autoFocus: true,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      enableActiveFill: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        fieldHeight: 56,
                        fieldWidth: 48,
                        activeColor: context.colors.primary,
                        inactiveColor: AppColors.outlineVariant,
                        selectedColor: context.colors.primary,
                        activeFillColor: AppColors.surfaceContainerHigh,
                        inactiveFillColor: AppColors.surfaceContainerHigh,
                        selectedFillColor: context.colors.primaryContainer.withValues(alpha: 0.3),
                        borderWidth: 1.5,
                      ),
                      textStyle: context.textStyles.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      cursorColor: context.colors.primary,
                      animationDuration: const Duration(milliseconds: 200),
                      onChanged: (value) {
                        setState(() => _otp = value);
                      },
                      onCompleted: (_) => _onVerifyOtp(),
                    ),

                    const SizedBox(height: AppSizes.xl),

                    // Resend Timer
                    Center(
                      child: _timerSeconds > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 16,
                                  color: context.colors.onSurfaceVariant,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Resend OTP in ${_timerSeconds}s',
                                  style: context.textStyles.bodyMedium,
                                ),
                              ],
                            )
                          : TextButton.icon(
                              onPressed: _onResendOtp,
                              icon: const Icon(Icons.refresh_rounded, size: 18),
                              label: const Text('Resend OTP'),
                            ),
                    ),

                    const SizedBox(height: AppSizes.xxl),

                    // Verify Button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          label: AppStrings.verifyOtp,
                          type: ButtonType.primary,
                          icon: Icons.check_circle_outline_rounded,
                          isLoading: state is AuthLoading,
                          onPressed: _otp.length == AppConstants.otpLength
                              ? _onVerifyOtp
                              : null,
                        );
                      },
                    ),

                    const SizedBox(height: AppSizes.xl),

                    // Demo OTP info
                    Container(
                      padding: const EdgeInsets.all(AppSizes.md),
                      decoration: BoxDecoration(
                        color: AppColors.warningContainer,
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.warning,
                            size: 18,
                          ),
                          const SizedBox(width: AppSizes.sm),
                          Expanded(
                            child: Text(
                              AppStrings.demoOtp,
                              style: context.textStyles.bodySmall?.copyWith(
                                color: AppColors.warning,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
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
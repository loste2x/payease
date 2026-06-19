import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../service_locator.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _mobileController.addListener(_validateInput);
  }

  void _validateInput() {
    setState(() {
      _isValid = _mobileController.text.length == AppConstants.mobileLength;
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  void _onSendOtp() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(SendOtpRequested(_mobileController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSentSuccess) {
          context.push(
            RouteNames.otp,
            extra: {'mobile': state.mobile},
          );
        } else if (state is AuthFailure) {
          context.showSnackBar(state.message, isError: true);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.xxl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppSizes.maxFormWidth),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),

                      // App Logo
                      Center(
                        child: Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.25),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_rounded,
                            color: Colors.white,
                            size: 44,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSizes.xxl),

                      // App Name
                      Text(
                        AppStrings.appName,
                        textAlign: TextAlign.center,
                        style: context.textStyles.headlineLarge,
                      ),

                      const SizedBox(height: AppSizes.xs),

                      // Tagline
                      Text(
                        AppStrings.appTagline,
                        textAlign: TextAlign.center,
                        style: context.textStyles.bodyMedium,
                      ),

                      const SizedBox(height: 48),

                      // Heading
                      Text(
                        'Welcome 👋',
                        style: context.textStyles.headlineSmall,
                      ),

                      const SizedBox(height: AppSizes.xs),

                      Text(
                        'Login with your mobile number to continue',
                        style: context.textStyles.bodyMedium,
                      ),

                      const SizedBox(height: AppSizes.xxl),

                      // Mobile Number Input
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        maxLength: AppConstants.mobileLength,
                        autofocus: true,
                        style: context.textStyles.titleLarge?.copyWith(
                          letterSpacing: 1.2,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: AppStrings.mobileNumber,
                          hintText: '9876543210',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Text(
                              '🇮🇳  +91',
                              style: context.textStyles.titleMedium,
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 80,
                          ),
                        ),
                        validator: Validators.mobile,
                        onFieldSubmitted: (_) => _onSendOtp(),
                      ),

                      const SizedBox(height: AppSizes.xl),

                      // Send OTP Button
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return CustomButton(
                            label: AppStrings.sendOtp,
                            type: ButtonType.primary,
                            icon: Icons.arrow_forward_rounded,
                            isLoading: state is AuthLoading,
                            onPressed: _isValid ? _onSendOtp : null,
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

                      const SizedBox(height: AppSizes.xxxl),

                      // T&C
                      Text.rich(
                        TextSpan(
                          text: 'By continuing, you agree to our ',
                          style: context.textStyles.bodySmall,
                          children: [
                            TextSpan(
                              text: 'Terms',
                              style: TextStyle(
                                color: context.colors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: ' & '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: context.colors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
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
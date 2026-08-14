import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/cubit/code_check/code_check_cubit.dart';
import 'package:wlcd/presentation/screens/login/widgets/forgot_password_bottom_sheet.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_text_field.dart';
import 'package:wlcd/presentation/widgets/custom_elevated_button.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';
import 'package:wlcd/domain/entity/auth/login_with_password_entity.dart';
import 'package:wlcd/domain/entity/auth/request_login_otp_entity.dart';
import 'package:wlcd/presentation/bloc/auth/login_with_password/login_with_password_bloc.dart';
import 'package:wlcd/presentation/bloc/auth/request_login_otp/request_login_otp_bloc.dart';
import 'package:wlcd/presentation/widgets/custom_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key, required this.formKey, required this.isPhoneLogin});

  final GlobalKey<FormState> formKey;
  final bool isPhoneLogin;

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginWithPasswordBloc, ILoginWithPasswordState>(
          listener: _onPasswordLoginState,
        ),
        BlocListener<RequestLoginOtpBloc, IRequestLoginOtpState>(
          listener: _onLoginOtpRequestState,
        ),
      ],
      child: Form(
        key: widget.formKey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isPhoneLogin) ...[
            LoginTextField(
              controller: _phoneController,
              icon: Icons.phone_outlined,
              hintText: context.loc.enter_phone_number,
              keyboardType: TextInputType.phone,
              validator: (value) => _validatePhone(context, value),
            ),
          ] else ...[
            LoginTextField(
              controller: _emailController,
              icon: Icons.email_outlined,
              hintText: context.loc.your_email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => _validateEmail(context, value),
            ),
            SizedBox(height: AppHeight.h14),
            LoginTextField(
              controller: _passwordController,
              icon: Icons.lock,
              hintText: context.loc.your_password,
              obscureText: true,
              suffixIcon: Icons.visibility_off_outlined,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) => _validatePassword(context, value),
            ),
            SizedBox(height: AppHeight.h14),
            TextButton(
              onPressed: () => showForgotPasswordBottomSheet(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: AppColors.loginTabIndicator,
              ),
              child: SectionTitle(
                text: context.loc.forgot_password,
                color: AppColors.loginTabIndicator,
                fontSize: AppFontSize.s15,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ],
          BlocBuilder<LoginWithPasswordBloc, ILoginWithPasswordState>(
            builder: (context, passwordState) {
              return BlocBuilder<RequestLoginOtpBloc, IRequestLoginOtpState>(
                builder: (context, otpState) {
                  final isLoading =
                      passwordState is LoginWithPasswordLoading ||
                      otpState is RequestLoginOtpLoading;
                  return CustomSubmitButton(
                    title: context.loc.sign_in,
                    marginTop: AppMarginHeight.m30,
                    borderRadius: AppRadius.r24,
                    buttonColor: AppColors.loginPrimary,
                    isLoading: isLoading,
                    verification: !isLoading,
                    onPressed: _submit,
                  );
                },
              );
            },
          ),
          SizedBox(height: AppHeight.h26),
          const _LoginOrDivider(),
          SizedBox(height: AppHeight.h22),
          const _CreateAccountButton(),
        ],
        ),
      ),
    );
  }

  void _submit() {
    if (!(widget.formKey.currentState?.validate() ?? false)) return;
    if (widget.isPhoneLogin) {
      context.read<RequestLoginOtpBloc>().add(
        SubmitRequestLoginOtpEvent(
          RequestLoginOtpEntity(phone: _phoneController.text.trim()),
        ),
      );
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    context.read<LoginWithPasswordBloc>().add(
      SubmitLoginWithPasswordEvent(
        LoginWithPasswordEntity(
          email: email,
          password: password,
          rememberMe: false,
        ),
      ),
    );
  }

  void _onPasswordLoginState(
    BuildContext context,
    ILoginWithPasswordState state,
  ) {
    if (state is LoginWithPasswordLoaded) {
      HomeRoute().go(context);
    } else if (state is LoginWithPasswordFailed) {
      _showFailure(context, state.message);
    }
  }

  void _onLoginOtpRequestState(
    BuildContext context,
    IRequestLoginOtpState state,
  ) {
    if (state is RequestLoginOtpLoaded) {
      final challengeId = state.challenge?.data?.challengeId;
      if (challengeId == null || challengeId.isEmpty) {
        _showFailure(context, 'لم يتم استلام معرّف التحقق');
        return;
      }
      context.read<CodeCheckCubit>()
        ..setPhone(_phoneController.text.trim())
        ..setType('sms', '')
        ..setChallengeId(challengeId);
      CheckCodeRoute().push(context);
    } else if (state is RequestLoginOtpFailed) {
      _showFailure(context, state.message);
    }
  }

  void _showFailure(BuildContext context, String message) {
    showCustomSnackBar(
      context: context,
      title: 'خطأ',
      message: message,
      contentType: ContentType.failure,
    );
  }

  String? _validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.loc.enter_email_validation;
    }
    if (!value.isValidEmail) {
      return context.loc.invalid_email_validation;
    }
    return null;
  }

  String? _validatePhone(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.enter_phone_number;
    }
    return null;
  }

  String? _validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.loc.enter_password_validation;
    }
    if (value.length < 6) {
      return context.loc.short_password_validation;
    }
    return null;
  }
}

class _LoginOrDivider extends StatelessWidget {
  const _LoginOrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.loginDivider, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w12),
          child: SectionTitle(
            text: 'أو',
            color: AppColors.loginDarkText,
            fontSize: AppFontSize.s18,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        const Expanded(child: Divider(color: AppColors.loginDivider, thickness: 1)),
      ],
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton();

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {},
      width: double.infinity,
      borderRadius: AppRadius.r24,
      color: AppColors.loginPrimary,
      child: Text.rich(
        TextSpan(
          text: 'هل أنت جديد على WLCD؟ ',
          children: [
            TextSpan(
              text: 'إنشاء حساب!',
              style: TextStyle(fontWeight: AppFontWeight.extraBold),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.white, fontSize: AppFontSize.s14, fontWeight: AppFontWeight.extraBold),
      ),
    );
  }
}

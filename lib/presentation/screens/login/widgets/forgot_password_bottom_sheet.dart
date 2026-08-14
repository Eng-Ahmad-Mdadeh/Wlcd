import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_text_field.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/auth/request_password_reset_entity.dart';
import 'package:wlcd/domain/entity/auth/reset_password_entity.dart';
import 'package:wlcd/presentation/bloc/auth/request_password_reset/request_password_reset_bloc.dart';
import 'package:wlcd/presentation/bloc/auth/reset_password/reset_password_bloc.dart';
import 'package:wlcd/presentation/widgets/custom_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

Future<void> showForgotPasswordBottomSheet(BuildContext context) {
  final requestPasswordResetBloc = context.read<RequestPasswordResetBloc>();
  final resetPasswordBloc = context.read<ResetPasswordBloc>();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.none,
    barrierColor: const Color(0x940F172A),
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: requestPasswordResetBloc),
        BlocProvider.value(value: resetPasswordBloc),
      ],
      child: const ForgotPasswordBottomSheet(),
    ),
  );
}

class ForgotPasswordBottomSheet extends StatefulWidget {
  const ForgotPasswordBottomSheet({super.key});

  @override
  State<ForgotPasswordBottomSheet> createState() => _ForgotPasswordBottomSheetState();
}

enum _ForgotPasswordView { method, email, phone, reset }

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  _ForgotPasswordView _currentView = _ForgotPasswordView.method;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _tokenController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewInsets = MediaQuery.viewInsetsOf(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<RequestPasswordResetBloc, IRequestPasswordResetState>(
          listener: _onPasswordResetRequestState,
        ),
        BlocListener<ResetPasswordBloc, IResetPasswordState>(
          listener: _onPasswordResetState,
        ),
      ],
      child: AnimatedPadding(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          AppPaddingWidth.p23,
          AppPaddingHeight.p20,
          AppPaddingWidth.p23,
          AppPaddingHeight.p30,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.r24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CloseButton(onPressed: () => Navigator.of(context).pop()),
              SizedBox(height: AppHeight.h18),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: _buildCurrentView(context),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildCurrentView(BuildContext context) {
    return switch (_currentView) {
      _ForgotPasswordView.method => _MethodPickerView(
        key: const ValueKey<String>('methodView'),
        onEmailPressed: () => _showView(_ForgotPasswordView.email),
        onPhonePressed: () => _showView(_ForgotPasswordView.phone),
      ),
      _ForgotPasswordView.email => _ResetInputView(
        key: const ValueKey<String>('emailView'),
        formKey: _emailFormKey,
        title: context.loc.enter_your_email,
        description: context.loc.reset_password_email_message,
        icon: Icons.email_outlined,
        hintText: context.loc.your_email,
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        buttonTitle: context.loc.send_link,
        validator: (value) => _validateEmail(context, value),
        onUseAnotherMethod: () => _showView(_ForgotPasswordView.method),
        onSubmit: () => _submitResetRequest(_emailFormKey),
      ),
      _ForgotPasswordView.phone => _ResetInputView(
        key: const ValueKey<String>('phoneView'),
        formKey: _phoneFormKey,
        title: context.loc.enter_your_phone_number,
        description: context.loc.reset_password_phone_message,
        icon: Icons.phone_outlined,
        hintText: context.loc.enter_phone_number,
        keyboardType: TextInputType.phone,
        controller: _phoneController,
        buttonTitle: context.loc.send_link,
        // validator: (value) => _validatePhone(context, value),
        validator: (p0) {},
        onUseAnotherMethod: () => _showView(_ForgotPasswordView.method),
        onSubmit: () => _submitResetRequest(_phoneFormKey),
      ),
      _ForgotPasswordView.reset => _PasswordResetView(
        key: const ValueKey<String>('resetView'),
        formKey: _resetFormKey,
        tokenController: _tokenController,
        passwordController: _newPasswordController,
        onUseAnotherMethod: () => _showView(_ForgotPasswordView.method),
        tokenValidator: (value) => _validateRequired(context, value),
        passwordValidator: (value) => _validateNewPassword(context, value),
        onSubmit: _submitPasswordReset,
      ),
    };
  }

  void _showView(_ForgotPasswordView view) {
    setState(() => _currentView = view);
  }

  void _submitResetRequest(GlobalKey<FormState> formKey) {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (_currentView != _ForgotPasswordView.email) {
      showCustomSnackBar(
        context: context,
        title: 'تنبيه',
        message: 'استعادة كلمة المرور متاحة عبر البريد الإلكتروني حالياً',
        contentType: ContentType.warning,
      );
      return;
    }
    context.read<RequestPasswordResetBloc>().add(
      SubmitRequestPasswordResetEvent(
        RequestPasswordResetEntity(email: _emailController.text.trim()),
      ),
    );
  }

  void _onPasswordResetRequestState(
    BuildContext context,
    IRequestPasswordResetState state,
  ) {
    if (state is RequestPasswordResetLoaded) {
      showCustomSnackBar(
        context: context,
        title: context.loc.success,
        message: context.loc.password_reset_link_sent,
        contentType: ContentType.success,
      );
      _showView(_ForgotPasswordView.reset);
    } else if (state is RequestPasswordResetFailed) {
      showCustomSnackBar(
        context: context,
        title: 'خطأ',
        message: state.message,
        contentType: ContentType.failure,
      );
    }
  }


  void _submitPasswordReset() {
    if (!(_resetFormKey.currentState?.validate() ?? false)) return;
    context.read<ResetPasswordBloc>().add(
      SubmitResetPasswordEvent(
        ResetPasswordEntity(
          token: _tokenController.text.trim(),
          newPassword: _newPasswordController.text,
        ),
      ),
    );
  }

  void _onPasswordResetState(BuildContext context, IResetPasswordState state) {
    if (state is ResetPasswordLoaded) {
      final messenger = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text(context.loc.success)),
      );
    } else if (state is ResetPasswordFailed) {
      showCustomSnackBar(
        context: context,
        title: context.loc.error,
        message: state.message,
        contentType: ContentType.failure,
      );
    }
  }

  String? _validateRequired(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.fill_all_fields;
    }
    return null;
  }

  String? _validateNewPassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.loc.enter_password_validation;
    }
    if (value.length < 6) {
      return context.loc.short_password_validation;
    }
    return null;
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

  //
  // String? _validatePhone(BuildContext context, String? value) {
  //   if (value == null || value.isEmpty || !value.isValidPhone) {
  //     return context.loc.enter_valid_phone;
  //   }
  //   return null;
  // }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppWidth.w22,
      height: AppHeight.h22,
      child: DecoratedBox(
        decoration: BoxDecoration(color: AppColors.greyButton, shape: BoxShape.circle),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.close, color: AppColors.loginFieldHint, size: AppSize.s14),
          padding: EdgeInsets.zero,
          splashRadius: AppRadius.r14,
        ),
      ),
    );
  }
}

class _MethodPickerView extends StatelessWidget {
  const _MethodPickerView({super.key, required this.onEmailPressed, required this.onPhonePressed});

  final VoidCallback onEmailPressed;
  final VoidCallback onPhonePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SheetTitle(text: context.loc.forgot_password),
        SizedBox(height: AppHeight.h8),
        _SheetDescription(text: context.loc.choose_password_reset_method),
        SizedBox(height: AppHeight.h22),
        _MethodCard(
          icon: Icons.email_outlined,
          title: context.loc.your_email,
          subtitle: context.loc.enter_your_email,
          onPressed: onEmailPressed,
        ),
        SizedBox(height: AppHeight.h14),
        _MethodCard(
          icon: Icons.phone_outlined,
          title: context.loc.phone_number,
          subtitle: context.loc.enter_your_phone_number,
          onPressed: onPhonePressed,
        ),
      ],
    );
  }
}

class _ResetInputView extends StatelessWidget {
  const _ResetInputView({
    super.key,
    required this.formKey,
    required this.title,
    required this.description,
    required this.icon,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.buttonTitle,
    required this.validator,
    required this.onUseAnotherMethod,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final String title;
  final String description;
  final IconData icon;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String buttonTitle;
  final String? Function(String?) validator;
  final VoidCallback onUseAnotherMethod;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SheetTitle(text: title),
          SizedBox(height: AppHeight.h8),
          _SheetDescription(text: description),
          SizedBox(height: AppHeight.h22),
          LoginTextField(
            controller: controller,
            icon: icon,
            hintText: hintText,
            keyboardType: keyboardType,
            validator: validator,
          ),
          SizedBox(height: AppHeight.h12),
          TextButton(
            onPressed: onUseAnotherMethod,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: AppColors.loginTabIndicator,
            ),
            child: Text(
              context.loc.use_another_method,
              style: TextStyle(
                color: AppColors.loginTabIndicator,
                fontSize: AppFontSize.s14,
                fontWeight: AppFontWeight.semiBold,
                fontFamily: AppFontFamily.rubik,
              ),
            ),
          ),
          BlocBuilder<RequestPasswordResetBloc, IRequestPasswordResetState>(
            builder: (context, state) => CustomSubmitButton(
              title: buttonTitle,
              marginTop: AppMarginHeight.m20,
              height: AppHeight.h55,
              borderRadius: AppRadius.r28,
              elevation: 0,
              buttonColor: AppColors.loginPrimary,
              isLoading: state is RequestPasswordResetLoading,
              verification: state is! RequestPasswordResetLoading,
              onPressed: onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordResetView extends StatelessWidget {
  const _PasswordResetView({
    super.key,
    required this.formKey,
    required this.tokenController,
    required this.passwordController,
    required this.tokenValidator,
    required this.passwordValidator,
    required this.onUseAnotherMethod,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController tokenController;
  final TextEditingController passwordController;
  final String? Function(String?) tokenValidator;
  final String? Function(String?) passwordValidator;
  final VoidCallback onUseAnotherMethod;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SheetTitle(text: context.loc.forgot_password),
          SizedBox(height: AppHeight.h8),
          const _SheetDescription(
            text: 'Enter the reset token from your email and choose a new password.',
          ),
          SizedBox(height: AppHeight.h22),
          LoginTextField(
            controller: tokenController,
            icon: Icons.key_outlined,
            hintText: 'Reset token',
            keyboardType: TextInputType.text,
            validator: tokenValidator,
          ),
          SizedBox(height: AppHeight.h12),
          LoginTextField(
            controller: passwordController,
            icon: Icons.lock_outline,
            hintText: context.loc.your_password,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: passwordValidator,
          ),
          SizedBox(height: AppHeight.h12),
          TextButton(
            onPressed: onUseAnotherMethod,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: AppColors.loginTabIndicator,
            ),
            child: Text(
              context.loc.use_another_method,
              style: TextStyle(
                color: AppColors.loginTabIndicator,
                fontSize: AppFontSize.s14,
                fontWeight: AppFontWeight.semiBold,
                fontFamily: AppFontFamily.rubik,
              ),
            ),
          ),
          BlocBuilder<ResetPasswordBloc, IResetPasswordState>(
            builder: (context, state) => CustomSubmitButton(
              title: 'Reset Password',
              marginTop: AppMarginHeight.m20,
              height: AppHeight.h55,
              borderRadius: AppRadius.r28,
              elevation: 0,
              buttonColor: AppColors.loginPrimary,
              isLoading: state is ResetPasswordLoading,
              verification: state is! ResetPasswordLoading,
              onPressed: onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({required this.icon, required this.title, required this.subtitle, required this.onPressed});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF8F9FB),
      borderRadius: BorderRadius.circular(AppRadius.r14),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.r14),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p16, vertical: AppPaddingHeight.p14),
          child: Row(
            children: [
              Container(
                width: AppWidth.w38,
                height: AppHeight.h38,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.r10),
                  border: Border.all(color: AppColors.lightGrey),
                ),
                child: Icon(icon, color: AppColors.loginBackIcon, size: AppSize.s19),
              ),
              SizedBox(width: AppWidth.w14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.loginDarkText,
                        fontSize: AppFontSize.s13,
                        fontWeight: AppFontWeight.extraBold,
                        fontFamily: AppFontFamily.rubik,
                      ),
                    ),
                    SizedBox(height: AppHeight.h4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColors.loginTabInactive,
                        fontSize: AppFontSize.s12,
                        fontWeight: AppFontWeight.regular,
                        fontFamily: AppFontFamily.rubik,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.loginFieldHint, size: AppSize.s25),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetTitle extends StatelessWidget {
  const _SheetTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.loginDarkText,
        fontSize: AppFontSize.s20,
        fontWeight: AppFontWeight.extraBold,
        fontFamily: AppFontFamily.rubik,
      ),
    );
  }
}

class _SheetDescription extends StatelessWidget {
  const _SheetDescription({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.loginTabInactive,
        fontSize: AppFontSize.s14,
        height: 1.45,
        fontFamily: AppFontFamily.rubik,
      ),
    );
  }
}

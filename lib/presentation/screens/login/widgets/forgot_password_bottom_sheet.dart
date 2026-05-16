import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_text_field.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';

Future<void> showForgotPasswordBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.none,
    barrierColor: const Color(0x940F172A),
    builder: (context) => const ForgotPasswordBottomSheet(),
  );
}

class ForgotPasswordBottomSheet extends StatefulWidget {
  const ForgotPasswordBottomSheet({super.key});

  @override
  State<ForgotPasswordBottomSheet> createState() => _ForgotPasswordBottomSheetState();
}

enum _ForgotPasswordView { method, email, phone }

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();

  _ForgotPasswordView _currentView = _ForgotPasswordView.method;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewInsets = MediaQuery.viewInsetsOf(context);

    return AnimatedPadding(
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
        buttonTitle: context.loc.send_link,
        validator: (value) => _validatePhone(context, value),
        onUseAnotherMethod: () => _showView(_ForgotPasswordView.method),
        onSubmit: () => _submitResetRequest(_phoneFormKey),
      ),
    };
  }

  void _showView(_ForgotPasswordView view) {
    setState(() => _currentView = view);
  }

  void _submitResetRequest(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() ?? false) {
      final ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
      final String successMessage = context.loc.password_reset_link_sent;

      Navigator.of(context).pop();
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(successMessage)));
    }
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
    if (value == null || value.isEmpty || !value.isValidPhone) {
      return context.loc.enter_valid_phone;
    }
    return null;
  }
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
        decoration: BoxDecoration(
          color: AppColors.greyButton,
          shape: BoxShape.circle,
        ),
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
          CustomSubmitButton(
            title: buttonTitle,
            marginTop: AppMarginHeight.m20,
            height: AppHeight.h55,
            borderRadius: AppRadius.r28,
            elevation: 0,
            buttonColor: AppColors.loginPrimary,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

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
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddingWidth.p16,
            vertical: AppPaddingHeight.p14,
          ),
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

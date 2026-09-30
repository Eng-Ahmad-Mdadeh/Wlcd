import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/domain/entity/auth/register_with_email_entity.dart';
import 'package:wlcd/domain/entity/auth/verify_email_entity.dart';
import 'package:wlcd/presentation/bloc/auth/register_with_email/register_with_email_bloc.dart';
import 'package:wlcd/presentation/bloc/auth/verify_email/verify_email_bloc.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_text_field.dart';
import 'package:wlcd/presentation/widgets/custom_snack_bar.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';

Future<void> showRegisterEmailBottomSheet(BuildContext context) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  backgroundColor: Colors.transparent,
  builder: (_) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: context.read<RegisterWithEmailBloc>()),
      BlocProvider.value(value: context.read<VerifyEmailBloc>()),
    ],
    child: const _RegisterEmailSheet(),
  ),
);

class _RegisterEmailSheet extends StatefulWidget {
  const _RegisterEmailSheet();

  @override
  State<_RegisterEmailSheet> createState() => _RegisterEmailSheetState();
}

class _RegisterEmailSheetState extends State<_RegisterEmailSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _code = TextEditingController();
  String? _challengeId;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    padding: EdgeInsets.fromLTRB(
      AppWidth.w20,
      AppHeight.h12,
      AppWidth.w20,
      MediaQuery.viewInsetsOf(context).bottom + AppHeight.h24,
    ),
    child: MultiBlocListener(
      listeners: [
        BlocListener<RegisterWithEmailBloc, IRegisterWithEmailState>(listener: _onRegisterState),
        BlocListener<VerifyEmailBloc, IVerifyEmailState>(listener: _onVerifyState),
      ],
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Container(width: 42, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)))),
              SizedBox(height: AppHeight.h20),
              Text(_challengeId == null ? 'إنشاء حساب جديد' : 'تحقق من بريدك الإلكتروني', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: AppHeight.h8),
              Text(_challengeId == null ? 'أدخل بياناتك للانضمام إلى WLCD' : 'أدخل رمز التحقق الذي أرسلناه إلى ${_email.text}', style: TextStyle(color: Colors.grey.shade600)),
              SizedBox(height: AppHeight.h24),
              if (_challengeId == null) ...[
                LoginTextField(controller: _name, icon: Icons.person_outline, hintText: context.loc.name, keyboardType: TextInputType.name, validator: _required),
                SizedBox(height: AppHeight.h14),
                LoginTextField(controller: _email, icon: Icons.email_outlined, hintText: context.loc.email, keyboardType: TextInputType.emailAddress, validator: (value) => (value ?? '').isValidEmail ? null : context.loc.invalid_email_validation),
                SizedBox(height: AppHeight.h14),
                LoginTextField(controller: _password, icon: Icons.lock_outline, hintText: context.loc.your_password, keyboardType: TextInputType.visiblePassword, obscureText: true, validator: (value) => (value ?? '').length >= 6 ? null : context.loc.short_password_validation),
              ] else
                LoginTextField(controller: _code, icon: Icons.verified_outlined, hintText: context.loc.verification_code, keyboardType: TextInputType.number, validator: _required),
              BlocBuilder<RegisterWithEmailBloc, IRegisterWithEmailState>(
                builder: (context, registerState) => BlocBuilder<VerifyEmailBloc, IVerifyEmailState>(
                  builder: (context, verifyState) {
                    final loading = registerState is RegisterWithEmailLoading || verifyState is VerifyEmailLoading;
                    return CustomSubmitButton(title: _challengeId == null ? 'إنشاء الحساب' : 'تأكيد الرمز', marginTop: AppHeight.h24, borderRadius: AppRadius.r24, buttonColor: AppColors.loginPrimary, isLoading: loading, verification: !loading, onPressed: _submit);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  String? _required(String? value) => (value ?? '').trim().isEmpty ? 'هذا الحقل مطلوب' : null;

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_challengeId == null) {
      context.read<RegisterWithEmailBloc>().add(SubmitRegisterWithEmailEvent(RegisterWithEmailEntity(displayName: _name.text.trim(), email: _email.text.trim(), password: _password.text, locale: Localizations.localeOf(context).languageCode)));
    } else {
      context.read<VerifyEmailBloc>().add(SubmitVerifyEmailEvent(VerifyEmailEntity(otpCode: _code.text.trim(), challengeId: _challengeId!)));
    }
  }

  void _onRegisterState(BuildContext context, IRegisterWithEmailState state) {
    if (state is RegisterWithEmailFailed) return _failure(state.message);
    if (state is! RegisterWithEmailLoaded) return;
    final challenge = state.authModel?.data?.emailVerification?.challengeId;
    if ((challenge ?? '').isEmpty) return _failure('لم يتم استلام معرّف التحقق من الخادم');
    setState(() => _challengeId = challenge);
  }

  void _onVerifyState(BuildContext context, IVerifyEmailState state) {
    if (state is VerifyEmailFailed) return _failure(state.message);
    if (state is VerifyEmailLoaded) {
      if (state.verification?.data?.verified != true ||
          (state.verification?.data?.accountId ?? '').isEmpty) {
        return _failure('تعذر تأكيد البريد الإلكتروني');
      }
      HomeRoute().go(context);
    }
  }

  void _failure(String message) => showCustomSnackBar(context: context, title: context.loc.error_title, message: message, contentType: ContentType.failure);
}

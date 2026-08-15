import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/bloc/profile/add_email_identifier/add_email_identifier_bloc.dart';
import 'package:wlcd/presentation/bloc/profile/change_email/change_email_bloc.dart';
import 'package:wlcd/presentation/cubit/profile/add_email_identifier/add_email_identifier_cubit.dart';
import 'package:wlcd/presentation/cubit/profile/change_email/change_email_cubit.dart';
import 'package:wlcd/presentation/widgets/custom_snack_bar.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';
import 'package:wlcd/presentation/widgets/custom_text_from_field.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

Future<void> showEmailIdentifierBottomSheet(
  BuildContext context, {
  String? currentEmail,
  VoidCallback? onSuccess,
}) {
  final addEmailIdentifierBloc = context.read<AddEmailIdentifierBloc>();
  final changeEmailBloc = context.read<ChangeEmailBloc>();

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.none,
    barrierColor: const Color(0x940F172A),
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: addEmailIdentifierBloc),
        BlocProvider.value(value: changeEmailBloc),
        BlocProvider(create: (_) => AddEmailIdentifierCubit()),
        BlocProvider(
          create: (_) => ChangeEmailCubit(email: currentEmail ?? ''),
        ),
      ],
      child: EmailIdentifierBottomSheet(
        currentEmail: currentEmail,
        onSuccess: onSuccess,
      ),
    ),
  );
}

class EmailIdentifierBottomSheet extends StatefulWidget {
  const EmailIdentifierBottomSheet({
    super.key,
    this.currentEmail,
    this.onSuccess,
  });

  final String? currentEmail;
  final VoidCallback? onSuccess;

  @override
  State<EmailIdentifierBottomSheet> createState() =>
      _EmailIdentifierBottomSheetState();
}

class _EmailIdentifierBottomSheetState
    extends State<EmailIdentifierBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  bool get _isChangingEmail => widget.currentEmail?.isNotEmpty ?? false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AddEmailIdentifierBloc, IAddEmailIdentifierState>(
          listener: _onAddEmailState,
        ),
        BlocListener<ChangeEmailBloc, IChangeEmailState>(
          listener: _onChangeEmailState,
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
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.r24),
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: IconButton(
                      onPressed: context.pop,
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  SectionTitle(
                    text: _isChangingEmail
                        ? 'تغيير البريد الإلكتروني'
                        : 'إضافة بريد إلكتروني',
                    fontSize: AppFontSize.s20,
                    fontWeight: AppFontWeight.bold,
                  ),
                  SizedBox(height: AppHeight.h8),
                  BodyTitle(
                    text: _isChangingEmail
                        ? 'أدخل عنوان البريد الإلكتروني الجديد لحسابك.'
                        : 'أدخل عنوان بريد إلكتروني لإضافته إلى حسابك.',
                    color: AppColors.grey,
                  ),
                  SizedBox(height: AppHeight.h22),
                  CustomTextFromField(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    hintText: 'البريد الإلكتروني',
                    prefixIcon: const Icon(Icons.email_outlined),
                    contentPaddingStart: AppPaddingWidth.p12,
                    contentPaddingEnd: AppPaddingWidth.p12,
                    contentPaddingTop: AppPaddingHeight.p16,
                    borderRadius: AppRadius.r13,
                    validator: _validateEmail,
                    onChanged: _onEmailChanged,
                  ),
                  SizedBox(height: AppHeight.h20),
                  _SubmitEmailButton(
                    isChangingEmail: _isChangingEmail,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onEmailChanged(String email) {
    if (_isChangingEmail) {
      context.read<ChangeEmailCubit>().setEmail(email);
    } else {
      context.read<AddEmailIdentifierCubit>().setEmail(email);
    }
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_isChangingEmail) {
      final cubit = context.read<ChangeEmailCubit>()..prepareForSubmission();
      context.read<ChangeEmailBloc>().add(SubmitChangeEmailEvent(cubit.state));
    } else {
      final cubit = context.read<AddEmailIdentifierCubit>()
        ..prepareForSubmission();
      context.read<AddEmailIdentifierBloc>().add(
        SubmitAddEmailIdentifierEvent(cubit.state),
      );
    }
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
    if (!email.isValidEmail) return 'يرجى إدخال بريد إلكتروني صحيح';
    if (_isChangingEmail && email == widget.currentEmail) {
      return 'يرجى إدخال بريد إلكتروني مختلف';
    }
    return null;
  }

  void _onAddEmailState(
    BuildContext context,
    IAddEmailIdentifierState state,
  ) {
    if (state is AddEmailIdentifierLoaded) {
      _completeSuccessfully('تمت إضافة البريد الإلكتروني بنجاح');
    } else if (state is AddEmailIdentifierFailed) {
      _showFailure(state.message);
    }
  }

  void _onChangeEmailState(BuildContext context, IChangeEmailState state) {
    if (state is ChangeEmailLoaded) {
      _completeSuccessfully('تم تغيير البريد الإلكتروني بنجاح');
    } else if (state is ChangeEmailFailed) {
      _showFailure(state.message);
    }
  }

  void _completeSuccessfully(String message) {
    showCustomSnackBar(
      context: context,
      title: 'تم بنجاح',
      message: message,
      contentType: ContentType.success,
    );
    widget.onSuccess?.call();
    context.pop();
  }

  void _showFailure(String message) {
    showCustomSnackBar(
      context: context,
      title: 'خطأ',
      message: message,
      contentType: ContentType.failure,
    );
  }
}

class _SubmitEmailButton extends StatelessWidget {
  const _SubmitEmailButton({
    required this.isChangingEmail,
    required this.onPressed,
  });

  final bool isChangingEmail;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (isChangingEmail) {
      return BlocBuilder<ChangeEmailBloc, IChangeEmailState>(
        builder: (context, state) => CustomSubmitButton(
          title: 'تغيير البريد الإلكتروني',
          isLoading: state is ChangeEmailLoading,
          verification: state is! ChangeEmailLoading,
          onPressed: onPressed,
        ),
      );
    }

    return BlocBuilder<AddEmailIdentifierBloc, IAddEmailIdentifierState>(
      builder: (context, state) => CustomSubmitButton(
        title: 'إضافة البريد الإلكتروني',
        isLoading: state is AddEmailIdentifierLoading,
        verification: state is! AddEmailIdentifierLoading,
        onPressed: onPressed,
      ),
    );
  }
}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/bloc/profile/add_phone_identifier/add_phone_identifier_bloc.dart';
import 'package:wlcd/presentation/bloc/profile/change_phone/change_phone_bloc.dart';
import 'package:wlcd/presentation/cubit/profile/add_phone_identifier/add_phone_identifier_cubit.dart';
import 'package:wlcd/presentation/cubit/profile/change_phone/change_phone_cubit.dart';
import 'package:wlcd/presentation/widgets/custom_snack_bar.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';
import 'package:wlcd/presentation/widgets/custom_text_from_field.dart';

Future<void> showPhoneIdentifierBottomSheet(
  BuildContext context, {
  String? currentPhone,
  VoidCallback? onSuccess,
}) {
  final addPhoneIdentifierBloc = context.read<AddPhoneIdentifierBloc>();
  final changePhoneBloc = context.read<ChangePhoneBloc>();

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.none,
    barrierColor: const Color(0x940F172A),
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: addPhoneIdentifierBloc),
        BlocProvider.value(value: changePhoneBloc),
        BlocProvider(create: (_) => AddPhoneIdentifierCubit()),
        BlocProvider(
          create: (_) => ChangePhoneCubit(phone: currentPhone ?? ''),
        ),
      ],
      child: PhoneIdentifierBottomSheet(
        currentPhone: currentPhone,
        onSuccess: onSuccess,
      ),
    ),
  );
}

class PhoneIdentifierBottomSheet extends StatefulWidget {
  const PhoneIdentifierBottomSheet({
    super.key,
    this.currentPhone,
    this.onSuccess,
  });

  final String? currentPhone;
  final VoidCallback? onSuccess;

  @override
  State<PhoneIdentifierBottomSheet> createState() =>
      _PhoneIdentifierBottomSheetState();
}

class _PhoneIdentifierBottomSheetState
    extends State<PhoneIdentifierBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;

  bool get _isChangingPhone => widget.currentPhone?.isNotEmpty ?? false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.currentPhone);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AddPhoneIdentifierBloc, IAddPhoneIdentifierState>(
          listener: _onAddPhoneState,
        ),
        BlocListener<ChangePhoneBloc, IChangePhoneState>(
          listener: _onChangePhoneState,
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
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Text(
                    _isChangingPhone
                        ? 'تغيير رقم الهاتف'
                        : 'إضافة رقم هاتف',
                    style: TextStyle(
                      fontSize: AppFontSize.s20,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppHeight.h8),
                  Text(
                    _isChangingPhone
                        ? 'أدخل رقم الهاتف الجديد لحسابك.'
                        : 'أدخل رقم هاتف لإضافته إلى حسابك.',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: AppFontSize.s14,
                    ),
                  ),
                  SizedBox(height: AppHeight.h22),
                  CustomTextFromField(
                    controller: _phoneController,
                    textInputType: TextInputType.phone,
                    hintText: 'رقم الهاتف',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    contentPaddingStart: AppPaddingWidth.p12,
                    contentPaddingEnd: AppPaddingWidth.p12,
                    contentPaddingTop: AppPaddingHeight.p16,
                    borderRadius: AppRadius.r13,
                    validator: _validatePhone,
                    onChanged: _onPhoneChanged,
                  ),
                  SizedBox(height: AppHeight.h20),
                  _SubmitPhoneButton(
                    isChangingPhone: _isChangingPhone,
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

  void _onPhoneChanged(String phone) {
    if (_isChangingPhone) {
      context.read<ChangePhoneCubit>().setPhone(phone);
    } else {
      context.read<AddPhoneIdentifierCubit>().setPhone(phone);
    }
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_isChangingPhone) {
      final cubit = context.read<ChangePhoneCubit>()..prepareForSubmission();
      context.read<ChangePhoneBloc>().add(SubmitChangePhoneEvent(cubit.state));
    } else {
      final cubit = context.read<AddPhoneIdentifierCubit>()
        ..prepareForSubmission();
      context.read<AddPhoneIdentifierBloc>().add(
        SubmitAddPhoneIdentifierEvent(cubit.state),
      );
    }
  }

  String? _validatePhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) return 'يرجى إدخال رقم الهاتف';
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phone)) {
      return 'يرجى إدخال رقم هاتف صحيح';
    }
    if (_isChangingPhone && phone == widget.currentPhone) {
      return 'يرجى إدخال رقم هاتف مختلف';
    }
    return null;
  }

  void _onAddPhoneState(
    BuildContext context,
    IAddPhoneIdentifierState state,
  ) {
    if (state is AddPhoneIdentifierLoaded) {
      _completeSuccessfully('تمت إضافة رقم الهاتف بنجاح');
    } else if (state is AddPhoneIdentifierFailed) {
      _showFailure(state.message);
    }
  }

  void _onChangePhoneState(BuildContext context, IChangePhoneState state) {
    if (state is ChangePhoneLoaded) {
      _completeSuccessfully('تم تغيير رقم الهاتف بنجاح');
    } else if (state is ChangePhoneFailed) {
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
    Navigator.of(context).pop();
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

class _SubmitPhoneButton extends StatelessWidget {
  const _SubmitPhoneButton({
    required this.isChangingPhone,
    required this.onPressed,
  });

  final bool isChangingPhone;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (isChangingPhone) {
      return BlocBuilder<ChangePhoneBloc, IChangePhoneState>(
        builder: (context, state) => CustomSubmitButton(
          title: 'تغيير رقم الهاتف',
          isLoading: state is ChangePhoneLoading,
          verification: state is! ChangePhoneLoading,
          onPressed: onPressed,
        ),
      );
    }

    return BlocBuilder<AddPhoneIdentifierBloc, IAddPhoneIdentifierState>(
      builder: (context, state) => CustomSubmitButton(
        title: 'إضافة رقم الهاتف',
        isLoading: state is AddPhoneIdentifierLoading,
        verification: state is! AddPhoneIdentifierLoading,
        onPressed: onPressed,
      ),
    );
  }
}

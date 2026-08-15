import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/domain/entity/auth/request_phone_otp_entity.dart';
import 'package:wlcd/presentation/bloc/auth/request_phone_otp/request_phone_otp_bloc.dart';
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
  final requestPhoneOtpBloc = context.read<RequestPhoneOtpBloc>();
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
        BlocProvider.value(value: requestPhoneOtpBloc),
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
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpStep = false;

  bool get _isChangingPhone => widget.currentPhone?.isNotEmpty ?? false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.currentPhone);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<RequestPhoneOtpBloc, IRequestPhoneOtpState>(
          listener: _onRequestPhoneOtpState,
        ),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
                Text(
                  _isOtpStep
                      ? 'تأكيد رقم الهاتف'
                      : _isChangingPhone
                      ? 'تغيير رقم الهاتف'
                      : 'إضافة رقم هاتف',
                  style: TextStyle(
                    fontSize: AppFontSize.s20,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                SizedBox(height: AppHeight.h8),
                Text(
                  _isOtpStep
                      ? 'أدخل رمز التحقق المرسل إلى ${_phoneController.text.trim()}.'
                      : 'أدخل رقم الهاتف، ثم سنرسل إليه رمز تحقق.',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: AppFontSize.s14,
                  ),
                ),
                SizedBox(height: AppHeight.h22),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: _isOtpStep ? _buildOtpStep() : _buildPhoneStep(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneStep() {
    return Form(
      key: _phoneFormKey,
      child: Column(
        key: const ValueKey<String>('phoneStep'),
        mainAxisSize: MainAxisSize.min,
        children: [
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
          BlocBuilder<RequestPhoneOtpBloc, IRequestPhoneOtpState>(
            builder: (context, state) => CustomSubmitButton(
              title: 'إرسال رمز التحقق',
              isLoading: state is RequestPhoneOtpLoading,
              verification: state is! RequestPhoneOtpLoading,
              onPressed: _requestPhoneOtp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpStep() {
    return Form(
      key: _otpFormKey,
      child: Column(
        key: const ValueKey<String>('otpStep'),
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFromField(
            controller: _otpController,
            textInputType: TextInputType.number,
            hintText: 'رمز التحقق',
            prefixIcon: const Icon(Icons.password_outlined),
            contentPaddingStart: AppPaddingWidth.p12,
            contentPaddingEnd: AppPaddingWidth.p12,
            contentPaddingTop: AppPaddingHeight.p16,
            borderRadius: AppRadius.r13,
            validator: _validateOtp,
            onChanged: _onOtpChanged,
          ),
          SizedBox(height: AppHeight.h12),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: () => setState(() => _isOtpStep = false),
              child: const Text('تعديل رقم الهاتف'),
            ),
          ),
          SizedBox(height: AppHeight.h8),
          _SubmitPhoneButton(
            isChangingPhone: _isChangingPhone,
            onPressed: _submitPhoneIdentifier,
          ),
        ],
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

  void _onOtpChanged(String otpCode) {
    if (_isChangingPhone) {
      context.read<ChangePhoneCubit>().setOtpCode(otpCode);
    } else {
      context.read<AddPhoneIdentifierCubit>().setOtpCode(otpCode);
    }
  }

  void _requestPhoneOtp() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(_phoneFormKey.currentState?.validate() ?? false)) return;

    final phone = _phoneController.text.trim();
    context.read<RequestPhoneOtpBloc>().add(
      SubmitRequestPhoneOtpEvent(
        RequestPhoneOtpEntity(
          phone: phone,
          purpose: _isChangingPhone ? 'change_phone' : 'add_phone',
        ),
      ),
    );
  }

  void _onRequestPhoneOtpState(
    BuildContext context,
    IRequestPhoneOtpState state,
  ) {
    if (state is RequestPhoneOtpLoaded) {
      final challengeId = state.challenge?.data?.challengeId;
      if (challengeId == null || challengeId.isEmpty) {
        _showFailure('تعذر بدء التحقق من رقم الهاتف');
        return;
      }
      if (_isChangingPhone) {
        context.read<ChangePhoneCubit>().setChallengeId(challengeId);
      } else {
        context.read<AddPhoneIdentifierCubit>().setChallengeId(challengeId);
      }
      setState(() => _isOtpStep = true);
    } else if (state is RequestPhoneOtpFailed) {
      _showFailure(state.message);
    }
  }

  void _submitPhoneIdentifier() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(_otpFormKey.currentState?.validate() ?? false)) return;

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

  String? _validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال رمز التحقق';
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

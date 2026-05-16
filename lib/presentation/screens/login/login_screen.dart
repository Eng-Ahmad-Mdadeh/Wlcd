import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/custom_elevated_button.dart';
import 'package:wlcd/presentation/widgets/custom_rich_text.dart';
import 'package:wlcd/presentation/widgets/custom_text_from_field.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/page_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyLoginScreen();
  }
}

class BodyLoginScreen extends StatefulWidget {
  BodyLoginScreen({super.key});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  State<BodyLoginScreen> createState() => _BodyLoginScreenState();
}

class _BodyLoginScreenState extends State<BodyLoginScreen> {
  bool isEmailTab = true;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginFormKey,
      child: Scaffold(
        backgroundColor: _LoginColors.white,
        appBar: CustomAppBar(
          showBackButton: true,
          backgroundColor: _LoginColors.white,
          showScrolledUnderElevation: false,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: AppPaddingWidth.p25,
              end: AppPaddingWidth.p25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppHeight.h8),
                PageTitle(
                  text: context.loc.login_welcome_title,
                  textAlign: TextAlign.start,
                  color: _LoginColors.grey900,
                  fontSize: AppFontSize.s28,
                  fontWeight: AppFontWeight.bold,
                  height: 1.4,
                ),
                SizedBox(height: AppHeight.h8),
                BodyTitle(
                  text: context.loc.login_welcome_subtitle,
                  color: _LoginColors.secondary400,
                  fontSize: AppFontSize.s16,
                  fontWeight: AppFontWeight.regular,
                  maxLines: 3,
                ),
                SizedBox(height: AppHeight.h28),
                _LoginTabSection(
                  isEmailTab: isEmailTab,
                  onChanged: (value) {
                    setState(() {
                      isEmailTab = value;
                    });
                  },
                ),
                SizedBox(height: AppHeight.h30),
                _LoginField(
                  key: ValueKey(isEmailTab),
                  icon: isEmailTab
                      ? Icons.email_outlined
                      : Icons.phone_outlined,
                  hintText: isEmailTab
                      ? context.loc.your_email
                      : context.loc.your_phone_number,
                  textInputType: isEmailTab
                      ? TextInputType.emailAddress
                      : TextInputType.phone,
                  validator: (value) {
                    final input = value?.trim() ?? '';
                    if (input.isEmpty) {
                      return isEmailTab
                          ? context.loc.enter_email
                          : context.loc.enter_phone_number;
                    }
                    if (isEmailTab && !input.isValidEmail) {
                      return context.loc.enter_valid_email;
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppHeight.h16),
                _LoginField(
                  icon: Icons.lock_outline,
                  hintText: context.loc.your_password,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: _LoginColors.grey400,
                      size: AppSize.s22,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.loc.enter_password;
                    }
                    if (value.length < 6) {
                      return context.loc.enter_valid_password;
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppHeight.h18),
                InkWell(
                  onTap: () {},
                  splashColor: AppColors.none,
                  highlightColor: AppColors.none,
                  child: SectionTitle(
                    text: context.loc.forgot_password,
                    color: _LoginColors.primary600,
                    fontSize: AppFontSize.s16,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                CustomElevatedButton(
                  height: AppHeight.h55,
                  width: double.infinity,
                  marginTop: AppMarginHeight.m35,
                  color: _LoginColors.primary600,
                  elevation: 0,
                  borderRadius: AppRadius.r45,
                  onPressed: () {
                    widget.loginFormKey.currentState?.validate();
                  },
                  child: SectionTitle(
                    text: context.loc.sign_in,
                    color: AppColors.white,
                    fontSize: AppFontSize.s16,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                SizedBox(height: AppHeight.h60),
                const _LoginDivider(),
                SizedBox(height: AppHeight.h24),
                const _SocialLoginSection(),
                SizedBox(height: AppHeight.h20),
                Center(
                  child: CustomRichText(
                    texts: [
                      CustomRichTextModel(
                        text: '${context.loc.dont_have_account} ',
                        color: _LoginColors.grey900,
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.regular,
                      ),
                      CustomRichTextModel(
                        text: context.loc.sign_up,
                        color: _LoginColors.primary600,
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.bold,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppHeight.h24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginTabSection extends StatelessWidget {
  final bool isEmailTab;
  final ValueChanged<bool> onChanged;

  const _LoginTabSection({required this.isEmailTab, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _LoginColors.grey300)),
      ),
      child: Row(
        children: [
          _LoginTabItem(
            title: context.loc.email,
            selected: isEmailTab,
            onTap: () => onChanged(true),
          ),
          _LoginTabItem(
            title: context.loc.phone_number,
            selected: !isEmailTab,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }
}

class _LoginTabItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _LoginTabItem({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.none,
        highlightColor: AppColors.none,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? _LoginColors.primary600 : AppColors.none,
                width: 1.5,
              ),
            ),
          ),
          child: BodyTitle(
            text: title,
            textAlign: TextAlign.center,
            color: selected ? _LoginColors.primary600 : _LoginColors.grey500,
            fontSize: AppFontSize.s14,
            fontWeight: selected ? AppFontWeight.bold : AppFontWeight.medium,
          ),
        ),
      ),
    );
  }
}

class _LoginField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;

  const _LoginField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.textInputType,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.r12),
      borderSide: const BorderSide(color: _LoginColors.grey200),
    );

    return SizedBox(
      height: AppHeight.h55,
      child: CustomTextFromField(
        maxLines: 1,
        hintText: hintText,
        hintColor: _LoginColors.grey400,
        cursorColor: _LoginColors.primary600,
        color: _LoginColors.white,
        filled: true,
        borderRadius: AppRadius.r12,
        textInputType: textInputType,
        obscureText: obscureText,
        validator: validator,
        contentPaddingTop: AppPaddingHeight.p15,
        contentPaddingBottom: AppPaddingHeight.p15,
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(
            start: AppPaddingWidth.p16,
            end: AppPaddingWidth.p12,
          ),
          child: Icon(icon, color: _LoginColors.grey400, size: AppSize.s22),
        ),
        suffixIcon: suffixIcon,
        enableInputBorder: inputBorder,
        focusedInputBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: _LoginColors.primary600),
        ),
        errorInputBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.red),
        ),
      ),
    );
  }
}

class _LoginDivider extends StatelessWidget {
  const _LoginDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: _LoginColors.grey100)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p16),
          child: BodyTitle(
            text: context.loc.or_with_email,
            color: _LoginColors.grey400,
            fontSize: AppFontSize.s14,
            fontWeight: AppFontWeight.medium,
          ),
        ),
        const Expanded(child: Divider(color: _LoginColors.grey100)),
      ],
    );
  }
}

class _SocialLoginSection extends StatelessWidget {
  const _SocialLoginSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SocialLoginButton(
            icon: Icons.apple,
            title: context.loc.apple,
            onTap: () {},
          ),
        ),
        SizedBox(width: AppWidth.w16),
        Expanded(
          child: _SocialLoginButton(
            customIcon: SectionTitle(
              text: 'G',
              color: const Color(0xFF4285F4),
              fontSize: AppFontSize.s22,
              fontWeight: AppFontWeight.bold,
            ),
            title: context.loc.google,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final String title;
  final VoidCallback onTap;

  const _SocialLoginButton({
    this.icon,
    this.customIcon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      height: AppHeight.h55,
      color: _LoginColors.white,
      elevation: 0,
      borderRadius: AppRadius.r12,
      borderSide: const BorderSide(color: _LoginColors.grey200),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customIcon ?? Icon(icon, color: AppColors.black, size: AppSize.s25),
          SizedBox(width: AppWidth.w20),
          Flexible(
            child: SectionTitle(
              text: title,
              color: _LoginColors.grey900,
              fontSize: AppFontSize.s16,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginColors {
  const _LoginColors._();

  static const Color primary600 = Color(0xFF1E2857);
  static const Color secondary400 = Color(0xFF97A9BD);
  static const Color grey900 = Color(0xFF111827);
  static const Color grey500 = Color(0xFF717585);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey200 = Color(0xFFEEEFF2);
  static const Color grey100 = Color(0xFFE8EAED);
  static const Color white = Color(0xFFFFFFFF);
}

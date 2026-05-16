import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/cubit/remember_me/remember_me_cubit.dart';
import 'package:wlcd/presentation/widgets/custom_elevated_button.dart';
import 'package:wlcd/presentation/widgets/custom_rich_text.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';
import 'package:wlcd/presentation/widgets/custom_text_from_field.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RememberMeCubit>(create: (context) => RememberMeCubit()),
      ],
      child: BodyLoginScreen(),
    );
  }
}

class BodyLoginScreen extends StatelessWidget {
  BodyLoginScreen({super.key});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F8),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 375,
                height: 812,
                color: AppColors.white,
                padding: const EdgeInsets.fromLTRB(39, 18, 39, 8),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _StatusBar(),
                      const SizedBox(height: 24),
                      const Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: Color(0xFF1F2937),
                      ),
                      const SizedBox(height: 35),
                      const SectionTitle(
                        text: 'Hi! Welcome Back',
                        color: Color(0xFF1F2430),
                        fontSize: 25,
                        fontWeight: AppFontWeight.extraBold,
                        height: 1,
                      ),
                      const SizedBox(height: 8),
                      const SectionTitle(
                        text:
                            'We happy to see you again! to use your\naccount, you should sign in first.',
                        color: Color(0xFF98A4B6),
                        fontSize: 15,
                        fontWeight: AppFontWeight.regular,
                        height: 1.5,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 31),
                      const _LoginTabs(),
                      const SizedBox(height: 27),
                      _LoginTextField(
                        icon: Icons.email_outlined,
                        hintText: 'Your email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.isValidEmail) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _LoginTextField(
                        icon: Icons.lock,
                        hintText: 'Your password',
                        obscureText: true,
                        suffixIcon: Icons.visibility_off_outlined,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 1),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: const Color(0xFF222A61),
                        ),
                        child: const SectionTitle(
                          text: 'Forgot Password?',
                          color: Color(0xFF222A61),
                          fontSize: 14,
                          fontWeight: AppFontWeight.bold,
                        ),
                      ),
                      CustomSubmitButton(
                        title: 'Sign In',
                        marginTop: 29,
                        height: 49,
                        borderRadius: 24,
                        elevation: 0,
                        buttonColor: const Color(0xFF252C67),
                        onPressed: () => loginFormKey.currentState?.validate(),
                      ),
                      const SizedBox(height: 54),
                      const _OrDivider(),
                      const SizedBox(height: 23),
                      const Row(
                        children: [
                          Expanded(
                            child: _SocialButton(
                              icon: Icons.apple,
                              label: 'Apple',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _SocialButton(label: 'Google', google: true),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: CustomRichText(
                          texts: [
                            CustomRichTextModel(
                              text: 'Don’t have an account? ',
                              color: const Color(0xFF202532),
                              fontSize: 15,
                              fontWeight: AppFontWeight.regular,
                            ),
                            CustomRichTextModel(
                              text: 'Sign Up',
                              color: const Color(0xFF222A61),
                              fontSize: 15,
                              fontWeight: AppFontWeight.extraBold,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Container(
                          width: 128,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF111827),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
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

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SectionTitle(
            text: '9:41',
            color: Color(0xFF111827),
            fontSize: 14,
            fontWeight: AppFontWeight.semiBold,
          ),
          Row(
            children: [
              Icon(
                Icons.signal_cellular_alt,
                size: 13,
                color: Color(0xFF111827),
              ),
              SizedBox(width: 5),
              Icon(Icons.wifi, size: 13, color: Color(0xFF111827)),
              SizedBox(width: 5),
              Icon(Icons.battery_full, size: 13, color: Color(0xFF111827)),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoginTabs extends StatelessWidget {
  const _LoginTabs();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE7E9EF))),
      ),
      child: const Row(
        children: [
          Expanded(child: _LoginTab(label: 'Email', active: true)),
          Expanded(child: _LoginTab(label: 'Phone Number')),
        ],
      ),
    );
  }
}

class _LoginTab extends StatelessWidget {
  const _LoginTab({required this.label, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SectionTitle(
          text: label,
          color: active ? const Color(0xFF1F285F) : const Color(0xFF6B7280),
          fontSize: 14,
          fontWeight: active ? AppFontWeight.bold : AppFontWeight.regular,
        ),
        if (active)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(height: 2, color: const Color(0xFF232A62)),
          ),
      ],
    );
  }
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    required this.icon,
    required this.hintText,
    required this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  final IconData icon;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return CustomTextFromField(
      maxLines: 1,
      textInputType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      hintText: hintText,
      fontSize: 15,
      hintColor: const Color(0xFF9CA6B6),
      cursorColor: const Color(0xFF232A62),
      filled: false,
      contentPaddingTop: 15,
      contentPaddingBottom: 15,
      contentPaddingStart: 0,
      prefixIcon: Icon(icon, size: 15, color: const Color(0xFFA8B0BD)),
      suffixIcon: suffixIcon == null
          ? null
          : Icon(suffixIcon, size: 15, color: const Color(0xFFA8B0BD)),
      enableInputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFEDF0F4)),
      ),
      focusedInputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF232A62)),
      ),
      errorInputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFF0F1F4), thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SectionTitle(
            text: 'Or with email',
            color: Color(0xFF99A1AE),
            fontSize: 13,
            fontWeight: AppFontWeight.regular,
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFF0F1F4), thickness: 1)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.label, this.icon, this.google = false});

  final String label;
  final IconData? icon;
  final bool google;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      height: 49,
      elevation: 0,
      borderRadius: 8,
      color: AppColors.white,
      borderSide: const BorderSide(color: Color(0xFFEDF0F4)),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (google)
            const SectionTitle(
              text: 'G',
              color: Color(0xFF4285F4),
              fontSize: 16,
              fontWeight: AppFontWeight.bold,
            )
          else
            Icon(icon, size: 19, color: const Color(0xFF111827)),
          const SizedBox(width: 17),
          SectionTitle(
            text: label,
            color: const Color(0xFF202532),
            fontSize: 15,
            fontWeight: AppFontWeight.bold,
          ),
        ],
      ),
    );
  }
}

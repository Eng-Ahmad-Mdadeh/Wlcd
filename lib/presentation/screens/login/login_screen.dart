import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/presentation/cubit/remember_me/remember_me_cubit.dart';

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
                color: Colors.white,
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
                      const Text(
                        'Hi! Welcome Back',
                        style: TextStyle(
                          color: Color(0xFF1F2430),
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'We happy to see you again! to use your\naccount, you should sign in first.',
                        style: TextStyle(
                          color: Color(0xFF98A4B6),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 31),
                      const _LoginTabs(),
                      const SizedBox(height: 27),
                      _LoginField(
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
                      _LoginField(
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
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 29),
                      SizedBox(
                        width: double.infinity,
                        height: 49,
                        child: ElevatedButton(
                          onPressed: () => loginFormKey.currentState?.validate(),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFF252C67),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
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
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Color(0xFF202532),
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(text: 'Don’t have an account? '),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF222A61),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
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
          Text(
            '9:41',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
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
        Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFF1F285F) : const Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: active ? FontWeight.w700 : FontWeight.w400,
          ),
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

class _LoginField extends StatelessWidget {
  const _LoginField({
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
    return SizedBox(
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: const TextStyle(color: Color(0xFF1F2937), fontSize: 15),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF9CA6B6),
            fontSize: 15,
            letterSpacing: 0.5,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Icon(icon, size: 15),
          prefixIconConstraints: const BoxConstraints(minWidth: 47),
          prefixIconColor: const Color(0xFFA8B0BD),
          suffixIcon: suffixIcon == null ? null : Icon(suffixIcon, size: 15),
          suffixIconColor: const Color(0xFFA8B0BD),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFEDF0F4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF232A62)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFC73030)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFC73030)),
          ),
        ),
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
          child: Text(
            'Or with email',
            style: TextStyle(
              color: Color(0xFF99A1AE),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
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
    return SizedBox(
      height: 49,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFEDF0F4)),
          foregroundColor: const Color(0xFF202532),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (google)
              const Text(
                'G',
                style: TextStyle(
                  color: Color(0xFF4285F4),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )
            else
              Icon(icon, size: 19, color: const Color(0xFF111827)),
            const SizedBox(width: 17),
            Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

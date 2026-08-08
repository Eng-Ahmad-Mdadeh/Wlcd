import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_form_section.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_learning_banner.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_tabs.dart';
import 'package:wlcd/presentation/bloc/auth/login_with_password/login_with_password_bloc.dart';
import 'package:wlcd/presentation/bloc/auth/request_login_otp/request_login_otp_bloc.dart';
import 'package:wlcd/presentation/bloc/auth/request_password_reset/request_password_reset_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginWithPasswordBloc()),
        BlocProvider(create: (_) => RequestLoginOtpBloc()),
        BlocProvider(create: (_) => RequestPasswordResetBloc()),
      ],
      child: const BodyLoginScreen(),
    );
  }
}

class BodyLoginScreen extends StatefulWidget {
  const BodyLoginScreen({super.key});

  @override
  State<BodyLoginScreen> createState() => _BodyLoginScreenState();
}

class _BodyLoginScreenState extends State<BodyLoginScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late final TabController _tabController;
  bool _isPhoneLogin = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    final isPhoneLogin = _tabController.index == 1;
    if (_isPhoneLogin != isPhoneLogin) {
      setState(() => _isPhoneLogin = isPhoneLogin);
    }
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_handleTabChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginLearningBanner(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(AppWidth.w20, 0, AppWidth.w20, AppHeight.h8),
                    child: Column(
                      children: [
                        LoginTabs(controller: _tabController),
                        SizedBox(height: AppHeight.h25),
                        LoginFormSection(formKey: loginFormKey, isPhoneLogin: _isPhoneLogin),
                        SizedBox(height: AppHeight.h24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

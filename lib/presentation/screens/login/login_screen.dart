import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/remember_me/remember_me_cubit.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_form_section.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_header_section.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_home_indicator.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_status_bar.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_tabs.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<RememberMeCubit>(create: (context) => RememberMeCubit())],
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
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(AppWidth.w39, AppHeight.h18, AppWidth.w39, AppHeight.h8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginHeaderSection(),
            SizedBox(height: AppHeight.h31),
            LoginTabs(controller: _tabController),
            SizedBox(height: AppHeight.h26),
            LoginFormSection(formKey: loginFormKey, isPhoneLogin: _isPhoneLogin),
            SizedBox(height: AppHeight.h70),
            // const LoginSocialSection(),
            const Spacer(),
            const LoginHomeIndicator(),
          ],
        ),
      ),
    );
  }
}

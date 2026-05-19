import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import '../../../core/resources/app_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BodySplashScreen();
  }
}

class BodySplashScreen extends StatefulWidget {
  const BodySplashScreen({super.key});

  @override
  State<BodySplashScreen> createState() => _BodySplashScreenState();
}

class _BodySplashScreenState extends State<BodySplashScreen> {
  late bool rememberMe;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () => HomeRoute().go(context));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ImageView(imagePath: AppAssets.logo)),
    );
  }
}

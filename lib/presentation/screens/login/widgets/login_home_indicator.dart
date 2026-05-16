import 'package:flutter/material.dart';

class LoginHomeIndicator extends StatelessWidget {
  const LoginHomeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 128,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

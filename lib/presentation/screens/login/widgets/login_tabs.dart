import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginTabs extends StatelessWidget {
  const LoginTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE7E9EF))),
      ),
      child: const Row(
        children: [
          Expanded(child: LoginTab(label: 'Email', active: true)),
          Expanded(child: LoginTab(label: 'Phone Number')),
        ],
      ),
    );
  }
}

class LoginTab extends StatelessWidget {
  const LoginTab({super.key, required this.label, this.active = false});

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

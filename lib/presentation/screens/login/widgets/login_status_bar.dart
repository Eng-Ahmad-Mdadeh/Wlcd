import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginStatusBar extends StatelessWidget {
  const LoginStatusBar({super.key});

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

import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

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

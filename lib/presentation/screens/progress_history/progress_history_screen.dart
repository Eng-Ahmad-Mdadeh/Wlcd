import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/progress_history/widgets/active_progress_section.dart';
import 'package:wlcd/presentation/screens/progress_history/widgets/watching_time_section.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class ProgressHistoryScreen extends StatelessWidget {
  const ProgressHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: CustomAppBar(
        title: 'سجل التقدم',
        centerTitle: true,
        showBackButton: true,
        customActions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: AppPaddingWidth.p20),
            child: Icon(Icons.tune_rounded, color: AppColors.text, size: AppSize.s24),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppWidth.w428),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              AppPaddingWidth.p17,
              AppPaddingHeight.p20,
              AppPaddingWidth.p17,
              AppPaddingHeight.p110,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WatchingTimeSection(),
                SizedBox(height: AppHeight.h28),
                const ActiveProgressSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

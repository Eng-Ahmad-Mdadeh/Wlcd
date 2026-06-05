import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/widgets/course/course_card.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const CustomAppBar(title: 'المفضلة', centerTitle: true),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsetsDirectional.only(
              start: AppPaddingWidth.p18,
              end: AppPaddingWidth.p18,
              bottom: AppPaddingHeight.p110,
              top: AppPaddingHeight.p10,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: AppPaddingHeight.p10),
                  child: CourseCard(
                    onTap: () => CourseDetailsRoute().push(context),
                    title: 'User Experience Design\nEssentials: Figma UI UX\nDesign',
                    price: '\$89.00',
                    ratingCount: '(31,882)',
                    thumbnailColor: AppColors.searchThumbBlue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // body: Center(
      //   child: ConstrainedBox(
      //     constraints: BoxConstraints(maxWidth: AppWidth.w428),
      //     child: Padding(
      //       padding: EdgeInsetsDirectional.symmetric(
      //         horizontal: AppPaddingWidth.p20,
      //         vertical: AppPaddingHeight.p35,
      //       ),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Container(
      //             width: AppWidth.w70,
      //             height: AppWidth.w70,
      //             decoration: const BoxDecoration(
      //               color: AppColors.lightPrim,
      //               shape: BoxShape.circle,
      //             ),
      //             child: Icon(
      //               Iconsax.tag_outline,
      //               color: AppColors.primary,
      //               size: AppSize.s30,
      //             ),
      //           ),
      //           SizedBox(height: AppHeight.h20),
      //           SectionTitle(
      //             text: 'لا توجد عناصر مفضلة حالياً',
      //             color: AppColors.text,
      //             fontSize: AppFontSize.s18,
      //             fontWeight: AppFontWeight.bold,
      //             textAlign: TextAlign.center,
      //           ),
      //           SizedBox(height: AppHeight.h10),
      //           BodyTitle(
      //             text: 'ستظهر الدورات التي تضيفها إلى المفضلة هنا لتصل إليها بسرعة.',
      //             color: AppColors.muted,
      //             fontSize: AppFontSize.s14,
      //             textAlign: TextAlign.center,
      //             maxLines: 3,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

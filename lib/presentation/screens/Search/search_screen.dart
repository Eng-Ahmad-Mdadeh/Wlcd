import 'package:flutter/material.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/Search/widgets/course_card.dart';
import 'package:wlcd/presentation/screens/Search/widgets/filter_row.dart';
import 'package:wlcd/presentation/screens/Search/widgets/result_header.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_header.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p18, vertical: AppPaddingHeight.p8),
                children: [
                  SizedBox(height: 8),
                  SearchHeader(),
                  SizedBox(height: 12),
                  FilterRow(),
                  SizedBox(height: 18),
                  ResultHeader(),
                  SizedBox(height: 12),
                  CourseCard(
                    onTap: () => CourseDetailsRoute().go(context),
                    title: 'User Experience Design\nEssentials: Figma UI UX\nDesign',
                    price: '\$89.00',
                    ratingCount: '(31,882)',
                    thumbnailColor: AppColors.searchThumbBlue,
                  ),
                  SizedBox(height: 14),
                  CourseCard(
                    onTap: () => CourseDetailsRoute().go(context),
                    title: 'Master Digital Product\nDesign: UX Research & UI\nDesign',
                    price: '\$69.00',
                    ratingCount: '(7,765)',
                    thumbnailColor: AppColors.searchThumbBeige,
                  ),
                  SizedBox(height: 14),
                  CourseCard(
                    onTap: () => CourseDetailsRoute().go(context),
                    title: 'UX Design for Beginners:\nThe Essential of UX\nUsability',
                    price: '\$111.99',
                    ratingCount: '(4,536)',
                    thumbnailColor: AppColors.searchThumbPaleBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

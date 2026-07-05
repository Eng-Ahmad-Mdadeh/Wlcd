import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/screens/category_selection/widgets/category_card.dart';
import 'package:wlcd/presentation/screens/category_selection/widgets/category_header.dart';
import 'package:wlcd/presentation/screens/category_selection/widgets/category_selection_data.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final Set<String> _selectedCategories = {'الرياضيات'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'اختيار التصنيف', showBackButton: true),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p18,
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p25,
                  ),
                  sliver: SliverList.list(
                    children: [
                      CategoryHeader(selectedCount: _selectedCategories.length),
                      SizedBox(height: AppHeight.h18),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryOptions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppWidth.w12,
                          mainAxisSpacing: AppHeight.h12,
                          childAspectRatio: 0.92,
                        ),
                        itemBuilder: (context, index) {
                          final category = categoryOptions[index];
                          return CategoryCard(
                            category: category,
                            isSelected: _selectedCategories.contains(category.title),
                            onTap: () => _toggleCategory(category.title),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomSubmitButton(
            marginEnd: AppMarginWidth.m10,
            marginStart: AppMarginWidth.m10,
            marginBottom: AppMarginHeight.m20,
            title: "التالي",
            onPressed: () {
              TeachersRoute().push(context);
            },
          ),
        ],
      ),
    );
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _showSelectedMessage() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('تم اختيار ${_selectedCategories.length} تصنيفات بنجاح')));
  }
}

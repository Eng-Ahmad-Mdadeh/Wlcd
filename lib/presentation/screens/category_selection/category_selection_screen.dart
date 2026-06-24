import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/category_selection/widgets/category_action_bar.dart';
import 'package:wlcd/presentation/screens/category_selection/widgets/category_card.dart';
import 'package:wlcd/presentation/screens/category_selection/widgets/category_header.dart';
import 'package:wlcd/presentation/screens/category_selection/widgets/category_selection_data.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_home_indicator.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

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
      backgroundColor: AppColors.searchScreenBackground,
      appBar: const CustomAppBar(title: 'اختيار التصنيف', centerTitle: true, showBackButton: true),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppWidth.w428),
          child: Column(
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
                        AppPaddingHeight.p24,
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
                          SizedBox(height: AppHeight.h18),
                          CategoryActionBar(
                            selectedCount: _selectedCategories.length,
                            onClear: _selectedCategories.isEmpty ? null : () => setState(_selectedCategories.clear),
                            onContinue: _selectedCategories.isEmpty ? null : _showSelectedMessage,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const NotificationsHomeIndicator(),
            ],
          ),
        ),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم اختيار ${_selectedCategories.length} تصنيفات بنجاح')),
    );
  }
}

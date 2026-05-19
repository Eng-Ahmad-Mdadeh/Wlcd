import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_filter_chip.dart';
import 'package:wlcd/presentation/widgets/custom_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController(text: 'UX Design');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p16, vertical: AppPaddingHeight.p8),
                children: [
                  _TopSearchBar(controller: _controller),
                  SizedBox(height: AppHeight.h12),
                  const _FiltersRow(),
                  SizedBox(height: AppHeight.h16),
                  const _ResultHeader(),
                  SizedBox(height: AppHeight.h12),
                  const _CourseCard(title: 'User Experience Design\nEssentials: Figma UI UX\nDesign', price: '\$89.00', ratingCount: '(31,882)'),
                  SizedBox(height: AppHeight.h14),
                  const _CourseCard(title: 'Master Digital Product\nDesign: UX Research & UI\nDesign', price: '\$69.00', ratingCount: '(7,765)'),
                  SizedBox(height: AppHeight.h14),
                  const _CourseCard(title: 'UX Design for Beginners:\nThe Essential of UX\nUsability', price: '\$111.99', ratingCount: '(4,536)'),
                ],
              ),
            ),
            const _BottomPreviewBar(),
          ],
        ),
      ),
    );
  }
}

class _TopSearchBar extends StatelessWidget {
  const _TopSearchBar({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomSearch(
            controller: controller,
            readOnly: true,
            color: AppColors.white,
            borderRadius: 12,
            prefixIconColor: const Color(0xFF9AA0AB),
            hintColor: const Color(0xFF343A46),
          ),
        ),
        SizedBox(width: AppWidth.w12),
        const Icon(Icons.close, size: 24, color: Color(0xFF2A2F3A)),
      ],
    );
  }
}

class _FiltersRow extends StatelessWidget {
  const _FiltersRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _FilterBox(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.tune, size: 15, color: Color(0xFF8A91A1)), SizedBox(width: 4), Text('Filter', style: TextStyle(fontSize: 13, color: Color(0xFF8A90A0)))]),
          ),
        ),
        SizedBox(width: AppWidth.w8),
        Expanded(child: CustomFilterChip(text: 'Sort by', selected: false, onSelected: (_) {}, showCheckmark: false, padding: EdgeInsets.zero)),
        SizedBox(width: AppWidth.w8),
        Expanded(child: CustomFilterChip(text: 'All levels', selected: false, onSelected: (_) {}, showCheckmark: false, padding: EdgeInsets.zero)),
      ],
    );
  }
}

class _FilterBox extends StatelessWidget {
  const _FilterBox({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h38,
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE5E6EA))),
      child: child,
    );
  }
}

class _ResultHeader extends StatelessWidget {
  const _ResultHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('10,000 results', style: TextStyle(fontSize: AppFontSize.s23, fontWeight: AppFontWeight.semiBold, color: const Color(0xFF4A5261))),
        const Spacer(),
        const Icon(Icons.grid_view_rounded, size: 20, color: Color(0xFFB8BDC8)),
        SizedBox(width: AppWidth.w10),
        const Icon(Icons.view_list_rounded, size: 20, color: AppColors.primary),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.title, required this.price, required this.ratingCount});
  final String title;
  final String price;
  final String ratingCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddingWidth.p10),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE9EAEE))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(width: AppWidth.w92, height: AppHeight.h92, color: const Color(0xFFE8EFFF), child: const Icon(Icons.image_outlined, color: Color(0xFF9BA2B4), size: 30)),
          ),
          SizedBox(width: AppWidth.w10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p7, vertical: AppPaddingHeight.p2),
                decoration: BoxDecoration(color: const Color(0xFFE8F8ED), borderRadius: BorderRadius.circular(6)),
                child: Text('UX Design', style: TextStyle(fontSize: AppFontSize.s10, color: const Color(0xFF3CB55F), fontWeight: AppFontWeight.medium)),
              ),
              SizedBox(height: AppHeight.h7),
              Text(title, style: TextStyle(fontSize: AppFontSize.s14, fontWeight: AppFontWeight.semiBold, color: const Color(0xFF1B2232), height: 1.4)),
              SizedBox(height: AppHeight.h7),
              Text(price, style: TextStyle(fontSize: AppFontSize.s14, color: const Color(0xFF2D65F8), fontWeight: AppFontWeight.semiBold)),
              SizedBox(height: AppHeight.h4),
              Text.rich(TextSpan(children: [WidgetSpan(child: Icon(Icons.star, size: AppSize.s14, color: const Color(0xFFF9B422))), TextSpan(text: ' 4.8 $ratingCount', style: TextStyle(fontSize: AppFontSize.s12, color: const Color(0xFF737B8C)))])),
            ]),
          ),
        ],
      ),
    );
  }
}

class _BottomPreviewBar extends StatelessWidget {
  const _BottomPreviewBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h92,
      decoration: const BoxDecoration(color: AppColors.white, border: Border(top: BorderSide(color: Color(0xFFE7E8ED)))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavIcon(icon: Iconsax.home_1_outline, text: 'Home'),
          _NavIcon(icon: Iconsax.search_normal_1_outline, text: 'Explore', active: true),
          _CenterNavDot(),
          _NavIcon(icon: Iconsax.heart_outline, text: 'Wishlist'),
          _NavIcon(icon: Iconsax.user_outline, text: 'Profile'),
        ],
      ),
    );
  }
}

class _CenterNavDot extends StatelessWidget {
  const _CenterNavDot();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -18),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Color(0x331F275D), blurRadius: 12, offset: Offset(0, 6))]),
        child: const Icon(Iconsax.book_outline, color: AppColors.white, size: 24),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.icon, required this.text, this.active = false});
  final IconData icon;
  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 20, color: active ? AppColors.primary : const Color(0xFF9FA6B4)),
        SizedBox(height: AppHeight.h4),
        Text(text, style: TextStyle(fontSize: AppFontSize.s12, color: active ? AppColors.primary : const Color(0xFFA8AFBC), fontWeight: active ? AppFontWeight.semiBold : AppFontWeight.regular)),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                children: const [
                  SizedBox(height: 8),
                  _SearchHeader(),
                  SizedBox(height: 12),
                  _FilterRow(),
                  SizedBox(height: 18),
                  _ResultHeader(),
                  SizedBox(height: 12),
                  _CourseCard(
                    title: 'User Experience Design\nEssentials: Figma UI UX\nDesign',
                    price: '\$89.00',
                    ratingCount: '(31,882)',
                    thumbnailColor: Color(0xFFE8EFFF),
                  ),
                  SizedBox(height: 14),
                  _CourseCard(
                    title: 'Master Digital Product\nDesign: UX Research & UI\nDesign',
                    price: '\$69.00',
                    ratingCount: '(7,765)',
                    thumbnailColor: Color(0xFFECE7DF),
                  ),
                  SizedBox(height: 14),
                  _CourseCard(
                    title: 'UX Design for Beginners:\nThe Essential of UX\nUsability',
                    price: '\$111.99',
                    ratingCount: '(4,536)',
                    thumbnailColor: Color(0xFFEAEFFA),
                  ),
                ],
              ),
            ),
            const _BottomBar(),
          ],
        ),
      ),
    );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE8E8E8)),
            ),
            child: const Row(
              children: [
                SizedBox(width: 10),
                Icon(Iconsax.search_normal_1_outline, size: 19, color: Color(0xFF9AA0AB)),
                SizedBox(width: 8),
                Text(
                  'UX Design',
                  style: TextStyle(fontSize: 16, color: Color(0xFF343A46), fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.close, size: 24, color: Color(0xFF2A2F3A)),
      ],
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _FilterChip(label: 'Filter', icon: Icons.tune),
        SizedBox(width: 8),
        _FilterChip(label: 'Sort by', trailing: Icons.keyboard_arrow_down),
        SizedBox(width: 8),
        _FilterChip(label: 'All levels', trailing: Icons.keyboard_arrow_down),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.icon, this.trailing});

  final String label;
  final IconData? icon;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE5E6EA)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 15, color: const Color(0xFF8A91A1)),
              const SizedBox(width: 4),
            ],
            Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF8A90A0))),
            if (trailing != null) ...[
              const SizedBox(width: 4),
              Icon(trailing, size: 16, color: const Color(0xFF8A91A1)),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResultHeader extends StatelessWidget {
  const _ResultHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          '10,000 results',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Color(0xFF4A5261)),
        ),
        Spacer(),
        Icon(Icons.grid_view_rounded, size: 20, color: Color(0xFFB8BDC8)),
        SizedBox(width: 10),
        Icon(Icons.view_list_rounded, size: 20, color: AppColors.primary),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.title,
    required this.price,
    required this.ratingCount,
    required this.thumbnailColor,
  });

  final String title;
  final String price;
  final String ratingCount;
  final Color thumbnailColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE9EAEE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 92,
              height: 92,
              color: thumbnailColor,
              alignment: Alignment.center,
              child: const Icon(Icons.image_outlined, color: Color(0xFF9BA2B4), size: 30),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFFE8F8ED), borderRadius: BorderRadius.circular(6)),
                  child: const Text('UX Design', style: TextStyle(fontSize: 10, color: Color(0xFF3CB55F), fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 7),
                Text(title, style: const TextStyle(fontSize: 28/2, fontWeight: FontWeight.w600, color: Color(0xFF1B2232), height: 1.4)),
                const SizedBox(height: 7),
                Text(price, style: const TextStyle(fontSize: 14, color: Color(0xFF2D65F8), fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Color(0xFFF9B422)),
                    const SizedBox(width: 4),
                    Text('4.8 $ratingCount', style: const TextStyle(fontSize: 12, color: Color(0xFF737B8C))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE7E8ED))),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Iconsax.home_1_outline, label: 'Home'),
                _NavItem(icon: Iconsax.search_normal_1_outline, label: 'Explore', isActive: true),
                SizedBox(width: 54),
                _NavItem(icon: Iconsax.heart_outline, label: 'Wishlist'),
                _NavItem(icon: Iconsax.user_outline, label: 'Profile'),
              ],
            ),
          ),
          Positioned(
            top: -22,
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(27), boxShadow: const [BoxShadow(color: Color(0x331F275D), blurRadius: 12, offset: Offset(0, 6))]),
              child: const Icon(Iconsax.book_outline, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, this.isActive = false});

  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: isActive ? AppColors.primary : const Color(0xFF9FA6B4)),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: isActive ? AppColors.primary : const Color(0xFFA8AFBC), fontWeight: isActive ? FontWeight.w600 : FontWeight.w400),
        ),
      ],
    );
  }
}

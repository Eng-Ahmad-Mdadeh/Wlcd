import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes_imports.dart';
import 'package:wlcd/presentation/cubit/bottom_bar/bottom_bar_cubit.dart';
import 'package:wlcd/presentation/widgets/bottom_nav_bar/custom_nav_item.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavBar({super.key, required this.navigationShell});

  void _handleBranchTap(BuildContext context, int index) async {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = navigationShell.currentIndex;
    return BlocBuilder<BottomBarCubit, bool>(
      builder: (context, state) {
        return AnimatedContainer(
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 250),
          height: state ? AppHeight.h120 : 0,
          curve: Curves.fastOutSlowIn,
          padding: EdgeInsetsDirectional.fromSTEB(AppPaddingWidth.p12, 0, AppPaddingWidth.p12, 0),
          color: AppColors.none,
          child: Container(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppPaddingWidth.p12,
              AppPaddingHeight.p10,
              AppPaddingWidth.p12,
              AppPaddingHeight.p10,
            ),
            decoration: BoxDecoration(
              color: AppColors.backGround,
              border: Border.all(color: AppColors.notificationBorder, width: 1),
              borderRadius: BorderRadius.circular(AppRadius.r20),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.searchBottomShadow,
                  offset: Offset(0, 2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  currentIndex: currentIndex,
                  onPressed: () => _handleBranchTap(context, 0),
                  icon: Iconsax.home_outline,
                  selectedIcon: Iconsax.home_outline,
                  label: "الرئيسية",
                ),
                _buildNavItem(
                  index: 1,
                  currentIndex: currentIndex,
                  onPressed: () => _handleBranchTap(context, 1),
                  icon: Iconsax.tag_outline,
                  selectedIcon: Iconsax.tag_outline,
                  label: "المفضلة",
                ),
                _buildNavItem(
                  index: 2,
                  currentIndex: currentIndex,
                  onPressed: () => _handleBranchTap(context, 2),
                  icon: Iconsax.judge_outline,
                  selectedIcon: Iconsax.judge_outline,
                  label: "الإشعارات",
                ),

                _buildNavItem(
                  index: 3,
                  currentIndex: currentIndex,
                  onPressed: () => _handleBranchTap(context, 3),
                  icon: Iconsax.more_outline,
                  selectedIcon: Iconsax.more_outline,
                  label: "المزيد",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required int index,
    required int currentIndex,
    required VoidCallback onPressed,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final bool selected = index == currentIndex;
    return Expanded(
      child: CustomNavItem(
        onPressed: onPressed,
        icon: selected ? selectedIcon : icon,
        label: label,
        selected: selected,
      ).animate(target: selected ? null : 1).fadeIn(),
    );
  }
}

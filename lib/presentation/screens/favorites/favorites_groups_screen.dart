import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/screens/favorites/favorites_store.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class FavoritesGroupsScreen extends StatelessWidget {
  const FavoritesGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const CustomAppBar(title: 'المفضلة', centerTitle: true),
      body: ValueListenableBuilder<List<FavoriteGroup>>(
        valueListenable: FavoritesStore.groups,
        builder: (context, groups, _) {
          if (groups.isEmpty) return const _EmptyFavoritesView();

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsetsDirectional.only(
                  start: AppPaddingWidth.p18,
                  end: AppPaddingWidth.p18,
                  bottom: AppPaddingHeight.p110,
                  top: AppPaddingHeight.p10,
                ),
                sliver: SliverGrid.builder(
                  itemCount: groups.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppWidth.w14,
                    mainAxisSpacing: AppHeight.h14,
                    childAspectRatio: .9,
                  ),
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    return _FavoriteGroupCard(
                      group: group,
                      onTap: () => FavoriteCoursesRoute(
                        groupName: group.name,
                        favoriteGroupId: group.favoriteGroupId,
                      ).push(context),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FavoriteGroupCard extends StatelessWidget {
  const _FavoriteGroupCard({required this.group, required this.onTap});

  final FavoriteGroup group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r18),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r18),
          border: Border.all(color: AppColors.searchCardBorder),
          boxShadow: const [BoxShadow(color: AppColors.greySec, spreadRadius: -2, blurRadius: 12, offset: Offset(0, 6))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.r18)),
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: List.generate(4, (index) {
                    return Container(
                      margin: EdgeInsets.all(AppWidth.w1),
                      color: index.isEven ? AppColors.searchThumbBlue : AppColors.searchThumbBeige,
                      child: Icon(Iconsax.book_1_outline, color: AppColors.primary.withValues(alpha: .35), size: AppSize.s24),
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppPaddingWidth.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(text: group.name, color: AppColors.text, fontSize: AppFontSize.s14, fontWeight: AppFontWeight.bold, maxLines: 1),
                  SizedBox(height: AppHeight.h4),
                  BodyTitle(text: '${group.courses.length} كورسات', color: AppColors.muted, fontSize: AppFontSize.s12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFavoritesView extends StatelessWidget {
  const _EmptyFavoritesView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: AppWidth.w428),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: AppPaddingWidth.p20, vertical: AppPaddingHeight.p35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppWidth.w70,
                height: AppWidth.w70,
                decoration: const BoxDecoration(color: AppColors.lightPrim, shape: BoxShape.circle),
                child: Icon(Iconsax.tag_outline, color: AppColors.primary, size: AppSize.s30),
              ),
              SizedBox(height: AppHeight.h20),
              SectionTitle(
                text: 'لا توجد مجموعات مفضلة حالياً',
                color: AppColors.text,
                fontSize: AppFontSize.s18,
                fontWeight: AppFontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppHeight.h10),
              BodyTitle(
                text: 'عند إضافة كورس للمفضلة يمكنك وضعه داخل مجموعة حالية أو إنشاء مجموعة جديدة.',
                color: AppColors.muted,
                fontSize: AppFontSize.s14,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

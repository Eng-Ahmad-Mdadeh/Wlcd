import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/bloc/favorites/favorite_groups/favorite_groups_bloc.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class FavoritesGroupsScreen extends StatelessWidget {
  const FavoritesGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteGroupsBloc()..add(const LoadFavoriteGroupsEvent()),
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: const CustomAppBar(title: 'المفضلة', centerTitle: true),
        body: const _FavoriteGroupsBody(),
      ),
    );
  }
}

class _FavoriteGroupsBody extends StatelessWidget {
  const _FavoriteGroupsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteGroupsBloc, IFavoriteGroupsState>(
      builder: (context, state) {
        if (state is FavoriteGroupsFailed) {
          return RetryWidget(
            onReload: () => context.read<FavoriteGroupsBloc>().add(
              const LoadFavoriteGroupsEvent(),
            ),
          );
        }
        if (state is FavoriteGroupsLoaded) {
          final groups = state.groups?.data ?? const <Map<String, dynamic>>[];
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
                    final group = _FavoriteGroupViewData.fromJson(
                      groups[index],
                      index,
                    );
                    return _FavoriteGroupCard(
                      group: group,
                      onTap: group.favoriteGroupId == null
                          ? null
                          : () => FavoriteCoursesRoute(
                              groupName: group.name,
                              favoriteGroupId: group.favoriteGroupId!,
                            ).push(context),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const LoadingWidget(0);
      },
    );
  }
}

/// A defensive presentation adapter. API-OP-151 does not publish the list item
/// schema, so no field is required and unknown payloads remain renderable.
class _FavoriteGroupViewData {
  const _FavoriteGroupViewData({
    required this.name,
    this.favoriteGroupId,
  });

  final String name;
  final String? favoriteGroupId;

  factory _FavoriteGroupViewData.fromJson(
    Map<String, dynamic> json,
    int index,
  ) {
    final name = json['name'];
    final favoriteGroupId = json['favoriteGroupId'];
    return _FavoriteGroupViewData(
      name: name is String && name.isNotEmpty
          ? name
          : 'مجموعة مفضلة ${index + 1}',
      favoriteGroupId: favoriteGroupId is String && favoriteGroupId.isNotEmpty
          ? favoriteGroupId
          : null,
    );
  }
}

class _FavoriteGroupCard extends StatelessWidget {
  const _FavoriteGroupCard({required this.group, required this.onTap});

  final _FavoriteGroupViewData group;
  final VoidCallback? onTap;

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
                  BodyTitle(text: 'مجموعة مفضلة', color: AppColors.muted, fontSize: AppFontSize.s12),
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

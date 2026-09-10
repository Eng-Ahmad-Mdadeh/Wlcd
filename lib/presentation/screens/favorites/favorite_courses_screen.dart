import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';
import 'package:wlcd/presentation/bloc/favorites/favorite_memberships/favorite_memberships_bloc.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/no_result_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class FavoriteCoursesScreen extends StatelessWidget {
  const FavoriteCoursesScreen({
    super.key,
    required this.groupName,
    required this.favoriteGroupId,
  });

  final String groupName;
  final String favoriteGroupId;

  @override
  Widget build(BuildContext context) {
    final entity = FavoritesEntity(favoriteGroupId: favoriteGroupId);
    return BlocProvider(
      create: (_) => FavoriteMembershipsBloc()
        ..add(LoadFavoriteMembershipsEvent(entity)),
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: CustomAppBar(
          title: groupName,
          centerTitle: true,
          showBackButton: true,
        ),
        body: _FavoriteCoursesBody(entity: entity),
      ),
    );
  }
}

class _FavoriteCoursesBody extends StatelessWidget {
  const _FavoriteCoursesBody({required this.entity});

  final FavoritesEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMembershipsBloc, IFavoriteMembershipsState>(
      builder: (context, state) {
        if (state is FavoriteMembershipsFailed) {
          return RetryWidget(
            onReload: () => context.read<FavoriteMembershipsBloc>().add(
              LoadFavoriteMembershipsEvent(entity),
            ),
          );
        }
        if (state is FavoriteMembershipsLoaded) {
          final memberships = state.memberships?.data ?? const [];
          if (memberships.isEmpty) {
            return const NoResultWidget(title: 'لا توجد كورسات في هذه المجموعة');
          }
          return _FavoriteCoursesList(itemCount: memberships.length);
        }
        return const LoadingWidget(0);
      },
    );
  }
}

/// The memberships list item schema is not defined by the handoff yet. The
/// screen therefore renders a neutral row per returned item without guessing
/// course fields; richer cards can be introduced when that contract is known.
class _FavoriteCoursesList extends StatelessWidget {
  const _FavoriteCoursesList({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsetsDirectional.only(
        start: AppPaddingWidth.p18,
        end: AppPaddingWidth.p18,
        top: AppPaddingHeight.p10,
        bottom: AppPaddingHeight.p110,
      ),
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: AppHeight.h10),
      itemBuilder: (_, index) => Card(
        color: AppColors.white,
        child: ListTile(
          leading: const Icon(Iconsax.book_1_outline, color: AppColors.primary),
          title: BodyTitle(
            text: 'كورس مفضل ${index + 1}',
            color: AppColors.text,
          ),
        ),
      ),
    );
  }
}

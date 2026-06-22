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

class FavoriteCourse {
  const FavoriteCourse({required this.title, required this.price, required this.ratingCount, required this.thumbnailColor});

  final String title;
  final String price;
  final String ratingCount;
  final Color thumbnailColor;
}

class FavoriteGroup {
  const FavoriteGroup({required this.name, required this.courses});

  final String name;
  final List<FavoriteCourse> courses;
}

class FavoritesStore {
  FavoritesStore._();

  static const demoCourse = FavoriteCourse(
    title: 'User Experience Design\nEssentials: Figma UI UX\nDesign',
    price: '\$89.00',
    ratingCount: '(31,882)',
    thumbnailColor: AppColors.searchThumbBlue,
  );

  static final ValueNotifier<List<FavoriteGroup>> groups = ValueNotifier<List<FavoriteGroup>>([
    FavoriteGroup(name: 'تصميم واجهات', courses: List.generate(4, (_) => demoCourse)),
    FavoriteGroup(name: 'أريد تعلمها لاحقاً', courses: List.generate(3, (_) => demoCourse)),
    FavoriteGroup(name: 'كورسات العمل', courses: List.generate(2, (_) => demoCourse)),
  ]);

  static void addCourseToGroup({required FavoriteCourse course, required String groupName}) {
    final cleanName = groupName.trim();
    if (cleanName.isEmpty) return;

    final updatedGroups = [...groups.value];
    final groupIndex = updatedGroups.indexWhere((group) => group.name == cleanName);
    if (groupIndex == -1) {
      updatedGroups.insert(0, FavoriteGroup(name: cleanName, courses: [course]));
    } else {
      final group = updatedGroups[groupIndex];
      updatedGroups[groupIndex] = FavoriteGroup(name: group.name, courses: [course, ...group.courses]);
    }
    groups.value = updatedGroups;
  }
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoriteGroup? _selectedGroup;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FavoriteGroup>>(
      valueListenable: FavoritesStore.groups,
      builder: (context, groups, _) {
        final selectedGroup = _selectedGroup == null ? null : _findSelectedGroup(groups, _selectedGroup!.name);

        return Scaffold(
          backgroundColor: AppColors.backGround,
          appBar: CustomAppBar(
            title: selectedGroup?.name ?? 'المفضلة',
            centerTitle: true,
            showBackButton: selectedGroup != null,
            onTapBackButton: selectedGroup == null ? null : () => setState(() => _selectedGroup = null),
          ),
          body: selectedGroup == null ? _FavoriteGroupsView(groups: groups, onGroupTap: _openGroup) : _FavoriteCoursesView(group: selectedGroup),
        );
      },
    );
  }

  FavoriteGroup? _findSelectedGroup(List<FavoriteGroup> groups, String name) {
    for (final group in groups) {
      if (group.name == name) return group;
    }
    return null;
  }

  void _openGroup(FavoriteGroup group) {
    setState(() => _selectedGroup = group);
  }
}

class _FavoriteGroupsView extends StatelessWidget {
  const _FavoriteGroupsView({required this.groups, required this.onGroupTap});

  final List<FavoriteGroup> groups;
  final ValueChanged<FavoriteGroup> onGroupTap;

  @override
  Widget build(BuildContext context) {
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
            itemBuilder: (context, index) => _FavoriteGroupCard(group: groups[index], onTap: () => onGroupTap(groups[index])),
          ),
        ),
      ],
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

class _FavoriteCoursesView extends StatelessWidget {
  const _FavoriteCoursesView({required this.group});

  final FavoriteGroup group;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsetsDirectional.only(
            start: AppPaddingWidth.p18,
            end: AppPaddingWidth.p18,
            bottom: AppPaddingHeight.p110,
            top: AppPaddingHeight.p10,
          ),
          sliver: SliverList.builder(
            itemCount: group.courses.length,
            itemBuilder: (context, index) {
              final course = group.courses[index];
              return Padding(
                padding: EdgeInsets.only(bottom: AppPaddingHeight.p10),
                child: CourseCard(
                  onTap: () => CourseDetailsRoute().push(context),
                  title: course.title,
                  price: course.price,
                  ratingCount: course.ratingCount,
                  thumbnailColor: course.thumbnailColor,
                ),
              );
            },
          ),
        ),
      ],
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

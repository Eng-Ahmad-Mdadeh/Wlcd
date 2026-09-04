import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/domain/entity/catalog/get_featured_courses_entity.dart';
import 'package:wlcd/presentation/bloc/catalog/categories/categories_bloc.dart';
import 'package:wlcd/presentation/bloc/catalog/featured_courses/featured_courses_bloc.dart';
import 'package:wlcd/presentation/bloc/catalog/recommended_courses/recommended_courses_bloc.dart';
import 'package:wlcd/presentation/cubit/catalog/featured_courses_query_cubit.dart';
import 'package:wlcd/presentation/screens/Home/widgets/banners.dart';
import 'package:wlcd/presentation/screens/Home/widgets/catalog_sections.dart';
import 'package:wlcd/presentation/screens/Home/widgets/continue_learning_card.dart';
import 'package:wlcd/presentation/screens/Home/widgets/external_courses_section.dart';
import 'package:wlcd/presentation/screens/Home/widgets/home_header.dart';
import 'package:wlcd/presentation/screens/Home/widgets/home_trainers_section.dart';
import 'package:wlcd/presentation/screens/Home/widgets/section_header.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FeaturedCoursesQueryCubit()),
        BlocProvider(
          create: (_) => CategoriesBloc()..add(const LoadCategoriesEvent()),
        ),
        BlocProvider(
          create: (_) => FeaturedCoursesBloc()
            ..add(
              const LoadFeaturedCoursesEvent(GetFeaturedCoursesEntity()),
            ),
        ),
        BlocProvider(
          create: (_) => RecommendedCoursesBloc()
            ..add(const LoadRecommendedCoursesEvent()),
        ),
      ],
      child: _HomeBody(searchController: _searchController),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        title: 'WLCD Academy',
        colorTitle: AppColors.white,
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            forceElevated: false,
            forceMaterialTransparency: true,
            backgroundColor: AppColors.primary,
            surfaceTintColor: AppColors.primary,
            floating: true,
            snap: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: HomeHeader(
                      searchController: searchController,
                      onSearchChanged: (value) {},
                    ),
                  ),
                  Positioned(top: AppHeight.h150, child: const ContinueLearningCard()),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppPaddingWidth.p23,
              AppPaddingHeight.p20,
              AppPaddingWidth.p23,
              AppPaddingHeight.p100,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                BannersWidget(),
                SizedBox(height: AppHeight.h28),
                const HomeCategoriesSection(),
                SizedBox(height: AppHeight.h28),
                const HomeFeaturedCoursesSection(),
                SizedBox(height: AppHeight.h28),
                SectionHeaderRow(title: context.loc.home_global_courses),
                SizedBox(height: AppHeight.h14),
                const ExternalCoursesSection(),
                SizedBox(height: AppHeight.h28),

                SectionHeaderRow(
                  title: context.loc.home_explore_trainers,
                  actionText: context.loc.home_see_more,
                  onActionPressed: () => TeachersRoute().push(context),
                ),
                SizedBox(height: AppHeight.h14),
                const HomeTrainersSection(trainers: teachers),

                SizedBox(height: AppHeight.h28),
                const HomeRecommendedCoursesSection(),
                SizedBox(height: AppHeight.h24),

              ]),
            ),
          ),
        ],
      ),
    );
  }

}

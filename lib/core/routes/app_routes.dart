import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wlcd/core/extension/page_builder_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/utils/enums/enum_utils.dart';
import 'package:wlcd/presentation/cubit/bottom_bar/bottom_bar_cubit.dart';
import 'package:wlcd/presentation/screens/Home/home_screen.dart';
import 'package:wlcd/presentation/screens/check_code/check_code_screen.dart';
import 'package:wlcd/presentation/screens/category_selection/category_selection_screen.dart';
import 'package:wlcd/presentation/screens/course_details/course_details_screen.dart';
import 'package:wlcd/presentation/screens/login/login_screen.dart';
import 'package:wlcd/presentation/screens/favorites/favorites_screen.dart';
import 'package:wlcd/presentation/screens/faqs/faqs_screen.dart';
import 'package:wlcd/presentation/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:wlcd/presentation/screens/terms_and_conditions/terms_and_conditions_screen.dart';
import 'package:wlcd/presentation/screens/more/more_screen.dart';
import 'package:wlcd/presentation/screens/notifications/notifications_screen.dart';
import 'package:wlcd/presentation/screens/order_history/order_history_screen.dart';
import 'package:wlcd/presentation/screens/personal_information/personal_information_screen.dart';

import 'package:wlcd/presentation/screens/profile/profile_screen.dart';
import 'package:wlcd/presentation/screens/progress_history/progress_history_screen.dart';
import 'package:wlcd/presentation/screens/search/search_screen.dart';
import 'package:wlcd/presentation/screens/splash/splash_screen.dart';
import 'package:wlcd/presentation/widgets/bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

import 'app_routes_imports.dart';

part 'app_routes.g.dart';

//#region Splash
@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData with $SplashRoute {

  SplashRoute();

  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return SplashScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}

//#endregion

//#region Auth
@TypedGoRoute<LoginRoute>(
  path: '/login',
  routes: [TypedGoRoute<CheckCodeRoute>(path: 'check_code')],
)
class LoginRoute extends GoRouteData with $LoginRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const LoginScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}

class CheckCodeRoute extends GoRouteData with $CheckCodeRoute {

  CheckCodeRoute();

  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return CheckCodeScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}
//#endregion

//#region search
@TypedGoRoute<SearchRoute>(path: '/search')
class SearchRoute extends GoRouteData with $SearchRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const SearchScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}

@TypedGoRoute<ProfileRoute>(path: '/profile')
class ProfileRoute extends GoRouteData with $ProfileRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const ProfileScreen().buildPage(pageAnimation: PageAnimation.slide);
  }
}

@TypedGoRoute<CourseDetailsRoute>(path: '/course-details')
class CourseDetailsRoute extends GoRouteData with $CourseDetailsRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const CourseDetailsScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}

@TypedGoRoute<CategorySelectionRoute>(path: '/category-selection')
class CategorySelectionRoute extends GoRouteData with $CategorySelectionRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const CategorySelectionScreen().buildPage(pageAnimation: PageAnimation.slide);
  }
}

@TypedGoRoute<PersonalInformationRoute>(path: '/personal-information')
class PersonalInformationRoute extends GoRouteData with $PersonalInformationRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const PersonalInformationScreen().buildPage(pageAnimation: PageAnimation.slide);
  }
}

@TypedGoRoute<PrivacyPolicyRoute>(path: '/privacy-policy')
class PrivacyPolicyRoute extends GoRouteData with $PrivacyPolicyRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const PrivacyPolicyScreen().buildPage(pageAnimation: PageAnimation.slide);
  }
}

@TypedGoRoute<FaqsRoute>(path: '/faqs')
class FaqsRoute extends GoRouteData with $FaqsRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const FaqsScreen().buildPage(pageAnimation: PageAnimation.slide);
  }
}

@TypedGoRoute<TermsAndConditionsRoute>(path: '/terms-and-conditions')
class TermsAndConditionsRoute extends GoRouteData with $TermsAndConditionsRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const TermsAndConditionsScreen().buildPage(pageAnimation: PageAnimation.slide);
  }
}

@TypedGoRoute<ProgressHistoryRoute>(path: '/progress-history')
class ProgressHistoryRoute extends GoRouteData with $ProgressHistoryRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const ProgressHistoryScreen().buildPage(pageAnimation: PageAnimation.slide);
  }
}

@TypedGoRoute<OrderHistoryRoute>(path: '/order-history')
class OrderHistoryRoute extends GoRouteData with $OrderHistoryRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const OrderHistoryScreen().buildPage(pageAnimation: PageAnimation.slide);
  }
}
//#endregion



//#region Home
class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const HomeScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}
//#endregion

//#region Favorites
class FavoritesRoute extends GoRouteData with $FavoritesRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const FavoritesGroupsScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}

class FavoriteCoursesRoute extends GoRouteData with $FavoriteCoursesRoute {
  const FavoriteCoursesRoute({required this.groupName});

  final String groupName;

  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return FavoriteCoursesScreen(groupName: groupName).buildPage(pageAnimation: PageAnimation.slide);
  }
}
//#endregion

//#region Notifications
class NotificationsRoute extends GoRouteData with $NotificationsRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const NotificationsScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}
//#endregion

//#region More
class MoreRoute extends GoRouteData with $MoreRoute {
  @override
  CustomTransitionPage<void> buildPage(context, state) {
    return const MoreScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}
//#endregion

@TypedStatefulShellRoute<AppShellRoute>(
  branches: [
    TypedStatefulShellBranch<HomeBranch>(
      routes: [TypedGoRoute<HomeRoute>(path: '/home', routes: [])],
    ),
    TypedStatefulShellBranch<FavoritesBranch>(
      routes: [
        TypedGoRoute<FavoritesRoute>(
          path: '/favorites',
          routes: [TypedGoRoute<FavoriteCoursesRoute>(path: 'groups/:groupName')],
        ),
      ],
    ),
    TypedStatefulShellBranch<NotificationsBranch>(
      routes: [TypedGoRoute<NotificationsRoute>(path: '/notifications', routes: [])],
    ),
    TypedStatefulShellBranch<MoreBranch>(
      routes: [TypedGoRoute<MoreRoute>(path: '/more', routes: [])],
    ),
  ],
)
class AppShellRoute extends StatefulShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return AppShell(navigationShell: navigationShell);
  }
}

class HomeBranch extends StatefulShellBranchData {}

class FavoritesBranch extends StatefulShellBranchData {}

class NotificationsBranch extends StatefulShellBranchData {}

class MoreBranch extends StatefulShellBranchData {}

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final currentPath = navigationShell.shellRouteContext.routerState.fullPath;

    final shouldShowBottomBar = [
      HomeRoute().location,
      FavoritesRoute().location,
      NotificationsRoute().location,
      MoreRoute().location,
    ].contains(currentPath);

    context.read<BottomBarCubit>().setBottomBarVisibility(shouldShowBottomBar);
    return Scaffold(
      extendBody: true,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsetsDirectional.only(
            bottom: AppMarginHeight.m15,
            start: AppMarginWidth.m20,
            end: AppMarginWidth.m20,
          ),
          backgroundColor: AppColors.primary,
          content: SectionTitle(text: "tap_back_again_to_leave", color: AppColors.white),
        ),
        child: navigationShell,
      ),
      bottomNavigationBar: CustomBottomNavBar(navigationShell: navigationShell).animate().fadeIn().slideY(begin: .3),
    );
  }
}

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
import 'package:wlcd/presentation/screens/course_details/course_details_screen.dart';
import 'package:wlcd/presentation/screens/login/login_screen.dart';
import 'package:wlcd/presentation/screens/favorites/favorites_screen.dart';
import 'package:wlcd/presentation/screens/more/more_screen.dart';
import 'package:wlcd/presentation/screens/notifications/notifications_screen.dart';
import 'package:wlcd/presentation/screens/profile/profile_screen.dart';
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
    return const FavoritesScreen().buildPage(pageAnimation: PageAnimation.fade);
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
      routes: [TypedGoRoute<FavoritesRoute>(path: '/favorites', routes: [])],
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

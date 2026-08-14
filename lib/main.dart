import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/core/services/app_lifecycle_tracker.dart';



// import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:wlcd/core/l10n/app_localizations.dart' show AppLocalizations;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wlcd/core/routes/app_routes_imports.dart';
import 'package:wlcd/core/utils/connection_network_service.dart';
import 'package:wlcd/presentation/cubit/bottom_bar/bottom_bar_cubit.dart';

import 'core/services/app_services.dart';
import 'core/constants/app_theme.dart';
import 'core/routes/app_routes.dart';

import 'presentation/cubit/code_check/code_check_cubit.dart';
import 'presentation/cubit/language/language_cubit.dart';
import 'presentation/cubit/remember_me/remember_me_cubit.dart';
// import 'package:telr_mobile_payment_sdk/telr_mobile_payment_sdk.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
// final storage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initializeDateFormatting('ar');
  ConnectionService().initialize(navigatorKey);
  await AppServices.init();
  final initialLocale = await _loadInitialLocale();
  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialLocale});

  final Locale initialLocale;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Size? _cachedScreenSize;
  double? _cachedScaleWidth;

  // StreamSubscription<Uri>? _deepLinkSubscription;
  bool _sessionExpiredDialogShown = false;

  // final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;
  late final GoRouter _router = GoRouter(
    routes: $appRoutes,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: kDebugMode,
    // observers: [FirebaseAnalyticsObserver(analytics: _firebaseAnalytics)],
    initialLocation: SplashRoute().location,
    // redirect: _guard,
  );

  @override
  void initState() {
    super.initState();
    AppLifecycleTracker.instance.start();
    // NetworkHelper().setOnUserArchived(_handleArchivedUser);
    // NetworkHelper().setOnSessionExpired(_handleSessionExpired);
    // _initializeDeepLinks();
  }

  @override
  void dispose() {
    // _deepLinkSubscription?.cancel();
    AppLifecycleTracker.instance.stop();
    super.dispose();
  }

  Future<void> _handleArchivedUser() async {
    // await locator<AuthStorageDataSource>().logout();
    if (mounted) {
      // _router.go(AccountArchivedRoute().location);
    }
  }

  Future<void> _handleSessionExpired() async {
    if (!mounted || _sessionExpiredDialogShown) return;

    _sessionExpiredDialogShown = true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        // Bottom Nav Bar
        BlocProvider<BottomBarCubit>(create: (context) => BottomBarCubit()),
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(initialLocale: widget.initialLocale),
        ),

        // AUTH
        BlocProvider<CodeCheckCubit>(create: (context) => CodeCheckCubit()),
        BlocProvider<RememberMeCubit>(create: (context) => RememberMeCubit()),

      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        fontSizeResolver: (fontSize, instance) => _fontSizeResolver(fontSize, instance, context),
        enableScaleWH: () => true,
        enableScaleText: () => true,
        ensureScreenSize: true,
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp.router(
              scaffoldMessengerKey: rootScaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              theme: AppTheme.lightTheme(locale.languageCode),
              darkTheme: AppTheme.darkTheme(locale.languageCode),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,
              routerConfig: _router,
              builder: (context, child) => Container(
                color: AppColors.backGround,
                child: SafeArea(top: false, child: child!),
              ),
            );
          },
        ),
      ),
    );
  }

  double _fontSizeResolver(num fontSize, ScreenUtil instance, BuildContext context) {
    final display = View.of(context).display;
    final screenSize = display.size / display.devicePixelRatio;
    // final scaleWidth = screenSize.width / const Size(428, 926).width;
    // return fontSize * scaleWidth;

    if (_cachedScreenSize != null && _cachedScreenSize == screenSize) {
      return fontSize * (_cachedScaleWidth ?? 1);
    }

    _cachedScreenSize = screenSize;
    _cachedScaleWidth = screenSize.width / const Size(428, 926).width;
    return fontSize * (_cachedScaleWidth ?? 1);
  }
}

Future<Locale> _loadInitialLocale() async {
  const fallback = Locale('ar');
//   // final storage = locator<LocalStorageHelper>();
//   final response = await storage.getValue(LanguageCubit.boxName, LanguageCubit.localeKey);
//   return response.fold((_) => fallback, (value) {
//     final code = value?.toString();
//     if (code != null && LanguageCubit.supportedLocales.contains(code)) {
//       return Locale(code);
//     }
    return fallback;
//   });
}


Future<String?> _guard(BuildContext context, GoRouterState state) async {
  final Uri uri = state.uri;



  // Fetch token to check if the user is signed in
  // final tokenResult = await locator<AuthStorageDataSource>().getToken();
  // final String? token = tokenResult.fold(
  //       (failure) {
  //     log("Error retrieving token: $failure");
  //     return null;
  //   },
  //       (success) {
  //     log("Token: $success");
  //     return success;
  //   },
  // );

  // final bool signedIn = token != null;

  // Define routes that are allowed without login
  final bool allowedWithoutLogin = [
    // HomeRoute().location,
    // MoreRoute().location,
    SplashRoute().location,
    LoginRoute().location,
    CheckCodeRoute().location,
  ].contains(state.matchedLocation);

  log("###############################################################");
  log("MATCHED LOCATION: ${state.matchedLocation}");
  log("ALLOWED WITHOUT SIGN IN: $allowedWithoutLogin");
  // log("LOGGED: $signedIn");
  log("QUERY PARAMETERS: ${state.uri.queryParameters}");
  log("###############################################################");

  // Redirect to login if the user is not signed in and the route is not allowed
  // if (!signedIn && !allowedWithoutLogin) {
  //   final destination = state.uri.toString();
    // print('4444444444444444444444444444444444');
    // print(state.extra);
    // print('4444444444444444444444444444444444');
    // AuthRedirectStore.save(location: destination, extra: state.extra);
    // final redirectPath = '${LoginRoute().location}?redirect=${Uri.encodeComponent(destination)}';
    // return redirectPath;
  // }

  // Returning null tells GoRouter to keep the current matched location.
  // Returning state.uri.toString() can re-inject absolute deep-link URLs
  // (e.g. https://wlcd.sa/...) and trigger "no routes for location".
  return null;
}

class AuthRedirectStore {
  static String? _location;
  static Object? _extra;

  static void save({required String location, Object? extra}) {
    _location = location;
    _extra = extra;
  }

  static Object? consumeExtraFor(String location) {
    if (_location != location) return null;

    final extra = _extra;
    _location = null;
    _extra = null;
    return extra;
  }

  static void clear() {
    _location = null;
    _extra = null;
  }
}

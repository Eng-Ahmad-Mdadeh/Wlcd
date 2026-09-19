
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/services/locator/locator.config.dart';


final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => locator.init();

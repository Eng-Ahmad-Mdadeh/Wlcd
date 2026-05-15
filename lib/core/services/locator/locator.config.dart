// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../data/data_sources/auth/auth_storage_data_source.dart' as _i244;
import '../../../domain/entity/auth/auth_entity.dart' as _i250;
import '../../helper/local_storage_helper.dart' as _i218;
import '../../helper/network_helper.dart' as _i779;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i218.LocalStorageHelper>(() => _i218.LocalStorageHelper());
    gh.factory<_i779.NetworkHelper>(() => _i779.NetworkHelper());
    gh.factory<_i244.AuthStorageDataSource>(
      () => _i244.AuthStorageDataSource(),
    );
    gh.factory<_i250.AuthEntity>(
      () => _i250.AuthEntity(
        phone: gh<String>(),
        typeMessage: gh<String>(),
        code: gh<String>(),
        fcm: gh<String>(),
        rememberMe: gh<bool>(),
      ),
    );
    return this;
  }
}

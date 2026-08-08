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
import '../../../data/data_sources/auth/auth_remote_data_source.dart' as _i401;
import '../../../data/repository/auth/auth_repository.dart' as _i402;
import '../../../domain/repository/auth/i_auth_repository.dart' as _i403;
import '../../../domain/usecase/auth/register_with_email_usecase.dart' as _i404;
import '../../../domain/usecase/i_use_case.dart' as _i405;
import '../../../data/model/auth/auth_model.dart' as _i406;
import '../../../data/model/base/base_model.dart' as _i407;
import '../../../domain/entity/auth/register_with_email_entity.dart' as _i408;
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
    gh.factory<_i401.AuthRemoteDataSource>(
      () => _i401.AuthRemoteDataSource(),
    );
    gh.factory<_i403.IAuthRepository>(
      () => _i402.AuthRepository(gh<_i401.AuthRemoteDataSource>()),
    );
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i406.AuthModel>?, _i408.RegisterWithEmailEntity>>(
      () => _i404.RegisterWithEmailUsecase(gh<_i403.IAuthRepository>()),
      instanceName: 'RegisterWithEmail',
    );
    return this;
  }
}

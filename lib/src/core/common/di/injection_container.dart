import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_digital_wallet/src/core/common/services/secure_storage_service.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/repository/auth_repo_imp.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/repository/auth_repository.dart';

final sl = GetIt.instance;
void init() {
  // services
  sl
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(storage: sl()),
    )
    // local data sources
    ..registerLazySingleton<AuthLocalDataSourse>(
      () => AuthLocalDataSourseImp(secureStorageService: sl()),
    )
    // remote data sources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(apiClientService: sl()),
    )
    // repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepoImp(authRemoteDataSource: sl(), authLocalDataSourse: sl()),
    );
}

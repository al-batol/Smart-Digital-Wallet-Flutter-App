import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/secure_storage_service.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/repository/auth_repo_imp.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/repository/auth_repository.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/usecases/signin_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/data_sources/dashboard_remote_data_scource.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/repository/dashbaord_repo_imp.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/repository/dashbaord_repository.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/usecases/currency_exchange_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/usecases/get_accounts_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/data_sources/top_up_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/data_sources/top_up_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/repository/top_up_repo_imp.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/repository/top_up_repository.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/usecases/top_up_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/blocs/bloc/top_up_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/data_sources/send_money_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/data_sources/send_money_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/repository/send_money_repo_imp.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/repository/send_money_repository.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/usecases/get_beneficiaries_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/usecases/send_money_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/blocs/bloc/send_money_bloc.dart';

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
    ..registerLazySingleton<ApiClientService>(() => ApiClientService())
    // blocs
    ..registerFactory<AuthBloc>(() => AuthBloc(signInUsecase: sl()))
    ..registerFactory<DashboardBloc>(
      () => DashboardBloc(getAccountsUsecase: sl()),
    )
    ..registerFactory<TopUpBloc>(() => TopUpBloc(topUpUsecase: sl()))
    ..registerFactory<SendMoneyBloc>(
      () =>
          SendMoneyBloc(sendMoneyUsecase: sl(), getBeneficiariesUsecase: sl()),
    )
    // local data sources
    ..registerLazySingleton<AuthLocalDataSourse>(
      () => AuthLocalDataSourseImp(secureStorageService: sl()),
    )
    ..registerLazySingleton<TopUpLocalDataSource>(
      () => TopUpLocalDataSourceImp(),
    )
    ..registerLazySingleton<SendMoneyLocalDataSource>(
      () => SendMoneyLocalDataSourceImp(),
    )
    // remote data sources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(apiClientService: sl()),
    )
    ..registerLazySingleton<DashboardRemoteDataScource>(
      () => DashboardRemoteDataScourceImp(apiClientService: sl()),
    )
    ..registerLazySingleton<TopUpRemoteDataSource>(
      () => TopUpRemoteDataSourceImp(apiClientService: sl()),
    )
    ..registerLazySingleton<SendMoneyRemoteDataSource>(
      () => SendMoneyRemoteDataSourceImp(apiClientService: sl()),
    )
    // repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepoImp(authRemoteDataSource: sl(), authLocalDataSourse: sl()),
    )
    ..registerLazySingleton<DashbaordRepository>(
      () => DashbaordRepoImp(dashbaordRemoteDataSource: sl()),
    )
    ..registerLazySingleton<TopUpRepository>(
      () =>
          TopUpRepoImp(topUpRemoteDataSource: sl(), topUpLocalDataSource: sl()),
    )
    ..registerLazySingleton<SendMoneyRepository>(
      () => SendMoneyRepoImp(
        sendMoneyRemoteDataSource: sl(),
        sendMoneyLocalDataSource: sl(),
      ),
    )
    // usecases
    ..registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(authRepository: sl()),
    )
    ..registerLazySingleton<GetAccountsUsecase>(
      () => GetAccountsUsecase(dashbaordRepository: sl()),
    )
    ..registerLazySingleton<CurrencyExchangeUsecase>(
      () => CurrencyExchangeUsecase(dashbaordRepository: sl()),
    )
    ..registerLazySingleton<TopUpUsecase>(
      () => TopUpUsecase(topUpRepository: sl()),
    )
    ..registerLazySingleton<SendMoneyUsecase>(
      () => SendMoneyUsecase(sendMoneyRepository: sl()),
    )
    ..registerLazySingleton<GetBeneficiariesUsecase>(
      () => GetBeneficiariesUsecase(sendMoneyRepository: sl()),
    );
}

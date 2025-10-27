import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/localization/cubit/localization_cubit.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/biometric_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/network_connectivity_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/secure_storage_service.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/auth/data/repository/auth_repo_imp.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/repository/auth_repository.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/usecases/signin_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/auth/domain/usecases/authenticate_with_biometrics_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/data_sources/dashboard_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/data_sources/dashboard_remote_data_scource.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/repository/dashbaord_repo_imp.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/repository/dashbaord_repository.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/usecases/currency_exchange_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/usecases/get_accounts_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/usecases/get_last_transactions_usecase.dart';
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
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/data_sources/pay_bill_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/data_sources/pay_bill_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/repository/pay_bill_repo_imp.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/repository/pay_bill_repository.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/usecases/pay_bill_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/presentation/blocs/bloc/pay_bill_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  final localAuth = LocalAuthentication();

  final connectivity = Connectivity();

  // services
  sl
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<LocalAuthentication>(() => localAuth)
    ..registerLazySingleton<Connectivity>(() => connectivity)
    ..registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(storage: sl()),
    )
    ..registerLazySingleton<NetworkConnectivityService>(
      () => NetworkConnectivityService(connectivity: sl()),
    )
    ..registerLazySingleton<BiometricService>(
      () => BiometricService(localAuth: sl()),
    )
    ..registerLazySingleton<ApiClientService>(() => ApiClientService())
    // blocs
    ..registerFactory<LocalizationCubit>(
      () => LocalizationCubit(sharedPreferences: sl(), locale: appLanguages[0]),
    )
    ..registerFactory<AuthBloc>(() => AuthBloc(
          signInUsecase: sl(),
          authenticateWithBiometricsUsecase: sl(),
        ))
    ..registerFactory<DashboardBloc>(
      () => DashboardBloc(
        getAccountsUsecase: sl(),
        getLastTransactionsUsecase: sl(),
      ),
    )
    ..registerFactory<TopUpBloc>(() => TopUpBloc(topUpUsecase: sl()))
    ..registerFactory<SendMoneyBloc>(
      () =>
          SendMoneyBloc(sendMoneyUsecase: sl(), getBeneficiariesUsecase: sl()),
    )
    ..registerFactory<PayBillBloc>(() => PayBillBloc(payBillUsecase: sl()))
    // local data sources
    ..registerLazySingleton<AuthLocalDataSourse>(
      () => AuthLocalDataSourseImp(secureStorageService: sl()),
    )
    ..registerLazySingleton<DashboardLocalDataSource>(
      () => DashboardLocalDataSourceImp(),
    )
    ..registerLazySingleton<TopUpLocalDataSource>(
      () => TopUpLocalDataSourceImp(),
    )
    ..registerLazySingleton<SendMoneyLocalDataSource>(
      () => SendMoneyLocalDataSourceImp(),
    )
    ..registerLazySingleton<PayBillLocalDataSource>(
      () => PayBillLocalDataSourceImp(),
    )
    // remote data sources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(
        apiClientService: sl(),
        networkConnectivityService: sl(),
      ),
    )
    ..registerLazySingleton<DashboardRemoteDataScource>(
      () => DashboardRemoteDataScourceImp(
        apiClientService: sl(),
        networkConnectivityService: sl(),
      ),
    )
    ..registerLazySingleton<TopUpRemoteDataSource>(
      () => TopUpRemoteDataSourceImp(
        apiClientService: sl(),
        networkConnectivityService: sl(),
      ),
    )
    ..registerLazySingleton<SendMoneyRemoteDataSource>(
      () => SendMoneyRemoteDataSourceImp(
        apiClientService: sl(),
        networkConnectivityService: sl(),
      ),
    )
    ..registerLazySingleton<PayBillRemoteDataSource>(
      () => PayBillRemoteDataSourceImp(
        apiClientService: sl(),
        networkConnectivityService: sl(),
      ),
    )
    // repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepoImp(
        authRemoteDataSource: sl(), 
        authLocalDataSourse: sl(),
        biometricService: sl(),
      ),
    )
    ..registerLazySingleton<DashbaordRepository>(
      () => DashbaordRepoImp(
        dashbaordRemoteDataSource: sl(),
        dashboardLocalDataSource: sl(),
      ),
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
    ..registerLazySingleton<PayBillRepository>(
      () => PayBillRepoImp(
        payBillRemoteDataSource: sl(),
        payBillLocalDataSource: sl(),
      ),
    )
    // usecases
    ..registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(authRepository: sl()),
    )
    ..registerLazySingleton<AuthenticateWithBiometricsUsecase>(
      () => AuthenticateWithBiometricsUsecase(authRepository: sl()),
    )
    ..registerLazySingleton<GetAccountsUsecase>(
      () => GetAccountsUsecase(dashbaordRepository: sl()),
    )
    ..registerLazySingleton<GetLastTransactionsUsecase>(
      () => GetLastTransactionsUsecase(repository: sl()),
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
    )
    ..registerLazySingleton<PayBillUsecase>(
      () => PayBillUsecase(payBillRepository: sl()),
    );
}

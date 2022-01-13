import 'package:dice_app/core/data/hive_manager.dart';
import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/network/url_config.dart';
import 'package:dice_app/views/auth/bloc/auth_bloc.dart';
import 'package:dice_app/views/auth/data/source/authorization.dart';
import 'package:dice_app/views/chat/bloc/chat_bloc.dart';
import 'package:dice_app/views/chat/data/sources/chat_sources.dart';
import 'package:dice_app/views/home/data/source/remote.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/invite/provider/invite_provider.dart';
import 'package:dice_app/views/invite/source/invite_remote.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/profile/source/remote.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final inject = GetIt.instance;
final sessionManager = SessionManager();
final hiveManager = HiveManager();

Future<void> initializeCore({required Environment environment}) async {
  UrlConfig.environment = environment;
  await initHiveForFlutter();
  await _initializeCore();
  _initServices();
  _initProviders();
  _initBloc();
  _initDataSources();
  _initDataRepositories();
  _initializeUsecase();
}

/// Initialize the core functions here
Future<void> _initializeCore() async {
  await hiveManager.initializeDatabase();
  await sessionManager.initializeSession();
  inject.registerLazySingleton<HiveManager>(() => hiveManager);
  inject.registerLazySingleton<SessionManager>(() => sessionManager);
}

/// Initialize providers here
void _initProviders() {
  inject.registerLazySingleton<HomeProvider>(() => HomeProvider(inject()));
  inject
      .registerLazySingleton<ProfileProvider>(() => ProfileProvider(inject()));
  inject.registerLazySingleton<InviteProvider>(() => InviteProvider(inject()));
}

/// Initialize bloc's here
void _initBloc() {
  inject.registerLazySingleton<AuthBloc>(() => AuthBloc(inject()));
  inject.registerLazySingleton<ChatBloc>(() => ChatBloc(inject()));
}

/// Initialize data sources implementations
void _initDataSources() {}

/// Initialize data repositories implementations
void _initDataRepositories() {}

/// Initialize services's here
void _initServices() {
  inject.registerLazySingleton<DiceGraphQLClient>(
      () => DiceGraphQLClient(baseUrl: UrlConfig.coreBaseUrl));
  inject.registerLazySingleton<AuthService>(
      () => AuthService(networkService: inject()));
  inject.registerLazySingleton<HomeService>(
      () => HomeService(networkService: inject()));
  inject.registerLazySingleton<ProfileService>(
      () => ProfileService(networkService: inject()));
  inject.registerLazySingleton<InviteService>(
      () => InviteService(networkService: inject()));
  inject.registerLazySingleton<ChatService>(
      () => ChatService(networkService: inject()));
}

/// Initialize usecases here
void _initializeUsecase() {}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'api_client.dart';

// Create an instance of GetIt
final GetIt getIt = GetIt.instance;

// Set up the service locator
void setupDependencyInjection() {
  getIt.registerSingleton<Dio>(Dio());

  // Register ApiClient
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  // Register other services if needed
  // getIt.registerSingleton<AnotherService>(AnotherService());
}

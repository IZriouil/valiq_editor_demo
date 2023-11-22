// service locator
// Path: lib\config\service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:valiq_editor_demo/services/account.service.dart';
import 'package:valiq_editor_demo/services/category.service.dart';
import 'package:valiq_editor_demo/services/item.service.dart';
import 'package:valiq_editor_demo/services/menu.service.dart';

final locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => StorageService());

  locator.registerLazySingleton(() => AccountService());
  locator.registerLazySingleton(() => MenuService());
  locator.registerLazySingleton(() => CategoryService());
  locator.registerLazySingleton(() => ItemService());
}

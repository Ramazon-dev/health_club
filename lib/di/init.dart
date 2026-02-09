import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../data/storage/local_storage.dart';
import 'init.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true,
)

void configureDependencies(LocalStorage localStorage) {
  // Регистрируем готовый экземпляр LocalStorage вручную
  getIt.registerSingleton<LocalStorage>(localStorage);

  // Инициализируем остальное (сгенерированный код)
  getIt.init();
}

import 'package:get_it/get_it.dart';
import 'package:helper_core/core/service-locator/service_locator.dart';

// service locattor = sl

class ServiceLocatorManager {
  static final _sl = GetIt.instance;
  final List<ServiceLocator> services;

  ServiceLocatorManager({
    required this.services,
  });

  static Future<void> init({required List<ServiceLocator> services}) async {
    final ServiceLocatorManager container = ServiceLocatorManager(
      services: services,
    );
    await container.call();
    _sl.registerLazySingleton(() => container);
  }

  Future<void> call() async {
    for (final ServiceLocator service in services) {
      await service.call(_sl);
    }
  }
}

GetIt get globalSL => ServiceLocatorManager._sl;

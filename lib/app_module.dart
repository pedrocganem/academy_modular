import 'package:academy_modular/core/adapters/remote_client/remote_client.dart';
import 'package:academy_modular/features/login/login_module.dart';
import 'package:academy_modular/features/onboarding/onboarding_module.dart';
import 'package:academy_modular/features/register/register_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<RemoteClient>(
          (i) => DioRemoteClient(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          Modular.initialRoute,
          module: LoginModule(),
        ),
        ModuleRoute(
          '/register/',
          module: RegisterModule(),
        ),
        ModuleRoute(
          '/onboarding/',
          module: OnboardingModule(),
        ),
      ];
}

import 'package:academy_modular/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:academy_modular/features/login/data/repositories/login_repository.dart';
import 'package:academy_modular/features/login/domain/use_cases/login_with_credentials_use_case.dart';
import 'package:academy_modular/features/login/view/controller/login_controller.dart';
import 'package:academy_modular/features/login/view/page/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  
  @override
  List<Bind> get binds => [
        Bind<LoginRemoteDataSource>((i) => ApiLoginRemoteDataSource()),
        Bind<LoginRepository>((i) => DefaultLoginRepository()),
        Bind<LoginWithCredentialsUseCase>(
            (i) => DefaultLoginWithCredentialsUseCase()),
        Bind<LoginController>((i) => LoginController())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (context,args) =>  LoginPage())
      ];
}

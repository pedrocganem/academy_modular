import 'package:academy_modular/features/login/login_module.dart';
import 'package:academy_modular/features/login/view/controller/login_controller.dart';
import 'package:academy_modular/features/login/view/page/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

void main() {
  testGoldens("Login Page Tests |", (WidgetTester tester) async {
    initModule(LoginModule(),
        replaceBinds: [Bind.instance<LoginController>(LoginControllerMock())]);
    loadAppFonts();
    final deviceBuilder = DeviceBuilder()

      ///pick wanted devices
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.phone,
          Device.iphone11,
          // Device.tabletLandscape,
          // Device.tabletPortrait,
        ],
      )
      ..addScenario(
        widget: LoginPage(),
        name: "Login Page without interactions",
      );

    await tester.pumpDeviceBuilder(deviceBuilder);
    await screenMatchesGolden(tester, "multi_scenario_home_page");
  });
}

class LoginControllerMock extends Mock implements LoginController {}

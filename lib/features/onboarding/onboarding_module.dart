import 'package:academy_modular/features/onboarding/view/onboarding_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnboardingModule extends Module {
  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes =>  [
    ChildRoute(Modular.initialRoute, child: ((context, args) => const OnboardingView())),
  ];
}

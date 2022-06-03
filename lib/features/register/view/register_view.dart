
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: const Text("REGISTER PAGE")),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Modular.to.pushNamed("/onboarding");
      }),
    );
  }
}

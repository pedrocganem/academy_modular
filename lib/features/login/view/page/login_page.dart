import 'package:academy_modular/core/generics/resource.dart';
import 'package:academy_modular/features/login/view/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  final _controller = Modular.get<LoginController>();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(
              fit: FlexFit.tight,
              child: Hero(
                tag: "flutter-logo",
                child: FlutterLogo(
                  size: double.maxFinite,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Observer(builder: (_) {
                  return TextField(
                    decoration: InputDecoration(
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onChanged: _controller.changeEmail,
                  );
                }),
                const SizedBox(height: 24),
                Observer(builder: (_) {
                  return TextField(
                    obscureText: !_controller.isPasswordVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: _controller.isPasswordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: _controller.changePasswordVisibility),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onChanged: _controller.changePassword,
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        child: const Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.start,
                        ),
                        onPressed: () {}),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: const Text("Não possui uma conta?"),
                  onPressed: () async {},
                ),
                SizedBox(
                  height: 48,
                  child: Observer(builder: (_) {
                    bool isLoading = _controller.isButtonAtLoadingStatus;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: _controller.areCredentialsValid
                          ? () async {
                              _controller.setButtonToLoadingStatus();
                              final resource = await _controller.loginUser();
                              if (resource.hasError) {
                                // await showDialog(
                                //         context: context,
                                //         builder: (context) {
                                //           // return CustomErrorDialog(
                                //           //     errorMessage:
                                //           //         resource.error.toString(),
                                //           //     onPressed: () =>
                                //           //         Navigator.pop(context));
                                //         })
                                //     .then((_) => _controller
                                //         .isButtonAtLoadingStatus = false);
                              }

                              if (resource.status == Status.success) {
                                await Modular.to.pushNamed('/register/');
                              }
                            }
                          : null,
                      child: isLoading
                          ? Lottie.network(
                              "https://assets9.lottiefiles.com/private_files/lf30_ykdoon9j.json",
                              width: 36)
                          : Text(_controller.areCredentialsValid
                              ? "Entrar"
                              : "Credenciais inválidas"),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

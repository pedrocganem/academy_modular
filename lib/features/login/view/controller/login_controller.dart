import 'package:academy_modular/core/generics/resource.dart';
import 'package:academy_modular/features/login/data/login_error.dart';
import 'package:academy_modular/features/login/domain/entities/user_entity.dart';
import 'package:academy_modular/features/login/domain/use_cases/login_with_credentials_use_case.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final _loginWithCredentials = Modular.get<LoginWithCredentialsUseCase>();

  @observable
  String email = '';

  @action
  void changeEmail(String newValue) => email = newValue;

  @observable
  String password = '';

  @action
  void changePassword(String newValue) => password = newValue;

  @observable
  Resource<UserEntity, LoginError> user = Resource.loading();

  @observable
  bool isPasswordVisible = false;

  @observable
  bool isButtonAtLoadingStatus = false;

  @action
  void setButtonToLoadingStatus() => isButtonAtLoadingStatus = true;

  @action
  void changePasswordVisibility() => isPasswordVisible = !isPasswordVisible;

  @computed
  bool get areCredentialsValid => isEmailValid && isPasswordValid;

  @action
  Future<Resource<void, LoginError>> loginUser() async {
    final resource = await _loginWithCredentials.loginUser(email, password);
    if (resource.hasError) {
      return Resource.failed(error: LoginError.invalidCredentials);
    }
    user = resource;
    return Resource.success();
  }

  @computed
  bool get isEmailValid =>
      email.isNotEmpty && email.contains('@') && email.contains(".com");

  @computed
  bool get isPasswordValid => password.length > 7;
}

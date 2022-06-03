import 'package:academy_modular/core/adapters/remote_client/remote_client.dart';
import 'package:academy_modular/core/constants/api_routes.dart';
import 'package:academy_modular/core/generics/resource.dart';
import 'package:academy_modular/features/login/data/login_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class LoginRemoteDataSource {
  Future<Resource<Map<String, dynamic>, LoginError>> loginUser(
      String email, String password);
}

class ApiLoginRemoteDataSource implements LoginRemoteDataSource {
  final _remoteClient = Modular.get<RemoteClient>();

  @override
  Future<Resource<Map<String, dynamic>, LoginError>> loginUser(
      String email, String password) async {
    final response = await _remoteClient.post(
      ApiRoutes.loginApiRoute,
      {"email": email, "password": password},
    );
    if (response.statusCode != 201) {
      return Resource.failed(error: LoginError.invalidCredentials);
    }
    return Resource.success(data: response.data);
  }
}

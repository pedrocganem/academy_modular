import 'dart:math';

import 'package:academy_modular/app_module.dart';
import 'package:academy_modular/core/adapters/remote_client/remote_client.dart';
import 'package:academy_modular/core/generics/api_response.dart';
import 'package:academy_modular/core/adapters/remote_client/remote_client_error.dart';
import 'package:academy_modular/core/generics/resource.dart';
import 'package:academy_modular/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

void main() {
  final stub = RemoteClientStub();

  group('LoginRemoteDataSource tests', () {
    initModule(AppModule(), replaceBinds: [Bind.instance<RemoteClient>(stub)]);
    const dummyString = "adsasd";
    final sut = ApiLoginRemoteDataSource();

    test("When statusCode != 201 then it should return an error", (() async {
      //Given
      stub.apiResponseToUse = ApiResponse(statusCode: 400);
      //When
      final result = await sut.loginUser(dummyString, dummyString);
      //Then
      expect(result.error, isNot(null));
      expect(result.data, isNull);
      expect(result.status, Status.failed);
    }));
    test("When statusCode == 201 then it should run successfully", (() async {
      //Given
      stub.apiResponseToUse =
          ApiResponse(statusCode: 201, data: {"data": "data"});
      //When
      final result = await sut.loginUser(dummyString, dummyString);
      //Then
      expect(result.data, isNot(null));
      expect(result.error, isNull);
      expect(result.status, Status.success);
    }));
  });
}

class RemoteClientStub implements RemoteClient {
  ApiResponse<Map<String, dynamic>, RemoteClientError>? apiResponseToUse;

  @override
  Future<ApiResponse<Map<String, dynamic>, RemoteClientError>> get(
      String url) async {
    return apiResponseToUse!;
  }

  @override
  Future<ApiResponse<Map<String, dynamic>, RemoteClientError>> post(
      String url, Map<String, dynamic> body) async {
    return apiResponseToUse!;
  }
}

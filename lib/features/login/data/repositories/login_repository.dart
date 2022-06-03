import 'package:academy_modular/core/generics/resource.dart';
import 'package:academy_modular/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:academy_modular/features/login/data/login_error.dart';
import 'package:academy_modular/features/login/domain/entities/user_entity.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class LoginRepository {
  Future<Resource<UserEntity, LoginError>> loginUser(
      String email, String password);
}

class DefaultLoginRepository implements LoginRepository {
  final _dataSource = Modular.get<LoginRemoteDataSource>();

  @override
  Future<Resource<UserEntity, LoginError>> loginUser(
      String email, String password) async {
    final resource = await _dataSource.loginUser(email, password);
    if (resource.hasError) {
      return Resource.failed(error: resource.error);
    }

    final userMap = resource.data;
    final userEntity = UserEntity.fromMap(userMap!);
    return Resource.success(data: userEntity);
  }
}

class UserEntity {
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  String? password;

  UserEntity(
      {this.firstName, this.lastName, this.token, this.email, this.password});

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
        firstName: map["first_name"],
        lastName: map["last_name"],
        email: map["email"],
        token: map["token"]);
  }

  Map<String, dynamic> toMap(UserEntity entity) {
    return {
      "first_name": entity.firstName,
      "last_name": entity.lastName,
      "email": entity.email,
      "password": entity.password
    };
  }
}

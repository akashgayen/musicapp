import 'dart:convert';

class UserModel {
  final String token;
  final String id;
  final String name;
  final String email;
  UserModel({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
  });

  UserModel copyWith({
    String? token,
    String? id,
    String? name,
    String? email,
  }) {
    return UserModel(
      token: token ?? this.token,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(token: $token, id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token &&
      other.id == id &&
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode {
    return token.hashCode ^
      id.hashCode ^
      name.hashCode ^
      email.hashCode;
  }
}

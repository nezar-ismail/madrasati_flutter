import 'dart:convert';

import 'user.dart';

class LoginResponse {
  String? accessToken;
  String? token;
  DateTime? expiryDate;
  User? user;
  LoginResponse({
    this.accessToken,
    this.token,
    this.expiryDate,
    this.user,
  });

  LoginResponse copyWith({
    String? accessToken,
    String? token,
    DateTime? expiryDate,
    User? user,
  }) {
    return LoginResponse(
      accessToken: accessToken ?? this.accessToken,
      token: token ?? this.token,
      expiryDate: expiryDate ?? this.expiryDate,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'token': token,
      'expiryDate': expiryDate?.millisecondsSinceEpoch,
      'user': user?.toMap(),
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      expiryDate: map['expiryDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expiryDate'] as int)
          : null,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponse(accessToken: $accessToken, token: $token, expiryDate: $expiryDate, user: $user)';
  }

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.token == token &&
        other.expiryDate == expiryDate &&
        other.user == user;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
        token.hashCode ^
        expiryDate.hashCode ^
        user.hashCode;
  }
}

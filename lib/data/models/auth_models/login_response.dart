import 'dart:convert';

import 'package:madrasati/data/models/auth_models/data.dart';

import 'user.dart';

class LoginResponse {
  String? accessToken;
  String? token;
  DateTime? expiryDate;
  Student? user;
  Data? data;
  LoginResponse({
    this.accessToken,
    this.token,
    this.expiryDate,
    this.user,
    this.data,
  });

  /// Creates a copy of this [LoginResponse] with the given fields replaced with the new values.
  ///
  /// If a field is not provided, it will keep its current value.
  ///
  /// This method is useful when you need to update a [LoginResponse] object without
  /// having to create a new instance.
  ///
  /// Example:
  ///
  /// 
  LoginResponse copyWith({
    String? accessToken,
    String? token,
    DateTime? expiryDate,
    Student? user,
    Data? data,
  }) {
    return LoginResponse(
      data: data ?? this.data,
      accessToken: accessToken ?? this.accessToken,
      token: token ?? this.token,
      expiryDate: expiryDate ?? this.expiryDate,
      user: user ?? this.user,
    );
  }

  /// Converts this [LoginResponse] to a [Map<String, dynamic>].
  ///
  /// The keys of the map are the same as the properties of this class, and the values are the
  /// values of the corresponding properties. [expiryDate] is converted to milliseconds since
  /// the epoch, and [user] and [data] are converted using their respective [toMap] methods.
  ///
  /// This method is useful when you need to convert a [LoginResponse] to a map for serializing
  /// or sending over a network.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'token': token,
      'expiryDate': expiryDate?.millisecondsSinceEpoch,
      'user': user?.toMap(),
      'data': data?.toMap(),
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
          ? Student.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      data: map['data'] != null
          ? Data.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponse(accessToken: $accessToken, token: $token, expiryDate: $expiryDate, user: $user, data: $data)';
  }

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.token == token &&
        other.expiryDate == expiryDate &&
        other.user == user &&
        other.data == data;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
        token.hashCode ^
        expiryDate.hashCode ^
        user.hashCode ^ 
        data.hashCode;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

class RoleCardInfo {
  final String image;
  final String role;
  Color color;
  RoleCardInfo({
    required this.image,
    required this.role,
    required this.color,
  });

  RoleCardInfo copyWith({
    String? image,
    String? role,
    Color? color,
  }) {
    return RoleCardInfo(
      image: image ?? this.image,
      role: role ?? this.role,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'role': role,
      'color': color.value,
    };
  }

  factory RoleCardInfo.fromMap(Map<String, dynamic> map) {
    return RoleCardInfo(
      image: map['image'] as String,
      role: map['role'] as String,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoleCardInfo.fromJson(String source) =>
      RoleCardInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RoleCardInfo(image: $image, role: $role, color: $color)';

  @override
  bool operator ==(covariant RoleCardInfo other) {
    if (identical(this, other)) return true;

    return other.image == image && other.role == role && other.color == color;
  }

  @override
  int get hashCode => image.hashCode ^ role.hashCode ^ color.hashCode;
}

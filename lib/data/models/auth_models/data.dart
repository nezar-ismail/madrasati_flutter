// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Data {
  final String schoolId;
  final String groupId;

  Data({
    required this.schoolId,
    required this.groupId,
  });

  /// Creates a copy of this [Data] but with the given fields replaced with the
  /// new values.
  ///
  /// [schoolId] and [groupId] can be null, in which case they will be ignored.
  ///
  /// Returns a new object with the given fields replaced, without modifying the
  /// original object.
  Data copyWith({
    String? schoolId,
    String? groupId,
  }) {
    return Data(
      schoolId: schoolId ?? this.schoolId,
      groupId: groupId ?? this.groupId,
    );
  }

  /// Converts this [Data] instance into a [Map] with keys 'schoolId' and 'groupId',
  /// and their respective values from the instance.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'schoolId': schoolId,
      'groupId': groupId,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      schoolId: map['schoolId'] as String,
      groupId: map['groupId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(schoolId: $schoolId, groupId: $groupId)';

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;
  
    return 
      other.schoolId == schoolId &&
      other.groupId == groupId;
  }

  @override
  int get hashCode => schoolId.hashCode ^ groupId.hashCode;
}

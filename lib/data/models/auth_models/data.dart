// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Data {
  final String schoolId;
  final String groupId;

  Data({
    required this.schoolId,
    required this.groupId,
  });

  Data copyWith({
    String? schoolId,
    String? groupId,
  }) {
    return Data(
      schoolId: schoolId ?? this.schoolId,
      groupId: groupId ?? this.groupId,
    );
  }

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

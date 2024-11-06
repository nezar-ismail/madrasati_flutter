// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sort {
  final String direction;
  final String nullHandling;
  final bool ascending;
  final String property;
  final bool ignoreCase;
  Sort({
    required this.direction,
    required this.nullHandling,
    required this.ascending,
    required this.property,
    required this.ignoreCase,
  });

  Sort copyWith({
    String? direction,
    String? nullHandling,
    bool? ascending,
    String? property,
    bool? ignoreCase,
  }) {
    return Sort(
      direction: direction ?? this.direction,
      nullHandling: nullHandling ?? this.nullHandling,
      ascending: ascending ?? this.ascending,
      property: property ?? this.property,
      ignoreCase: ignoreCase ?? this.ignoreCase,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'direction': direction,
      'nullHandling': nullHandling,
      'ascending': ascending,
      'property': property,
      'ignoreCase': ignoreCase,
    };
  }

  factory Sort.fromMap(Map<String, dynamic> map) {
    return Sort(
      direction: map['direction'] as String,
      nullHandling: map['nullHandling'] as String,
      ascending: map['ascending'] as bool,
      property: map['property'] as String,
      ignoreCase: map['ignoreCase'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sort.fromJson(String source) => Sort.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Sort(direction: $direction, nullHandling: $nullHandling, ascending: $ascending, property: $property, ignoreCase: $ignoreCase)';
  }

  @override
  bool operator ==(covariant Sort other) {
    if (identical(this, other)) return true;
  
    return 
      other.direction == direction &&
      other.nullHandling == nullHandling &&
      other.ascending == ascending &&
      other.property == property &&
      other.ignoreCase == ignoreCase;
  }

  @override
  int get hashCode {
    return direction.hashCode ^
      nullHandling.hashCode ^
      ascending.hashCode ^
      property.hashCode ^
      ignoreCase.hashCode;
  }
  }

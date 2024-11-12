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

  /// Creates a copy of this [Sort] object with the given fields replaced with the new values.
  ///
  /// If a field is not provided, it will retain its current value from the original object.
  ///
  /// This method is useful for creating modified copies of a [Sort] instance
  /// without changing the original instance.
  ///
  /// Example:
  /// ```
  /// Sort original = Sort(direction: "ASC", nullHandling: "NATIVE", ascending: true, property: "name", ignoreCase: false);
  /// Sort modified = original.copyWith(direction: "DESC");
  /// ```
  /// In the above example, `modified` is a new [Sort] instance with the `direction`
  /// field changed to "DESC", while other fields remain unchanged.
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

  /// Converts this [Sort] object into a [Map] representation.
  ///
  /// The keys in the map correspond to the field names of the [Sort] object,
  /// and the values are the respective field values.
  ///
  /// This method is useful for serialization and transferring data in a
  /// key-value format.
  ///
  /// Returns a [Map] with the following keys:
  /// - 'direction': the sorting direction.
  /// - 'nullHandling': the null handling strategy.
  /// - 'ascending': whether the sort is ascending.
  /// - 'property': the property being sorted.
  /// - 'ignoreCase': whether case is ignored in sorting.
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
  /// Returns a string representation of the [Sort] object.
  ///
  /// The string includes the values of all fields: `direction`, `nullHandling`,
  /// `ascending`, `property`, and `ignoreCase`.
  ///
  /// This method is useful for debugging and logging purposes to get a quick
  /// overview of the [Sort] object's current state.
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

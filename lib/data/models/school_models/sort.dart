// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sort {
  final bool empty;
  final bool sorted;
  final bool unsorted;
  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });

/// Creates a copy of this [Sort] object with the given fields replaced with the new values.
///
/// If a field is not provided, it will retain its current value from the original object.
///
/// This method is useful for creating modified copies of a [Sort] instance
/// without changing the original instance.
  Sort copyWith({
    bool? empty,
    bool? sorted,
    bool? unsorted,
  }) {
    return Sort(
      empty: empty ?? this.empty,
      sorted: sorted ?? this.sorted,
      unsorted: unsorted ?? this.unsorted,
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
  /// - 'empty': whether the list is empty
  /// - 'sorted': whether the list is sorted
  /// - 'unsorted': whether the list is unsorted
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'empty': empty,
      'sorted': sorted,
      'unsorted': unsorted,
    };
  }

  factory Sort.fromMap(Map<String, dynamic> map) {
    return Sort(
      empty: map['empty'] as bool,
      sorted: map['sorted'] as bool,
      unsorted: map['unsorted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sort.fromJson(String source) =>
      Sort.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  /// Returns a string representation of the [Sort] object.
  ///
  /// The string includes the values of all fields: `empty`, `sorted`, and `unsorted`.
  ///
  /// This method is useful for debugging and logging purposes to get a quick
  /// overview of the [Sort] object's current state.
  String toString() =>
      'Pageable(empty: $empty, sorted: $sorted, unsorted: $unsorted)';

  @override
  bool operator ==(covariant Sort other) {
    if (identical(this, other)) return true;

    return other.empty == empty &&
        other.sorted == sorted &&
        other.unsorted == unsorted;
  }

  @override
  int get hashCode => empty.hashCode ^ sorted.hashCode ^ unsorted.hashCode;
}

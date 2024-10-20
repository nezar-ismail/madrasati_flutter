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

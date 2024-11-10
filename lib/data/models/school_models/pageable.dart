// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


import 'package:madrasati/data/models/school_models/sort.dart';

class Pageable {
  final int offset;
  final Sort sort;
  final bool paged;
  final int pageNumber;
  final int pageSize;
  final bool unpaged;
  Pageable({
    required this.offset,
    required this.sort,
    required this.paged,
    required this.pageNumber,
    required this.pageSize,
    required this.unpaged,
  });

  /// Creates a copy of this [Pageable] but with the given fields replaced with the new values.
  ///
  /// If a field is not provided, it will keep its current value.
  ///
  /// This method is useful for creating modified copies of a [Pageable] instance
  /// without changing the original instance.
  ///
  /// Example:
  /// 
  Pageable copyWith({
    int? offset,
    Sort? sort,
    bool? paged,
    int? pageNumber,
    int? pageSize,
    bool? unpaged,
  }) {
    return Pageable(
      offset: offset ?? this.offset,
      sort: sort ?? this.sort,
      paged: paged ?? this.paged,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      unpaged: unpaged ?? this.unpaged,
    );
  }

/// Converts this [Pageable] object into a [Map] representation.
///
/// This method is useful for serialization and transferring data
/// in a key-value format. The returned map contains the following
/// key-value pairs:
///
/// - `offset`: the offset of the pagination.
/// - `sort`: the sort order, represented as a map.
/// - `paged`: indicates if the pagination is paged.
/// - `pageNumber`: the current page number.
/// - `pageSize`: the size of the page.
/// - `unpaged`: indicates if the pagination is unpaged.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offset': offset,
      'sort': sort.toMap(),
      'paged': paged,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'unpaged': unpaged,
    };
  }

  factory Pageable.fromMap(Map<String, dynamic> map) {
    return Pageable(
      offset: map['offset'] as int,
      sort: Sort.fromMap(map['sort'] as Map<String,dynamic>),
      paged: map['paged'] as bool,
      pageNumber: map['pageNumber'] as int,
      pageSize: map['pageSize'] as int,
      unpaged: map['unpaged'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pageable.fromJson(String source) => Pageable.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  /// Returns a string representation of the [Pageable] object, including
  /// all its fields such as `offset`, `sort`, `paged`, `pageNumber`, `pageSize`,
  /// and `unpaged`. This method is useful for debugging and logging purposes
  /// to get a quick overview of the [Pageable] object's current state.
  String toString() {
    return 'Pageable(offset: $offset, sort: $sort, paged: $paged, pageNumber: $pageNumber, pageSize: $pageSize, unpaged: $unpaged)';
  }

  @override
  bool operator ==(covariant Pageable other) {
    if (identical(this, other)) return true;
  
    return 
      other.offset == offset &&
      other.sort == sort &&
      other.paged == paged &&
      other.pageNumber == pageNumber &&
      other.pageSize == pageSize &&
      other.unpaged == unpaged;
  }

  @override
  int get hashCode {
    return offset.hashCode ^
      sort.hashCode ^
      paged.hashCode ^
      pageNumber.hashCode ^
      pageSize.hashCode ^
      unpaged.hashCode;
  }
}

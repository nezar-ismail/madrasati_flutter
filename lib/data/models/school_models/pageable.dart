// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:madrasati/data/models/school_models/sort.dart';

class Pageable {
  final int offset;
  final List<Sort> sort;
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

  Pageable copyWith({
    int? offset,
    List<Sort>? sort,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offset': offset,
      'sort': sort.map((x) => x.toMap()).toList(),
      'paged': paged,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'unpaged': unpaged,
    };
  }

  factory Pageable.fromMap(Map<String, dynamic> map) {
    return Pageable(
      offset: map['offset'] as int,
      sort: List<Sort>.from(
        (map['sort'] as List<int>).map<Sort>(
          (x) => Sort.fromMap(x as Map<String, dynamic>),
        ),
      ),
      paged: map['paged'] as bool,
      pageNumber: map['pageNumber'] as int,
      pageSize: map['pageSize'] as int,
      unpaged: map['unpaged'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pageable.fromJson(String source) =>
      Pageable.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pageable(offset: $offset, sort: $sort, paged: $paged, pageNumber: $pageNumber, pageSize: $pageSize, unpaged: $unpaged)';
  }

  @override
  bool operator ==(covariant Pageable other) {
    if (identical(this, other)) return true;

    return other.offset == offset &&
        listEquals(other.sort, sort) &&
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

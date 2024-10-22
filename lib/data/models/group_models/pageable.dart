// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../school_models/sort.dart';

class Pageable {
  int pageNumber;
  int pageSize;
  Sort sort;
  int offset;
  bool paged;
  bool unpaged;
  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  Pageable copyWith({
    int? pageNumber,
    int? pageSize,
    Sort? sort,
    int? offset,
    bool? paged,
    bool? unpaged,
  }) {
    return Pageable(
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      sort: sort ?? this.sort,
      offset: offset ?? this.offset,
      paged: paged ?? this.paged,
      unpaged: unpaged ?? this.unpaged,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'sort': sort.toMap(),
      'offset': offset,
      'paged': paged,
      'unpaged': unpaged,
    };
  }

  factory Pageable.fromMap(Map<String, dynamic> map) {
    return Pageable(
      pageNumber: map['pageNumber'] as int,
      pageSize: map['pageSize'] as int,
      sort: Sort.fromMap(map['sort'] as Map<String, dynamic>),
      offset: map['offset'] as int,
      paged: map['paged'] as bool,
      unpaged: map['unpaged'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pageable.fromJson(String source) =>
      Pageable.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pageable(pageNumber: $pageNumber, pageSize: $pageSize, sort: $sort, offset: $offset, paged: $paged, unpaged: $unpaged)';
  }

  @override
  bool operator ==(covariant Pageable other) {
    if (identical(this, other)) return true;

    return other.pageNumber == pageNumber &&
        other.pageSize == pageSize &&
        other.sort == sort &&
        other.offset == offset &&
        other.paged == paged &&
        other.unpaged == unpaged;
  }

  @override
  int get hashCode {
    return pageNumber.hashCode ^
        pageSize.hashCode ^
        sort.hashCode ^
        offset.hashCode ^
        paged.hashCode ^
        unpaged.hashCode;
  }
}

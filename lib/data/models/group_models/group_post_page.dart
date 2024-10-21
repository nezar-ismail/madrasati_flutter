import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:madrasati/data/models/common_response_model.dart';

import '../school_models/pageable.dart';
import '../school_models/sort.dart';
import 'content.dart';

class PostResponse implements ResponsModel {
  List<Content> content;
  Pageable pageable;
  bool last;
  int totalElements;
  int totalPages;
  int size;
  int number;
  Sort sort;
  bool first;
  int numberOfElements;
  bool empty;
  PostResponse({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  PostResponse copyWith({
    List<Content>? content,
    Pageable? pageable,
    bool? last,
    int? totalElements,
    int? totalPages,
    int? size,
    int? number,
    Sort? sort,
    bool? first,
    int? numberOfElements,
    bool? empty,
  }) {
    return PostResponse(
      content: content ?? this.content,
      pageable: pageable ?? this.pageable,
      last: last ?? this.last,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      size: size ?? this.size,
      number: number ?? this.number,
      sort: sort ?? this.sort,
      first: first ?? this.first,
      numberOfElements: numberOfElements ?? this.numberOfElements,
      empty: empty ?? this.empty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content.map((x) => x.toMap()).toList(),
      'pageable': pageable.toMap(),
      'last': last,
      'totalElements': totalElements,
      'totalPages': totalPages,
      'size': size,
      'number': number,
      'sort': sort.toMap(),
      'first': first,
      'numberOfElements': numberOfElements,
      'empty': empty,
    };
  }

  factory PostResponse.fromMap(Map<String, dynamic> map) {
    return PostResponse(
      content: List<Content>.from(
        (map['content'] as List<int>).map<Content>(
          (x) => Content.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pageable: Pageable.fromMap(map['pageable'] as Map<String, dynamic>),
      last: map['last'] as bool,
      totalElements: map['totalElements'] as int,
      totalPages: map['totalPages'] as int,
      size: map['size'] as int,
      number: map['number'] as int,
      sort: Sort.fromMap(map['sort'] as Map<String, dynamic>),
      first: map['first'] as bool,
      numberOfElements: map['numberOfElements'] as int,
      empty: map['empty'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostResponse.fromJson(String source) =>
      PostResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostResponse(content: $content, pageable: $pageable, last: $last, totalElements: $totalElements, totalPages: $totalPages, size: $size, number: $number, sort: $sort, first: $first, numberOfElements: $numberOfElements, empty: $empty)';
  }

  @override
  bool operator ==(covariant PostResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.content, content) &&
        other.pageable == pageable &&
        other.last == last &&
        other.totalElements == totalElements &&
        other.totalPages == totalPages &&
        other.size == size &&
        other.number == number &&
        other.sort == sort &&
        other.first == first &&
        other.numberOfElements == numberOfElements &&
        other.empty == empty;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        pageable.hashCode ^
        last.hashCode ^
        totalElements.hashCode ^
        totalPages.hashCode ^
        size.hashCode ^
        number.hashCode ^
        sort.hashCode ^
        first.hashCode ^
        numberOfElements.hashCode ^
        empty.hashCode;
  }
}

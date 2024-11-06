// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:madrasati/data/models/comment_model/comment_data.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/models/school_models/pageable.dart';
import 'package:madrasati/data/models/school_models/sort.dart';

class CommentData implements ResponsModel {
  final int totalElements;
  final int totalPages;
  final int size;
  final List<Comment> content;
  final int number;
  final List<Sort> sort;
  final bool first;
  final bool last;
  final int numberOfElements;
  final Pageable pageable;
  final bool empty;
  CommentData({
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.content,
    required this.number,
    required this.sort,
    required this.first,
    required this.last,
    required this.numberOfElements,
    required this.pageable,
    required this.empty,
  });

  CommentData copyWith({
    int? totalElements,
    int? totalPages,
    int? size,
    List<Comment>? content,
    int? number,
    List<Sort>? sort,
    bool? first,
    bool? last,
    int? numberOfElements,
    Pageable? pageable,
    bool? empty,
  }) {
    return CommentData(
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      size: size ?? this.size,
      content: content ?? this.content,
      number: number ?? this.number,
      sort: sort ?? this.sort,
      first: first ?? this.first,
      last: last ?? this.last,
      numberOfElements: numberOfElements ?? this.numberOfElements,
      pageable: pageable ?? this.pageable,
      empty: empty ?? this.empty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalElements': totalElements,
      'totalPages': totalPages,
      'size': size,
      'content': content.map((x) => x.toMap()).toList(),
      'number': number,
      'sort': sort.map((x) => x.toMap()).toList(),
      'first': first,
      'last': last,
      'numberOfElements': numberOfElements,
      'pageable': pageable.toMap(),
      'empty': empty,
    };
  }

  factory CommentData.fromMap(Map<String, dynamic> map) {
    return CommentData(
      totalElements: map['totalElements'] as int,
      totalPages: map['totalPages'] as int,
      size: map['size'] as int,
      content: List<Comment>.from(
        (map['content'] as List<dynamic>).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      number: map['number'] as int,
      sort: List<Sort>.from(
        (map['sort'] as List<dynamic>).map<Sort>(
          (x) => Sort.fromMap(x as Map<String, dynamic>),
        ),
      ),
      first: map['first'] as bool,
      last: map['last'] as bool,
      numberOfElements: map['numberOfElements'] as int,
      pageable: Pageable.fromMap(map['pageable'] as Map<String, dynamic>),
      empty: map['empty'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentData.fromJson(String source) =>
      CommentData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(totalElements: $totalElements, totalPages: $totalPages, size: $size, content: $content, number: $number, sort: $sort, first: $first, last: $last, numberOfElements: $numberOfElements, pageable: $pageable, empty: $empty)';
  }

  @override
  bool operator ==(covariant CommentData other) {
    if (identical(this, other)) return true;

    return other.totalElements == totalElements &&
        other.totalPages == totalPages &&
        other.size == size &&
        listEquals(other.content, content) &&
        other.number == number &&
        listEquals(other.sort, sort) &&
        other.first == first &&
        other.last == last &&
        other.numberOfElements == numberOfElements &&
        other.pageable == pageable &&
        other.empty == empty;
  }

  @override
  int get hashCode {
    return totalElements.hashCode ^
        totalPages.hashCode ^
        size.hashCode ^
        content.hashCode ^
        number.hashCode ^
        sort.hashCode ^
        first.hashCode ^
        last.hashCode ^
        numberOfElements.hashCode ^
        pageable.hashCode ^
        empty.hashCode;
  }
}

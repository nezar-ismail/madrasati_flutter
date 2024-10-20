// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:madrasati/data/models/common_response_model.dart';

import 'package:madrasati/data/models/school_models/pageable.dart';

import 'sort.dart';
import 'school_card.dart';

class SchoolHomePage implements ResponsModel {
  final int totalElements;
  final int totalPages;
  final int size;
  final List<SchoolCard> content;
  final int number;
  final bool first;
  final bool last;
  final int numberOfElements;
  final Sort sort;
  final Pageable pageable;
  final bool empty;
  SchoolHomePage({
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.content,
    required this.number,
    required this.first,
    required this.last,
    required this.numberOfElements,
    required this.sort,
    required this.pageable,
    required this.empty,
  });

  SchoolHomePage copyWith({
    int? totalElements,
    int? totalPages,
    int? size,
    List<SchoolCard>? content,
    int? number,
    bool? first,
    bool? last,
    int? numberOfElements,
    Sort? sort,
    Pageable? pageable,
    bool? empty,
  }) {
    return SchoolHomePage(
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      size: size ?? this.size,
      content: content ?? this.content,
      number: number ?? this.number,
      first: first ?? this.first,
      last: last ?? this.last,
      numberOfElements: numberOfElements ?? this.numberOfElements,
      sort: sort ?? this.sort,
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
      'first': first,
      'last': last,
      'numberOfElements': numberOfElements,
      'sort': sort.toMap(),
      'pageable': pageable.toMap(),
      'empty': empty,
    };
  }

  factory SchoolHomePage.fromMap(Map<String, dynamic> map) {
    return SchoolHomePage(
      totalElements: map['totalElements'] as int,
      totalPages: map['totalPages'] as int,
      size: map['size'] as int,
      content: List<SchoolCard>.from(
        (map['content'] as List<int>).map<SchoolCard>(
          (x) => SchoolCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      number: map['number'] as int,
      first: map['first'] as bool,
      last: map['last'] as bool,
      numberOfElements: map['numberOfElements'] as int,
      sort: Sort.fromMap(map['sort'] as Map<String, dynamic>),
      pageable: Pageable.fromMap(map['pageable'] as Map<String, dynamic>),
      empty: map['empty'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchoolHomePage.fromJson(String source) =>
      SchoolHomePage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SchoolHomePage(totalElements: $totalElements, totalPages: $totalPages, size: $size, content: $content, number: $number, first: $first, last: $last, numberOfElements: $numberOfElements, sort: $sort, pageable: $pageable, empty: $empty)';
  }

  @override
  bool operator ==(covariant SchoolHomePage other) {
    if (identical(this, other)) return true;

    return other.totalElements == totalElements &&
        other.totalPages == totalPages &&
        other.size == size &&
        listEquals(other.content, content) &&
        other.number == number &&
        other.first == first &&
        other.last == last &&
        other.numberOfElements == numberOfElements &&
        other.sort == sort &&
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
        first.hashCode ^
        last.hashCode ^
        numberOfElements.hashCode ^
        sort.hashCode ^
        pageable.hashCode ^
        empty.hashCode;
  }
}

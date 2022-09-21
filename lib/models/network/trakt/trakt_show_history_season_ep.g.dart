// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trakt_show_history_season_ep.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const TraktShowHistorySeasonEpSchema = Schema(
  name: r'TraktShowHistorySeasonEp',
  id: 7095503552618439335,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'lastWatchedAt': PropertySchema(
      id: 1,
      name: r'lastWatchedAt',
      type: IsarType.string,
    ),
    r'number': PropertySchema(
      id: 2,
      name: r'number',
      type: IsarType.long,
    ),
    r'plays': PropertySchema(
      id: 3,
      name: r'plays',
      type: IsarType.long,
    )
  },
  estimateSize: _traktShowHistorySeasonEpEstimateSize,
  serialize: _traktShowHistorySeasonEpSerialize,
  deserialize: _traktShowHistorySeasonEpDeserialize,
  deserializeProp: _traktShowHistorySeasonEpDeserializeProp,
);

int _traktShowHistorySeasonEpEstimateSize(
  TraktShowHistorySeasonEp object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lastWatchedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _traktShowHistorySeasonEpSerialize(
  TraktShowHistorySeasonEp object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeString(offsets[1], object.lastWatchedAt);
  writer.writeLong(offsets[2], object.number);
  writer.writeLong(offsets[3], object.plays);
}

TraktShowHistorySeasonEp _traktShowHistorySeasonEpDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TraktShowHistorySeasonEp(
    lastWatchedAt: reader.readStringOrNull(offsets[1]),
    number: reader.readLongOrNull(offsets[2]),
    plays: reader.readLongOrNull(offsets[3]),
  );
  return object;
}

P _traktShowHistorySeasonEpDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TraktShowHistorySeasonEpQueryFilter on QueryBuilder<
    TraktShowHistorySeasonEp, TraktShowHistorySeasonEp, QFilterCondition> {
  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastWatchedAt',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastWatchedAt',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastWatchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastWatchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastWatchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastWatchedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastWatchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastWatchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
          QAfterFilterCondition>
      lastWatchedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastWatchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
          QAfterFilterCondition>
      lastWatchedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastWatchedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastWatchedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> lastWatchedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastWatchedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> numberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'number',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> numberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'number',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> numberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> numberGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> numberLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> numberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> playsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'plays',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> playsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'plays',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> playsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plays',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> playsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plays',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> playsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plays',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeasonEp, TraktShowHistorySeasonEp,
      QAfterFilterCondition> playsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TraktShowHistorySeasonEpQueryObject on QueryBuilder<
    TraktShowHistorySeasonEp, TraktShowHistorySeasonEp, QFilterCondition> {}

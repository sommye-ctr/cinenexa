// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trakt_show_history_season.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TraktShowHistorySeasonSchema = Schema(
  name: r'TraktShowHistorySeason',
  id: -3499843668320740779,
  properties: {
    r'episodes': PropertySchema(
      id: 0,
      name: r'episodes',
      type: IsarType.objectList,
      target: r'TraktShowHistorySeasonEp',
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'number': PropertySchema(
      id: 2,
      name: r'number',
      type: IsarType.long,
    )
  },
  estimateSize: _traktShowHistorySeasonEstimateSize,
  serialize: _traktShowHistorySeasonSerialize,
  deserialize: _traktShowHistorySeasonDeserialize,
  deserializeProp: _traktShowHistorySeasonDeserializeProp,
);

int _traktShowHistorySeasonEstimateSize(
  TraktShowHistorySeason object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.episodes;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[TraktShowHistorySeasonEp]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += TraktShowHistorySeasonEpSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _traktShowHistorySeasonSerialize(
  TraktShowHistorySeason object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<TraktShowHistorySeasonEp>(
    offsets[0],
    allOffsets,
    TraktShowHistorySeasonEpSchema.serialize,
    object.episodes,
  );
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeLong(offsets[2], object.number);
}

TraktShowHistorySeason _traktShowHistorySeasonDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TraktShowHistorySeason(
    episodes: reader.readObjectList<TraktShowHistorySeasonEp>(
      offsets[0],
      TraktShowHistorySeasonEpSchema.deserialize,
      allOffsets,
      TraktShowHistorySeasonEp(),
    ),
    number: reader.readLongOrNull(offsets[2]),
  );
  return object;
}

P _traktShowHistorySeasonDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<TraktShowHistorySeasonEp>(
        offset,
        TraktShowHistorySeasonEpSchema.deserialize,
        allOffsets,
        TraktShowHistorySeasonEp(),
      )) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TraktShowHistorySeasonQueryFilter on QueryBuilder<
    TraktShowHistorySeason, TraktShowHistorySeason, QFilterCondition> {
  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> episodesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'episodes',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> episodesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'episodes',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> episodesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> episodesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> episodesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> episodesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> episodesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> episodesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
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

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
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

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
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

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> numberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'number',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> numberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'number',
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
      QAfterFilterCondition> numberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
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

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
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

  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
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
}

extension TraktShowHistorySeasonQueryObject on QueryBuilder<
    TraktShowHistorySeason, TraktShowHistorySeason, QFilterCondition> {
  QueryBuilder<TraktShowHistorySeason, TraktShowHistorySeason,
          QAfterFilterCondition>
      episodesElement(FilterQuery<TraktShowHistorySeasonEp> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'episodes');
    });
  }
}

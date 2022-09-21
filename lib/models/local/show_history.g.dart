// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetShowHistoryCollection on Isar {
  IsarCollection<ShowHistory> get showHistorys => this.collection();
}

const ShowHistorySchema = CollectionSchema(
  name: r'ShowHistory',
  id: -4118309659678317111,
  properties: {
    r'lastUpdatedAt': PropertySchema(
      id: 0,
      name: r'lastUpdatedAt',
      type: IsarType.dateTime,
    ),
    r'seasons': PropertySchema(
      id: 1,
      name: r'seasons',
      type: IsarType.objectList,
      target: r'TraktShowHistorySeason',
    ),
    r'show': PropertySchema(
      id: 2,
      name: r'show',
      type: IsarType.object,
      target: r'Tv',
    )
  },
  estimateSize: _showHistoryEstimateSize,
  serialize: _showHistorySerialize,
  deserialize: _showHistoryDeserialize,
  deserializeProp: _showHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'Tv': TvSchema,
    r'Genre': GenreSchema,
    r'TvSeason': TvSeasonSchema,
    r'TraktShowHistorySeason': TraktShowHistorySeasonSchema,
    r'TraktShowHistorySeasonEp': TraktShowHistorySeasonEpSchema
  },
  getId: _showHistoryGetId,
  getLinks: _showHistoryGetLinks,
  attach: _showHistoryAttach,
  version: '3.0.0',
);

int _showHistoryEstimateSize(
  ShowHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.seasons;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[TraktShowHistorySeason]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += TraktShowHistorySeasonSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.show;
    if (value != null) {
      bytesCount +=
          3 + TvSchema.estimateSize(value, allOffsets[Tv]!, allOffsets);
    }
  }
  return bytesCount;
}

void _showHistorySerialize(
  ShowHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastUpdatedAt);
  writer.writeObjectList<TraktShowHistorySeason>(
    offsets[1],
    allOffsets,
    TraktShowHistorySeasonSchema.serialize,
    object.seasons,
  );
  writer.writeObject<Tv>(
    offsets[2],
    allOffsets,
    TvSchema.serialize,
    object.show,
  );
}

ShowHistory _showHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShowHistory();
  object.id = id;
  object.lastUpdatedAt = reader.readDateTimeOrNull(offsets[0]);
  object.seasons = reader.readObjectList<TraktShowHistorySeason>(
    offsets[1],
    TraktShowHistorySeasonSchema.deserialize,
    allOffsets,
    TraktShowHistorySeason(),
  );
  object.show = reader.readObjectOrNull<Tv>(
    offsets[2],
    TvSchema.deserialize,
    allOffsets,
  );
  return object;
}

P _showHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<TraktShowHistorySeason>(
        offset,
        TraktShowHistorySeasonSchema.deserialize,
        allOffsets,
        TraktShowHistorySeason(),
      )) as P;
    case 2:
      return (reader.readObjectOrNull<Tv>(
        offset,
        TvSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _showHistoryGetId(ShowHistory object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _showHistoryGetLinks(ShowHistory object) {
  return [];
}

void _showHistoryAttach(
    IsarCollection<dynamic> col, Id id, ShowHistory object) {
  object.id = id;
}

extension ShowHistoryQueryWhereSort
    on QueryBuilder<ShowHistory, ShowHistory, QWhere> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ShowHistoryQueryWhere
    on QueryBuilder<ShowHistory, ShowHistory, QWhereClause> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ShowHistoryQueryFilter
    on QueryBuilder<ShowHistory, ShowHistory, QFilterCondition> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUpdatedAt',
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUpdatedAt',
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      seasonsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'seasons',
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      seasonsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'seasons',
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      seasonsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'seasons',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      seasonsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'seasons',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      seasonsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'seasons',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      seasonsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'seasons',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      seasonsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'seasons',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      seasonsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'seasons',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'show',
      ));
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      showIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'show',
      ));
    });
  }
}

extension ShowHistoryQueryObject
    on QueryBuilder<ShowHistory, ShowHistory, QFilterCondition> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> seasonsElement(
      FilterQuery<TraktShowHistorySeason> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'seasons');
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> show(
      FilterQuery<Tv> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'show');
    });
  }
}

extension ShowHistoryQueryLinks
    on QueryBuilder<ShowHistory, ShowHistory, QFilterCondition> {}

extension ShowHistoryQuerySortBy
    on QueryBuilder<ShowHistory, ShowHistory, QSortBy> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> sortByLastUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy>
      sortByLastUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.desc);
    });
  }
}

extension ShowHistoryQuerySortThenBy
    on QueryBuilder<ShowHistory, ShowHistory, QSortThenBy> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> thenByLastUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy>
      thenByLastUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.desc);
    });
  }
}

extension ShowHistoryQueryWhereDistinct
    on QueryBuilder<ShowHistory, ShowHistory, QDistinct> {
  QueryBuilder<ShowHistory, ShowHistory, QDistinct> distinctByLastUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdatedAt');
    });
  }
}

extension ShowHistoryQueryProperty
    on QueryBuilder<ShowHistory, ShowHistory, QQueryProperty> {
  QueryBuilder<ShowHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShowHistory, DateTime?, QQueryOperations>
      lastUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdatedAt');
    });
  }

  QueryBuilder<ShowHistory, List<TraktShowHistorySeason>?, QQueryOperations>
      seasonsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seasons');
    });
  }

  QueryBuilder<ShowHistory, Tv?, QQueryOperations> showProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'show');
    });
  }
}

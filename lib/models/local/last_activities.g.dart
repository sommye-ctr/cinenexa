// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_activities.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetLastActivitiesCollection on Isar {
  IsarCollection<LastActivities> get lastActivities => this.collection();
}

const LastActivitiesSchema = CollectionSchema(
  name: r'LastActivities',
  id: 4536739859605176589,
  properties: {
    r'epCollectedAt': PropertySchema(
      id: 0,
      name: r'epCollectedAt',
      type: IsarType.dateTime,
    ),
    r'epWatchedAt': PropertySchema(
      id: 1,
      name: r'epWatchedAt',
      type: IsarType.dateTime,
    ),
    r'movieCollectedAt': PropertySchema(
      id: 2,
      name: r'movieCollectedAt',
      type: IsarType.dateTime,
    ),
    r'movieWatchedAt': PropertySchema(
      id: 3,
      name: r'movieWatchedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _lastActivitiesEstimateSize,
  serialize: _lastActivitiesSerialize,
  deserialize: _lastActivitiesDeserialize,
  deserializeProp: _lastActivitiesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _lastActivitiesGetId,
  getLinks: _lastActivitiesGetLinks,
  attach: _lastActivitiesAttach,
  version: '3.0.0',
);

int _lastActivitiesEstimateSize(
  LastActivities object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _lastActivitiesSerialize(
  LastActivities object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.epCollectedAt);
  writer.writeDateTime(offsets[1], object.epWatchedAt);
  writer.writeDateTime(offsets[2], object.movieCollectedAt);
  writer.writeDateTime(offsets[3], object.movieWatchedAt);
}

LastActivities _lastActivitiesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LastActivities();
  object.epCollectedAt = reader.readDateTime(offsets[0]);
  object.epWatchedAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.movieCollectedAt = reader.readDateTime(offsets[2]);
  object.movieWatchedAt = reader.readDateTime(offsets[3]);
  return object;
}

P _lastActivitiesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _lastActivitiesGetId(LastActivities object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _lastActivitiesGetLinks(LastActivities object) {
  return [];
}

void _lastActivitiesAttach(
    IsarCollection<dynamic> col, Id id, LastActivities object) {
  object.id = id;
}

extension LastActivitiesQueryWhereSort
    on QueryBuilder<LastActivities, LastActivities, QWhere> {
  QueryBuilder<LastActivities, LastActivities, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LastActivitiesQueryWhere
    on QueryBuilder<LastActivities, LastActivities, QWhereClause> {
  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idBetween(
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

extension LastActivitiesQueryFilter
    on QueryBuilder<LastActivities, LastActivities, QFilterCondition> {
  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epCollectedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'epCollectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epCollectedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'epCollectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epCollectedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'epCollectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epCollectedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'epCollectedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epWatchedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'epWatchedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epWatchedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'epWatchedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epWatchedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'epWatchedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epWatchedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'epWatchedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieCollectedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'movieCollectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieCollectedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'movieCollectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieCollectedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'movieCollectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieCollectedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'movieCollectedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieWatchedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'movieWatchedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieWatchedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'movieWatchedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieWatchedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'movieWatchedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieWatchedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'movieWatchedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LastActivitiesQueryObject
    on QueryBuilder<LastActivities, LastActivities, QFilterCondition> {}

extension LastActivitiesQueryLinks
    on QueryBuilder<LastActivities, LastActivities, QFilterCondition> {}

extension LastActivitiesQuerySortBy
    on QueryBuilder<LastActivities, LastActivities, QSortBy> {
  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByEpCollectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epCollectedAt', Sort.asc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByEpCollectedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epCollectedAt', Sort.desc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByEpWatchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epWatchedAt', Sort.asc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByEpWatchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epWatchedAt', Sort.desc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByMovieCollectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieCollectedAt', Sort.asc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByMovieCollectedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieCollectedAt', Sort.desc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByMovieWatchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieWatchedAt', Sort.asc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByMovieWatchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieWatchedAt', Sort.desc);
    });
  }
}

extension LastActivitiesQuerySortThenBy
    on QueryBuilder<LastActivities, LastActivities, QSortThenBy> {
  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByEpCollectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epCollectedAt', Sort.asc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByEpCollectedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epCollectedAt', Sort.desc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByEpWatchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epWatchedAt', Sort.asc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByEpWatchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epWatchedAt', Sort.desc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByMovieCollectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieCollectedAt', Sort.asc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByMovieCollectedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieCollectedAt', Sort.desc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByMovieWatchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieWatchedAt', Sort.asc);
    });
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByMovieWatchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieWatchedAt', Sort.desc);
    });
  }
}

extension LastActivitiesQueryWhereDistinct
    on QueryBuilder<LastActivities, LastActivities, QDistinct> {
  QueryBuilder<LastActivities, LastActivities, QDistinct>
      distinctByEpCollectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'epCollectedAt');
    });
  }

  QueryBuilder<LastActivities, LastActivities, QDistinct>
      distinctByEpWatchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'epWatchedAt');
    });
  }

  QueryBuilder<LastActivities, LastActivities, QDistinct>
      distinctByMovieCollectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'movieCollectedAt');
    });
  }

  QueryBuilder<LastActivities, LastActivities, QDistinct>
      distinctByMovieWatchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'movieWatchedAt');
    });
  }
}

extension LastActivitiesQueryProperty
    on QueryBuilder<LastActivities, LastActivities, QQueryProperty> {
  QueryBuilder<LastActivities, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LastActivities, DateTime, QQueryOperations>
      epCollectedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'epCollectedAt');
    });
  }

  QueryBuilder<LastActivities, DateTime, QQueryOperations>
      epWatchedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'epWatchedAt');
    });
  }

  QueryBuilder<LastActivities, DateTime, QQueryOperations>
      movieCollectedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieCollectedAt');
    });
  }

  QueryBuilder<LastActivities, DateTime, QQueryOperations>
      movieWatchedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieWatchedAt');
    });
  }
}

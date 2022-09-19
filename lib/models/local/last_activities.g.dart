// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_activities.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetLastActivitiesCollection on Isar {
  IsarCollection<LastActivities> get lastActivitiess => getCollection();
}

const LastActivitiesSchema = CollectionSchema(
  name: 'LastActivities',
  schema:
      '{"name":"LastActivities","idName":"id","properties":[{"name":"epCollectedAt","type":"Long"},{"name":"epWatchedAt","type":"Long"},{"name":"movieCollectedAt","type":"Long"},{"name":"movieWatchedAt","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'epCollectedAt': 0,
    'epWatchedAt': 1,
    'movieCollectedAt': 2,
    'movieWatchedAt': 3
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _lastActivitiesGetId,
  setId: _lastActivitiesSetId,
  getLinks: _lastActivitiesGetLinks,
  attachLinks: _lastActivitiesAttachLinks,
  serializeNative: _lastActivitiesSerializeNative,
  deserializeNative: _lastActivitiesDeserializeNative,
  deserializePropNative: _lastActivitiesDeserializePropNative,
  serializeWeb: _lastActivitiesSerializeWeb,
  deserializeWeb: _lastActivitiesDeserializeWeb,
  deserializePropWeb: _lastActivitiesDeserializePropWeb,
  version: 3,
);

int? _lastActivitiesGetId(LastActivities object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _lastActivitiesSetId(LastActivities object, int id) {
  object.id = id;
}

List<IsarLinkBase> _lastActivitiesGetLinks(LastActivities object) {
  return [];
}

void _lastActivitiesSerializeNative(
    IsarCollection<LastActivities> collection,
    IsarRawObject rawObj,
    LastActivities object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.epCollectedAt;
  final _epCollectedAt = value0;
  final value1 = object.epWatchedAt;
  final _epWatchedAt = value1;
  final value2 = object.movieCollectedAt;
  final _movieCollectedAt = value2;
  final value3 = object.movieWatchedAt;
  final _movieWatchedAt = value3;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDateTime(offsets[0], _epCollectedAt);
  writer.writeDateTime(offsets[1], _epWatchedAt);
  writer.writeDateTime(offsets[2], _movieCollectedAt);
  writer.writeDateTime(offsets[3], _movieWatchedAt);
}

LastActivities _lastActivitiesDeserializeNative(
    IsarCollection<LastActivities> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = LastActivities();
  object.epCollectedAt = reader.readDateTime(offsets[0]);
  object.epWatchedAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.movieCollectedAt = reader.readDateTime(offsets[2]);
  object.movieWatchedAt = reader.readDateTime(offsets[3]);
  return object;
}

P _lastActivitiesDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _lastActivitiesSerializeWeb(
    IsarCollection<LastActivities> collection, LastActivities object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'epCollectedAt',
      object.epCollectedAt.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(
      jsObj, 'epWatchedAt', object.epWatchedAt.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'movieCollectedAt',
      object.movieCollectedAt.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'movieWatchedAt',
      object.movieWatchedAt.toUtc().millisecondsSinceEpoch);
  return jsObj;
}

LastActivities _lastActivitiesDeserializeWeb(
    IsarCollection<LastActivities> collection, dynamic jsObj) {
  final object = LastActivities();
  object.epCollectedAt = IsarNative.jsObjectGet(jsObj, 'epCollectedAt') != null
      ? DateTime.fromMillisecondsSinceEpoch(
              IsarNative.jsObjectGet(jsObj, 'epCollectedAt'),
              isUtc: true)
          .toLocal()
      : DateTime.fromMillisecondsSinceEpoch(0);
  object.epWatchedAt = IsarNative.jsObjectGet(jsObj, 'epWatchedAt') != null
      ? DateTime.fromMillisecondsSinceEpoch(
              IsarNative.jsObjectGet(jsObj, 'epWatchedAt'),
              isUtc: true)
          .toLocal()
      : DateTime.fromMillisecondsSinceEpoch(0);
  object.id = IsarNative.jsObjectGet(jsObj, 'id');
  object.movieCollectedAt =
      IsarNative.jsObjectGet(jsObj, 'movieCollectedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'movieCollectedAt'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0);
  object.movieWatchedAt =
      IsarNative.jsObjectGet(jsObj, 'movieWatchedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'movieWatchedAt'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0);
  return object;
}

P _lastActivitiesDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'epCollectedAt':
      return (IsarNative.jsObjectGet(jsObj, 'epCollectedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'epCollectedAt'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    case 'epWatchedAt':
      return (IsarNative.jsObjectGet(jsObj, 'epWatchedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'epWatchedAt'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
    case 'movieCollectedAt':
      return (IsarNative.jsObjectGet(jsObj, 'movieCollectedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'movieCollectedAt'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    case 'movieWatchedAt':
      return (IsarNative.jsObjectGet(jsObj, 'movieWatchedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'movieWatchedAt'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _lastActivitiesAttachLinks(
    IsarCollection col, int id, LastActivities object) {}

extension LastActivitiesQueryWhereSort
    on QueryBuilder<LastActivities, LastActivities, QWhere> {
  QueryBuilder<LastActivities, LastActivities, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension LastActivitiesQueryWhere
    on QueryBuilder<LastActivities, LastActivities, QWhereClause> {
  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idNotEqualTo(
      int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<LastActivities, LastActivities, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension LastActivitiesQueryFilter
    on QueryBuilder<LastActivities, LastActivities, QFilterCondition> {
  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epCollectedAtEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'epCollectedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epCollectedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'epCollectedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epCollectedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'epCollectedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epCollectedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'epCollectedAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epWatchedAtEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'epWatchedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epWatchedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'epWatchedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epWatchedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'epWatchedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      epWatchedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'epWatchedAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieCollectedAtEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'movieCollectedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieCollectedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'movieCollectedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieCollectedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'movieCollectedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieCollectedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'movieCollectedAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieWatchedAtEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'movieWatchedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieWatchedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'movieWatchedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieWatchedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'movieWatchedAt',
      value: value,
    ));
  }

  QueryBuilder<LastActivities, LastActivities, QAfterFilterCondition>
      movieWatchedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'movieWatchedAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension LastActivitiesQueryLinks
    on QueryBuilder<LastActivities, LastActivities, QFilterCondition> {}

extension LastActivitiesQueryWhereSortBy
    on QueryBuilder<LastActivities, LastActivities, QSortBy> {
  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByEpCollectedAt() {
    return addSortByInternal('epCollectedAt', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByEpCollectedAtDesc() {
    return addSortByInternal('epCollectedAt', Sort.desc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByEpWatchedAt() {
    return addSortByInternal('epWatchedAt', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByEpWatchedAtDesc() {
    return addSortByInternal('epWatchedAt', Sort.desc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByMovieCollectedAt() {
    return addSortByInternal('movieCollectedAt', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByMovieCollectedAtDesc() {
    return addSortByInternal('movieCollectedAt', Sort.desc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByMovieWatchedAt() {
    return addSortByInternal('movieWatchedAt', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      sortByMovieWatchedAtDesc() {
    return addSortByInternal('movieWatchedAt', Sort.desc);
  }
}

extension LastActivitiesQueryWhereSortThenBy
    on QueryBuilder<LastActivities, LastActivities, QSortThenBy> {
  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByEpCollectedAt() {
    return addSortByInternal('epCollectedAt', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByEpCollectedAtDesc() {
    return addSortByInternal('epCollectedAt', Sort.desc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByEpWatchedAt() {
    return addSortByInternal('epWatchedAt', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByEpWatchedAtDesc() {
    return addSortByInternal('epWatchedAt', Sort.desc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByMovieCollectedAt() {
    return addSortByInternal('movieCollectedAt', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByMovieCollectedAtDesc() {
    return addSortByInternal('movieCollectedAt', Sort.desc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByMovieWatchedAt() {
    return addSortByInternal('movieWatchedAt', Sort.asc);
  }

  QueryBuilder<LastActivities, LastActivities, QAfterSortBy>
      thenByMovieWatchedAtDesc() {
    return addSortByInternal('movieWatchedAt', Sort.desc);
  }
}

extension LastActivitiesQueryWhereDistinct
    on QueryBuilder<LastActivities, LastActivities, QDistinct> {
  QueryBuilder<LastActivities, LastActivities, QDistinct>
      distinctByEpCollectedAt() {
    return addDistinctByInternal('epCollectedAt');
  }

  QueryBuilder<LastActivities, LastActivities, QDistinct>
      distinctByEpWatchedAt() {
    return addDistinctByInternal('epWatchedAt');
  }

  QueryBuilder<LastActivities, LastActivities, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<LastActivities, LastActivities, QDistinct>
      distinctByMovieCollectedAt() {
    return addDistinctByInternal('movieCollectedAt');
  }

  QueryBuilder<LastActivities, LastActivities, QDistinct>
      distinctByMovieWatchedAt() {
    return addDistinctByInternal('movieWatchedAt');
  }
}

extension LastActivitiesQueryProperty
    on QueryBuilder<LastActivities, LastActivities, QQueryProperty> {
  QueryBuilder<LastActivities, DateTime, QQueryOperations>
      epCollectedAtProperty() {
    return addPropertyNameInternal('epCollectedAt');
  }

  QueryBuilder<LastActivities, DateTime, QQueryOperations>
      epWatchedAtProperty() {
    return addPropertyNameInternal('epWatchedAt');
  }

  QueryBuilder<LastActivities, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<LastActivities, DateTime, QQueryOperations>
      movieCollectedAtProperty() {
    return addPropertyNameInternal('movieCollectedAt');
  }

  QueryBuilder<LastActivities, DateTime, QQueryOperations>
      movieWatchedAtProperty() {
    return addPropertyNameInternal('movieWatchedAt');
  }
}

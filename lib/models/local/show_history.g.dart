// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetShowHistoryCollection on Isar {
  IsarCollection<ShowHistory> get showHistorys => getCollection();
}

const ShowHistorySchema = CollectionSchema(
  name: 'ShowHistory',
  schema:
      '{"name":"ShowHistory","idName":"id","properties":[{"name":"lastUpdatedAt","type":"Long"},{"name":"show","type":"String"}],"indexes":[{"name":"lastUpdatedAt","unique":false,"properties":[{"name":"lastUpdatedAt","type":"Value","caseSensitive":false}]}],"links":[{"name":"seasons","target":"ShowHistorySeason"}]}',
  idName: 'id',
  propertyIds: {'lastUpdatedAt': 0, 'show': 1},
  listProperties: {},
  indexIds: {'lastUpdatedAt': 0},
  indexValueTypes: {
    'lastUpdatedAt': [
      IndexValueType.long,
    ]
  },
  linkIds: {'seasons': 0},
  backlinkLinkNames: {},
  getId: _showHistoryGetId,
  setId: _showHistorySetId,
  getLinks: _showHistoryGetLinks,
  attachLinks: _showHistoryAttachLinks,
  serializeNative: _showHistorySerializeNative,
  deserializeNative: _showHistoryDeserializeNative,
  deserializePropNative: _showHistoryDeserializePropNative,
  serializeWeb: _showHistorySerializeWeb,
  deserializeWeb: _showHistoryDeserializeWeb,
  deserializePropWeb: _showHistoryDeserializePropWeb,
  version: 3,
);

int? _showHistoryGetId(ShowHistory object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _showHistorySetId(ShowHistory object, int id) {
  object.id = id;
}

List<IsarLinkBase> _showHistoryGetLinks(ShowHistory object) {
  return [object.seasons];
}

const _showHistoryShowTypeConverter = ShowTypeConverter();

void _showHistorySerializeNative(
    IsarCollection<ShowHistory> collection,
    IsarRawObject rawObj,
    ShowHistory object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.lastUpdatedAt;
  final _lastUpdatedAt = value0;
  final value1 = _showHistoryShowTypeConverter.toIsar(object.show);
  IsarUint8List? _show;
  if (value1 != null) {
    _show = IsarBinaryWriter.utf8Encoder.convert(value1);
  }
  dynamicSize += (_show?.length ?? 0) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDateTime(offsets[0], _lastUpdatedAt);
  writer.writeBytes(offsets[1], _show);
}

ShowHistory _showHistoryDeserializeNative(
    IsarCollection<ShowHistory> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ShowHistory();
  object.id = id;
  object.lastUpdatedAt = reader.readDateTimeOrNull(offsets[0]);
  object.show = _showHistoryShowTypeConverter
      .fromIsar(reader.readStringOrNull(offsets[1]));
  _showHistoryAttachLinks(collection, id, object);
  return object;
}

P _showHistoryDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (_showHistoryShowTypeConverter
          .fromIsar(reader.readStringOrNull(offset))) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _showHistorySerializeWeb(
    IsarCollection<ShowHistory> collection, ShowHistory object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'lastUpdatedAt',
      object.lastUpdatedAt?.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(
      jsObj, 'show', _showHistoryShowTypeConverter.toIsar(object.show));
  return jsObj;
}

ShowHistory _showHistoryDeserializeWeb(
    IsarCollection<ShowHistory> collection, dynamic jsObj) {
  final object = ShowHistory();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.lastUpdatedAt = IsarNative.jsObjectGet(jsObj, 'lastUpdatedAt') != null
      ? DateTime.fromMillisecondsSinceEpoch(
              IsarNative.jsObjectGet(jsObj, 'lastUpdatedAt'),
              isUtc: true)
          .toLocal()
      : null;
  object.show = _showHistoryShowTypeConverter
      .fromIsar(IsarNative.jsObjectGet(jsObj, 'show'));
  _showHistoryAttachLinks(collection,
      IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity, object);
  return object;
}

P _showHistoryDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'lastUpdatedAt':
      return (IsarNative.jsObjectGet(jsObj, 'lastUpdatedAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'lastUpdatedAt'),
                  isUtc: true)
              .toLocal()
          : null) as P;
    case 'show':
      return (_showHistoryShowTypeConverter
          .fromIsar(IsarNative.jsObjectGet(jsObj, 'show'))) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _showHistoryAttachLinks(IsarCollection col, int id, ShowHistory object) {
  object.seasons.attach(col, col.isar.showHistorySeasons, 'seasons', id);
}

extension ShowHistoryQueryWhereSort
    on QueryBuilder<ShowHistory, ShowHistory, QWhere> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhere> anyLastUpdatedAt() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'lastUpdatedAt'));
  }
}

extension ShowHistoryQueryWhere
    on QueryBuilder<ShowHistory, ShowHistory, QWhereClause> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause> idBetween(
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

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause>
      lastUpdatedAtEqualTo(DateTime? lastUpdatedAt) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'lastUpdatedAt',
      value: [lastUpdatedAt],
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause>
      lastUpdatedAtNotEqualTo(DateTime? lastUpdatedAt) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'lastUpdatedAt',
        upper: [lastUpdatedAt],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'lastUpdatedAt',
        lower: [lastUpdatedAt],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'lastUpdatedAt',
        lower: [lastUpdatedAt],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'lastUpdatedAt',
        upper: [lastUpdatedAt],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause>
      lastUpdatedAtIsNull() {
    return addWhereClauseInternal(const IndexWhereClause.equalTo(
      indexName: 'lastUpdatedAt',
      value: [null],
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause>
      lastUpdatedAtIsNotNull() {
    return addWhereClauseInternal(const IndexWhereClause.greaterThan(
      indexName: 'lastUpdatedAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause>
      lastUpdatedAtGreaterThan(
    DateTime? lastUpdatedAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'lastUpdatedAt',
      lower: [lastUpdatedAt],
      includeLower: include,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause>
      lastUpdatedAtLessThan(
    DateTime? lastUpdatedAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'lastUpdatedAt',
      upper: [lastUpdatedAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterWhereClause>
      lastUpdatedAtBetween(
    DateTime? lowerLastUpdatedAt,
    DateTime? upperLastUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'lastUpdatedAt',
      lower: [lowerLastUpdatedAt],
      includeLower: includeLower,
      upper: [upperLastUpdatedAt],
      includeUpper: includeUpper,
    ));
  }
}

extension ShowHistoryQueryFilter
    on QueryBuilder<ShowHistory, ShowHistory, QFilterCondition> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'lastUpdatedAt',
      value: null,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'lastUpdatedAt',
      value: value,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'lastUpdatedAt',
      value: value,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'lastUpdatedAt',
      value: value,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition>
      lastUpdatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'lastUpdatedAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'show',
      value: null,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showEqualTo(
    Tv? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'show',
      value: _showHistoryShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showGreaterThan(
    Tv? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'show',
      value: _showHistoryShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showLessThan(
    Tv? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'show',
      value: _showHistoryShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showBetween(
    Tv? lower,
    Tv? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'show',
      lower: _showHistoryShowTypeConverter.toIsar(lower),
      includeLower: includeLower,
      upper: _showHistoryShowTypeConverter.toIsar(upper),
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showStartsWith(
    Tv value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'show',
      value: _showHistoryShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showEndsWith(
    Tv value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'show',
      value: _showHistoryShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showContains(
      Tv value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'show',
      value: _showHistoryShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> showMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'show',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ShowHistoryQueryLinks
    on QueryBuilder<ShowHistory, ShowHistory, QFilterCondition> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterFilterCondition> seasons(
      FilterQuery<ShowHistorySeason> q) {
    return linkInternal(
      isar.showHistorySeasons,
      q,
      'seasons',
    );
  }
}

extension ShowHistoryQueryWhereSortBy
    on QueryBuilder<ShowHistory, ShowHistory, QSortBy> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> sortByLastUpdatedAt() {
    return addSortByInternal('lastUpdatedAt', Sort.asc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy>
      sortByLastUpdatedAtDesc() {
    return addSortByInternal('lastUpdatedAt', Sort.desc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> sortByShow() {
    return addSortByInternal('show', Sort.asc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> sortByShowDesc() {
    return addSortByInternal('show', Sort.desc);
  }
}

extension ShowHistoryQueryWhereSortThenBy
    on QueryBuilder<ShowHistory, ShowHistory, QSortThenBy> {
  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> thenByLastUpdatedAt() {
    return addSortByInternal('lastUpdatedAt', Sort.asc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy>
      thenByLastUpdatedAtDesc() {
    return addSortByInternal('lastUpdatedAt', Sort.desc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> thenByShow() {
    return addSortByInternal('show', Sort.asc);
  }

  QueryBuilder<ShowHistory, ShowHistory, QAfterSortBy> thenByShowDesc() {
    return addSortByInternal('show', Sort.desc);
  }
}

extension ShowHistoryQueryWhereDistinct
    on QueryBuilder<ShowHistory, ShowHistory, QDistinct> {
  QueryBuilder<ShowHistory, ShowHistory, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ShowHistory, ShowHistory, QDistinct> distinctByLastUpdatedAt() {
    return addDistinctByInternal('lastUpdatedAt');
  }

  QueryBuilder<ShowHistory, ShowHistory, QDistinct> distinctByShow(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('show', caseSensitive: caseSensitive);
  }
}

extension ShowHistoryQueryProperty
    on QueryBuilder<ShowHistory, ShowHistory, QQueryProperty> {
  QueryBuilder<ShowHistory, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ShowHistory, DateTime?, QQueryOperations>
      lastUpdatedAtProperty() {
    return addPropertyNameInternal('lastUpdatedAt');
  }

  QueryBuilder<ShowHistory, Tv?, QQueryOperations> showProperty() {
    return addPropertyNameInternal('show');
  }
}

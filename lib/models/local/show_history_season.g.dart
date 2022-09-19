// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_history_season.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetShowHistorySeasonCollection on Isar {
  IsarCollection<ShowHistorySeason> get showHistorySeasons => getCollection();
}

const ShowHistorySeasonSchema = CollectionSchema(
  name: 'ShowHistorySeason',
  schema:
      '{"name":"ShowHistorySeason","idName":"id","properties":[{"name":"episodes","type":"String"},{"name":"number","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'episodes': 0, 'number': 1},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _showHistorySeasonGetId,
  setId: _showHistorySeasonSetId,
  getLinks: _showHistorySeasonGetLinks,
  attachLinks: _showHistorySeasonAttachLinks,
  serializeNative: _showHistorySeasonSerializeNative,
  deserializeNative: _showHistorySeasonDeserializeNative,
  deserializePropNative: _showHistorySeasonDeserializePropNative,
  serializeWeb: _showHistorySeasonSerializeWeb,
  deserializeWeb: _showHistorySeasonDeserializeWeb,
  deserializePropWeb: _showHistorySeasonDeserializePropWeb,
  version: 3,
);

int? _showHistorySeasonGetId(ShowHistorySeason object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _showHistorySeasonSetId(ShowHistorySeason object, int id) {
  object.id = id;
}

List<IsarLinkBase> _showHistorySeasonGetLinks(ShowHistorySeason object) {
  return [];
}

const _showHistorySeasonTraktHistoryEpisodeConverter =
    TraktHistoryEpisodeConverter();

void _showHistorySeasonSerializeNative(
    IsarCollection<ShowHistorySeason> collection,
    IsarRawObject rawObj,
    ShowHistorySeason object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 =
      _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(object.episodes);
  final _episodes = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_episodes.length) as int;
  final value1 = object.number;
  final _number = value1;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _episodes);
  writer.writeLong(offsets[1], _number);
}

ShowHistorySeason _showHistorySeasonDeserializeNative(
    IsarCollection<ShowHistorySeason> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ShowHistorySeason();
  object.episodes = _showHistorySeasonTraktHistoryEpisodeConverter
      .fromIsar(reader.readString(offsets[0]));
  object.id = id;
  object.number = reader.readLong(offsets[1]);
  return object;
}

P _showHistorySeasonDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (_showHistorySeasonTraktHistoryEpisodeConverter
          .fromIsar(reader.readString(offset))) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _showHistorySeasonSerializeWeb(
    IsarCollection<ShowHistorySeason> collection, ShowHistorySeason object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'episodes',
      _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(object.episodes));
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'number', object.number);
  return jsObj;
}

ShowHistorySeason _showHistorySeasonDeserializeWeb(
    IsarCollection<ShowHistorySeason> collection, dynamic jsObj) {
  final object = ShowHistorySeason();
  object.episodes = _showHistorySeasonTraktHistoryEpisodeConverter
      .fromIsar(IsarNative.jsObjectGet(jsObj, 'episodes') ?? '');
  object.id = IsarNative.jsObjectGet(jsObj, 'id');
  object.number =
      IsarNative.jsObjectGet(jsObj, 'number') ?? double.negativeInfinity;
  return object;
}

P _showHistorySeasonDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'episodes':
      return (_showHistorySeasonTraktHistoryEpisodeConverter
          .fromIsar(IsarNative.jsObjectGet(jsObj, 'episodes') ?? '')) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
    case 'number':
      return (IsarNative.jsObjectGet(jsObj, 'number') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _showHistorySeasonAttachLinks(
    IsarCollection col, int id, ShowHistorySeason object) {}

extension ShowHistorySeasonQueryWhereSort
    on QueryBuilder<ShowHistorySeason, ShowHistorySeason, QWhere> {
  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ShowHistorySeasonQueryWhere
    on QueryBuilder<ShowHistorySeason, ShowHistorySeason, QWhereClause> {
  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterWhereClause>
      idNotEqualTo(int id) {
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

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterWhereClause>
      idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterWhereClause>
      idBetween(
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

extension ShowHistorySeasonQueryFilter
    on QueryBuilder<ShowHistorySeason, ShowHistorySeason, QFilterCondition> {
  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      episodesEqualTo(
    List<TraktHistoryEpisode> value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'episodes',
      value: _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      episodesGreaterThan(
    List<TraktHistoryEpisode> value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'episodes',
      value: _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      episodesLessThan(
    List<TraktHistoryEpisode> value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'episodes',
      value: _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      episodesBetween(
    List<TraktHistoryEpisode> lower,
    List<TraktHistoryEpisode> upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'episodes',
      lower: _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(lower),
      includeLower: includeLower,
      upper: _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(upper),
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      episodesStartsWith(
    List<TraktHistoryEpisode> value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'episodes',
      value: _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      episodesEndsWith(
    List<TraktHistoryEpisode> value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'episodes',
      value: _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      episodesContains(List<TraktHistoryEpisode> value,
          {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'episodes',
      value: _showHistorySeasonTraktHistoryEpisodeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      episodesMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'episodes',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
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

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
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

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      numberEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'number',
      value: value,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      numberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'number',
      value: value,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      numberLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'number',
      value: value,
    ));
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterFilterCondition>
      numberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'number',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ShowHistorySeasonQueryLinks
    on QueryBuilder<ShowHistorySeason, ShowHistorySeason, QFilterCondition> {}

extension ShowHistorySeasonQueryWhereSortBy
    on QueryBuilder<ShowHistorySeason, ShowHistorySeason, QSortBy> {
  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      sortByEpisodes() {
    return addSortByInternal('episodes', Sort.asc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      sortByEpisodesDesc() {
    return addSortByInternal('episodes', Sort.desc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      sortByNumber() {
    return addSortByInternal('number', Sort.asc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      sortByNumberDesc() {
    return addSortByInternal('number', Sort.desc);
  }
}

extension ShowHistorySeasonQueryWhereSortThenBy
    on QueryBuilder<ShowHistorySeason, ShowHistorySeason, QSortThenBy> {
  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      thenByEpisodes() {
    return addSortByInternal('episodes', Sort.asc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      thenByEpisodesDesc() {
    return addSortByInternal('episodes', Sort.desc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      thenByNumber() {
    return addSortByInternal('number', Sort.asc);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QAfterSortBy>
      thenByNumberDesc() {
    return addSortByInternal('number', Sort.desc);
  }
}

extension ShowHistorySeasonQueryWhereDistinct
    on QueryBuilder<ShowHistorySeason, ShowHistorySeason, QDistinct> {
  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QDistinct>
      distinctByEpisodes({bool caseSensitive = true}) {
    return addDistinctByInternal('episodes', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ShowHistorySeason, ShowHistorySeason, QDistinct>
      distinctByNumber() {
    return addDistinctByInternal('number');
  }
}

extension ShowHistorySeasonQueryProperty
    on QueryBuilder<ShowHistorySeason, ShowHistorySeason, QQueryProperty> {
  QueryBuilder<ShowHistorySeason, List<TraktHistoryEpisode>, QQueryOperations>
      episodesProperty() {
    return addPropertyNameInternal('episodes');
  }

  QueryBuilder<ShowHistorySeason, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ShowHistorySeason, int, QQueryOperations> numberProperty() {
    return addPropertyNameInternal('number');
  }
}

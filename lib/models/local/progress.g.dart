// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetProgressCollection on Isar {
  IsarCollection<Progress> get progresss => getCollection();
}

const ProgressSchema = CollectionSchema(
  name: 'Progress',
  schema:
      '{"name":"Progress","idName":"id","properties":[{"name":"episodeNo","type":"Long"},{"name":"movie","type":"String"},{"name":"progress","type":"Double"},{"name":"seasonNo","type":"Long"},{"name":"show","type":"String"},{"name":"type","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'episodeNo': 0,
    'movie': 1,
    'progress': 2,
    'seasonNo': 3,
    'show': 4,
    'type': 5
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _progressGetId,
  setId: _progressSetId,
  getLinks: _progressGetLinks,
  attachLinks: _progressAttachLinks,
  serializeNative: _progressSerializeNative,
  deserializeNative: _progressDeserializeNative,
  deserializePropNative: _progressDeserializePropNative,
  serializeWeb: _progressSerializeWeb,
  deserializeWeb: _progressDeserializeWeb,
  deserializePropWeb: _progressDeserializePropWeb,
  version: 3,
);

int? _progressGetId(Progress object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _progressSetId(Progress object, int id) {
  object.id = id;
}

List<IsarLinkBase> _progressGetLinks(Progress object) {
  return [];
}

const _progressMovieTypeConverter = MovieTypeConverter();
const _progressShowTypeConverter = ShowTypeConverter();

void _progressSerializeNative(
    IsarCollection<Progress> collection,
    IsarRawObject rawObj,
    Progress object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.episodeNo;
  final _episodeNo = value0;
  final value1 = _progressMovieTypeConverter.toIsar(object.movie);
  IsarUint8List? _movie;
  if (value1 != null) {
    _movie = IsarBinaryWriter.utf8Encoder.convert(value1);
  }
  dynamicSize += (_movie?.length ?? 0) as int;
  final value2 = object.progress;
  final _progress = value2;
  final value3 = object.seasonNo;
  final _seasonNo = value3;
  final value4 = _progressShowTypeConverter.toIsar(object.show);
  IsarUint8List? _show;
  if (value4 != null) {
    _show = IsarBinaryWriter.utf8Encoder.convert(value4);
  }
  dynamicSize += (_show?.length ?? 0) as int;
  final value5 = object.type;
  final _type = IsarBinaryWriter.utf8Encoder.convert(value5);
  dynamicSize += (_type.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _episodeNo);
  writer.writeBytes(offsets[1], _movie);
  writer.writeDouble(offsets[2], _progress);
  writer.writeLong(offsets[3], _seasonNo);
  writer.writeBytes(offsets[4], _show);
  writer.writeBytes(offsets[5], _type);
}

Progress _progressDeserializeNative(IsarCollection<Progress> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Progress();
  object.episodeNo = reader.readLongOrNull(offsets[0]);
  object.id = id;
  object.movie =
      _progressMovieTypeConverter.fromIsar(reader.readStringOrNull(offsets[1]));
  object.progress = reader.readDouble(offsets[2]);
  object.seasonNo = reader.readLongOrNull(offsets[3]);
  object.show =
      _progressShowTypeConverter.fromIsar(reader.readStringOrNull(offsets[4]));
  object.type = reader.readString(offsets[5]);
  return object;
}

P _progressDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (_progressMovieTypeConverter
          .fromIsar(reader.readStringOrNull(offset))) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (_progressShowTypeConverter
          .fromIsar(reader.readStringOrNull(offset))) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _progressSerializeWeb(
    IsarCollection<Progress> collection, Progress object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'episodeNo', object.episodeNo);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(
      jsObj, 'movie', _progressMovieTypeConverter.toIsar(object.movie));
  IsarNative.jsObjectSet(jsObj, 'progress', object.progress);
  IsarNative.jsObjectSet(jsObj, 'seasonNo', object.seasonNo);
  IsarNative.jsObjectSet(
      jsObj, 'show', _progressShowTypeConverter.toIsar(object.show));
  IsarNative.jsObjectSet(jsObj, 'type', object.type);
  return jsObj;
}

Progress _progressDeserializeWeb(
    IsarCollection<Progress> collection, dynamic jsObj) {
  final object = Progress();
  object.episodeNo = IsarNative.jsObjectGet(jsObj, 'episodeNo');
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.movie = _progressMovieTypeConverter
      .fromIsar(IsarNative.jsObjectGet(jsObj, 'movie'));
  object.progress =
      IsarNative.jsObjectGet(jsObj, 'progress') ?? double.negativeInfinity;
  object.seasonNo = IsarNative.jsObjectGet(jsObj, 'seasonNo');
  object.show = _progressShowTypeConverter
      .fromIsar(IsarNative.jsObjectGet(jsObj, 'show'));
  object.type = IsarNative.jsObjectGet(jsObj, 'type') ?? '';
  return object;
}

P _progressDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'episodeNo':
      return (IsarNative.jsObjectGet(jsObj, 'episodeNo')) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'movie':
      return (_progressMovieTypeConverter
          .fromIsar(IsarNative.jsObjectGet(jsObj, 'movie'))) as P;
    case 'progress':
      return (IsarNative.jsObjectGet(jsObj, 'progress') ??
          double.negativeInfinity) as P;
    case 'seasonNo':
      return (IsarNative.jsObjectGet(jsObj, 'seasonNo')) as P;
    case 'show':
      return (_progressShowTypeConverter
          .fromIsar(IsarNative.jsObjectGet(jsObj, 'show'))) as P;
    case 'type':
      return (IsarNative.jsObjectGet(jsObj, 'type') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _progressAttachLinks(IsarCollection col, int id, Progress object) {}

extension ProgressQueryWhereSort on QueryBuilder<Progress, Progress, QWhere> {
  QueryBuilder<Progress, Progress, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ProgressQueryWhere on QueryBuilder<Progress, Progress, QWhereClause> {
  QueryBuilder<Progress, Progress, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Progress, Progress, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> idBetween(
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

extension ProgressQueryFilter
    on QueryBuilder<Progress, Progress, QFilterCondition> {
  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'episodeNo',
      value: null,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'episodeNo',
      value: value,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'episodeNo',
      value: value,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'episodeNo',
      value: value,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'episodeNo',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'movie',
      value: null,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieEqualTo(
    Movie? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'movie',
      value: _progressMovieTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieGreaterThan(
    Movie? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'movie',
      value: _progressMovieTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieLessThan(
    Movie? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'movie',
      value: _progressMovieTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieBetween(
    Movie? lower,
    Movie? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'movie',
      lower: _progressMovieTypeConverter.toIsar(lower),
      includeLower: includeLower,
      upper: _progressMovieTypeConverter.toIsar(upper),
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieStartsWith(
    Movie value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'movie',
      value: _progressMovieTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieEndsWith(
    Movie value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'movie',
      value: _progressMovieTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieContains(
      Movie value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'movie',
      value: _progressMovieTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'movie',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> progressGreaterThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'progress',
      value: value,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> progressLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'progress',
      value: value,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> progressBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'progress',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'seasonNo',
      value: null,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'seasonNo',
      value: value,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'seasonNo',
      value: value,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'seasonNo',
      value: value,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'seasonNo',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'show',
      value: null,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showEqualTo(
    Tv? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'show',
      value: _progressShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showGreaterThan(
    Tv? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'show',
      value: _progressShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showLessThan(
    Tv? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'show',
      value: _progressShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showBetween(
    Tv? lower,
    Tv? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'show',
      lower: _progressShowTypeConverter.toIsar(lower),
      includeLower: includeLower,
      upper: _progressShowTypeConverter.toIsar(upper),
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showStartsWith(
    Tv value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'show',
      value: _progressShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showEndsWith(
    Tv value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'show',
      value: _progressShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showContains(Tv value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'show',
      value: _progressShowTypeConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'show',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'type',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'type',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ProgressQueryLinks
    on QueryBuilder<Progress, Progress, QFilterCondition> {}

extension ProgressQueryWhereSortBy
    on QueryBuilder<Progress, Progress, QSortBy> {
  QueryBuilder<Progress, Progress, QAfterSortBy> sortByEpisodeNo() {
    return addSortByInternal('episodeNo', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByEpisodeNoDesc() {
    return addSortByInternal('episodeNo', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByMovie() {
    return addSortByInternal('movie', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByMovieDesc() {
    return addSortByInternal('movie', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByProgress() {
    return addSortByInternal('progress', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByProgressDesc() {
    return addSortByInternal('progress', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortBySeasonNo() {
    return addSortByInternal('seasonNo', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortBySeasonNoDesc() {
    return addSortByInternal('seasonNo', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByShow() {
    return addSortByInternal('show', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByShowDesc() {
    return addSortByInternal('show', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }
}

extension ProgressQueryWhereSortThenBy
    on QueryBuilder<Progress, Progress, QSortThenBy> {
  QueryBuilder<Progress, Progress, QAfterSortBy> thenByEpisodeNo() {
    return addSortByInternal('episodeNo', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByEpisodeNoDesc() {
    return addSortByInternal('episodeNo', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByMovie() {
    return addSortByInternal('movie', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByMovieDesc() {
    return addSortByInternal('movie', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByProgress() {
    return addSortByInternal('progress', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByProgressDesc() {
    return addSortByInternal('progress', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenBySeasonNo() {
    return addSortByInternal('seasonNo', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenBySeasonNoDesc() {
    return addSortByInternal('seasonNo', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByShow() {
    return addSortByInternal('show', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByShowDesc() {
    return addSortByInternal('show', Sort.desc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }
}

extension ProgressQueryWhereDistinct
    on QueryBuilder<Progress, Progress, QDistinct> {
  QueryBuilder<Progress, Progress, QDistinct> distinctByEpisodeNo() {
    return addDistinctByInternal('episodeNo');
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctByMovie(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('movie', caseSensitive: caseSensitive);
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctByProgress() {
    return addDistinctByInternal('progress');
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctBySeasonNo() {
    return addDistinctByInternal('seasonNo');
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctByShow(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('show', caseSensitive: caseSensitive);
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('type', caseSensitive: caseSensitive);
  }
}

extension ProgressQueryProperty
    on QueryBuilder<Progress, Progress, QQueryProperty> {
  QueryBuilder<Progress, int?, QQueryOperations> episodeNoProperty() {
    return addPropertyNameInternal('episodeNo');
  }

  QueryBuilder<Progress, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Progress, Movie?, QQueryOperations> movieProperty() {
    return addPropertyNameInternal('movie');
  }

  QueryBuilder<Progress, double, QQueryOperations> progressProperty() {
    return addPropertyNameInternal('progress');
  }

  QueryBuilder<Progress, int?, QQueryOperations> seasonNoProperty() {
    return addPropertyNameInternal('seasonNo');
  }

  QueryBuilder<Progress, Tv?, QQueryOperations> showProperty() {
    return addPropertyNameInternal('show');
  }

  QueryBuilder<Progress, String, QQueryOperations> typeProperty() {
    return addPropertyNameInternal('type');
  }
}

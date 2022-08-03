// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetFavoritesCollection on Isar {
  IsarCollection<Favorites> get favoritess => getCollection();
}

const FavoritesSchema = CollectionSchema(
  name: 'Favorites',
  schema:
      '{"name":"Favorites","idName":"id","properties":[{"name":"backdropPath","type":"String"},{"name":"genreIds","type":"LongList"},{"name":"overview","type":"String"},{"name":"posterPath","type":"String"},{"name":"releaseDate","type":"String"},{"name":"title","type":"String"},{"name":"type","type":"String"},{"name":"voteAverage","type":"Double"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'backdropPath': 0,
    'genreIds': 1,
    'overview': 2,
    'posterPath': 3,
    'releaseDate': 4,
    'title': 5,
    'type': 6,
    'voteAverage': 7
  },
  listProperties: {'genreIds'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _favoritesGetId,
  setId: _favoritesSetId,
  getLinks: _favoritesGetLinks,
  attachLinks: _favoritesAttachLinks,
  serializeNative: _favoritesSerializeNative,
  deserializeNative: _favoritesDeserializeNative,
  deserializePropNative: _favoritesDeserializePropNative,
  serializeWeb: _favoritesSerializeWeb,
  deserializeWeb: _favoritesDeserializeWeb,
  deserializePropWeb: _favoritesDeserializePropWeb,
  version: 3,
);

int? _favoritesGetId(Favorites object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _favoritesSetId(Favorites object, int id) {
  object.id = id;
}

List<IsarLinkBase> _favoritesGetLinks(Favorites object) {
  return [];
}

void _favoritesSerializeNative(
    IsarCollection<Favorites> collection,
    IsarRawObject rawObj,
    Favorites object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.backdropPath;
  final _backdropPath = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_backdropPath.length) as int;
  final value1 = object.genreIds;
  dynamicSize += (value1.length) * 8;
  final _genreIds = value1;
  final value2 = object.overview;
  final _overview = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_overview.length) as int;
  final value3 = object.posterPath;
  final _posterPath = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_posterPath.length) as int;
  final value4 = object.releaseDate;
  final _releaseDate = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_releaseDate.length) as int;
  final value5 = object.title;
  final _title = IsarBinaryWriter.utf8Encoder.convert(value5);
  dynamicSize += (_title.length) as int;
  final value6 = object.type;
  final _type = IsarBinaryWriter.utf8Encoder.convert(value6);
  dynamicSize += (_type.length) as int;
  final value7 = object.voteAverage;
  final _voteAverage = value7;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _backdropPath);
  writer.writeLongList(offsets[1], _genreIds);
  writer.writeBytes(offsets[2], _overview);
  writer.writeBytes(offsets[3], _posterPath);
  writer.writeBytes(offsets[4], _releaseDate);
  writer.writeBytes(offsets[5], _title);
  writer.writeBytes(offsets[6], _type);
  writer.writeDouble(offsets[7], _voteAverage);
}

Favorites _favoritesDeserializeNative(IsarCollection<Favorites> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = Favorites();
  object.backdropPath = reader.readString(offsets[0]);
  object.genreIds = reader.readLongList(offsets[1]) ?? [];
  object.id = id;
  object.overview = reader.readString(offsets[2]);
  object.posterPath = reader.readString(offsets[3]);
  object.releaseDate = reader.readString(offsets[4]);
  object.title = reader.readString(offsets[5]);
  object.type = reader.readString(offsets[6]);
  object.voteAverage = reader.readDouble(offsets[7]);
  return object;
}

P _favoritesDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongList(offset) ?? []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _favoritesSerializeWeb(
    IsarCollection<Favorites> collection, Favorites object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'backdropPath', object.backdropPath);
  IsarNative.jsObjectSet(jsObj, 'genreIds', object.genreIds);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'overview', object.overview);
  IsarNative.jsObjectSet(jsObj, 'posterPath', object.posterPath);
  IsarNative.jsObjectSet(jsObj, 'releaseDate', object.releaseDate);
  IsarNative.jsObjectSet(jsObj, 'title', object.title);
  IsarNative.jsObjectSet(jsObj, 'type', object.type);
  IsarNative.jsObjectSet(jsObj, 'voteAverage', object.voteAverage);
  return jsObj;
}

Favorites _favoritesDeserializeWeb(
    IsarCollection<Favorites> collection, dynamic jsObj) {
  final object = Favorites();
  object.backdropPath = IsarNative.jsObjectGet(jsObj, 'backdropPath') ?? '';
  object.genreIds = (IsarNative.jsObjectGet(jsObj, 'genreIds') as List?)
          ?.map((e) => e ?? double.negativeInfinity)
          .toList()
          .cast<int>() ??
      [];
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.overview = IsarNative.jsObjectGet(jsObj, 'overview') ?? '';
  object.posterPath = IsarNative.jsObjectGet(jsObj, 'posterPath') ?? '';
  object.releaseDate = IsarNative.jsObjectGet(jsObj, 'releaseDate') ?? '';
  object.title = IsarNative.jsObjectGet(jsObj, 'title') ?? '';
  object.type = IsarNative.jsObjectGet(jsObj, 'type') ?? '';
  object.voteAverage =
      IsarNative.jsObjectGet(jsObj, 'voteAverage') ?? double.negativeInfinity;
  return object;
}

P _favoritesDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'backdropPath':
      return (IsarNative.jsObjectGet(jsObj, 'backdropPath') ?? '') as P;
    case 'genreIds':
      return ((IsarNative.jsObjectGet(jsObj, 'genreIds') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<int>() ??
          []) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'overview':
      return (IsarNative.jsObjectGet(jsObj, 'overview') ?? '') as P;
    case 'posterPath':
      return (IsarNative.jsObjectGet(jsObj, 'posterPath') ?? '') as P;
    case 'releaseDate':
      return (IsarNative.jsObjectGet(jsObj, 'releaseDate') ?? '') as P;
    case 'title':
      return (IsarNative.jsObjectGet(jsObj, 'title') ?? '') as P;
    case 'type':
      return (IsarNative.jsObjectGet(jsObj, 'type') ?? '') as P;
    case 'voteAverage':
      return (IsarNative.jsObjectGet(jsObj, 'voteAverage') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _favoritesAttachLinks(IsarCollection col, int id, Favorites object) {}

extension FavoritesQueryWhereSort
    on QueryBuilder<Favorites, Favorites, QWhere> {
  QueryBuilder<Favorites, Favorites, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension FavoritesQueryWhere
    on QueryBuilder<Favorites, Favorites, QWhereClause> {
  QueryBuilder<Favorites, Favorites, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Favorites, Favorites, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Favorites, Favorites, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Favorites, Favorites, QAfterWhereClause> idBetween(
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

extension FavoritesQueryFilter
    on QueryBuilder<Favorites, Favorites, QFilterCondition> {
  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> backdropPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'backdropPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      backdropPathGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'backdropPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      backdropPathLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'backdropPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> backdropPathBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'backdropPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      backdropPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'backdropPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      backdropPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'backdropPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      backdropPathContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'backdropPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> backdropPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'backdropPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> genreIdsAnyEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'genreIds',
      value: value,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      genreIdsAnyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'genreIds',
      value: value,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> genreIdsAnyLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'genreIds',
      value: value,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> genreIdsAnyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'genreIds',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> overviewEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'overview',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> overviewGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'overview',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> overviewLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'overview',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> overviewBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'overview',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> overviewStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'overview',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> overviewEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'overview',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> overviewContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'overview',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> overviewMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'overview',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> posterPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'posterPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      posterPathGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'posterPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> posterPathLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'posterPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> posterPathBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'posterPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      posterPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'posterPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> posterPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'posterPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> posterPathContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'posterPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> posterPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'posterPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> releaseDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'releaseDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      releaseDateGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'releaseDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> releaseDateLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'releaseDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> releaseDateBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'releaseDate',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      releaseDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'releaseDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> releaseDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'releaseDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> releaseDateContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'releaseDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> releaseDateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'releaseDate',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> titleLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'title',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'title',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> typeEqualTo(
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

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> typeGreaterThan(
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

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> typeLessThan(
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

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> typeBetween(
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

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> typeStartsWith(
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

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> typeEndsWith(
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

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'type',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition>
      voteAverageGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'voteAverage',
      value: value,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> voteAverageLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'voteAverage',
      value: value,
    ));
  }

  QueryBuilder<Favorites, Favorites, QAfterFilterCondition> voteAverageBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'voteAverage',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }
}

extension FavoritesQueryLinks
    on QueryBuilder<Favorites, Favorites, QFilterCondition> {}

extension FavoritesQueryWhereSortBy
    on QueryBuilder<Favorites, Favorites, QSortBy> {
  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByBackdropPath() {
    return addSortByInternal('backdropPath', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByBackdropPathDesc() {
    return addSortByInternal('backdropPath', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByOverview() {
    return addSortByInternal('overview', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByOverviewDesc() {
    return addSortByInternal('overview', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByPosterPath() {
    return addSortByInternal('posterPath', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByPosterPathDesc() {
    return addSortByInternal('posterPath', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByReleaseDate() {
    return addSortByInternal('releaseDate', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByReleaseDateDesc() {
    return addSortByInternal('releaseDate', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByVoteAverage() {
    return addSortByInternal('voteAverage', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> sortByVoteAverageDesc() {
    return addSortByInternal('voteAverage', Sort.desc);
  }
}

extension FavoritesQueryWhereSortThenBy
    on QueryBuilder<Favorites, Favorites, QSortThenBy> {
  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByBackdropPath() {
    return addSortByInternal('backdropPath', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByBackdropPathDesc() {
    return addSortByInternal('backdropPath', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByOverview() {
    return addSortByInternal('overview', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByOverviewDesc() {
    return addSortByInternal('overview', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByPosterPath() {
    return addSortByInternal('posterPath', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByPosterPathDesc() {
    return addSortByInternal('posterPath', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByReleaseDate() {
    return addSortByInternal('releaseDate', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByReleaseDateDesc() {
    return addSortByInternal('releaseDate', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByVoteAverage() {
    return addSortByInternal('voteAverage', Sort.asc);
  }

  QueryBuilder<Favorites, Favorites, QAfterSortBy> thenByVoteAverageDesc() {
    return addSortByInternal('voteAverage', Sort.desc);
  }
}

extension FavoritesQueryWhereDistinct
    on QueryBuilder<Favorites, Favorites, QDistinct> {
  QueryBuilder<Favorites, Favorites, QDistinct> distinctByBackdropPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('backdropPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<Favorites, Favorites, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Favorites, Favorites, QDistinct> distinctByOverview(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('overview', caseSensitive: caseSensitive);
  }

  QueryBuilder<Favorites, Favorites, QDistinct> distinctByPosterPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('posterPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<Favorites, Favorites, QDistinct> distinctByReleaseDate(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('releaseDate', caseSensitive: caseSensitive);
  }

  QueryBuilder<Favorites, Favorites, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('title', caseSensitive: caseSensitive);
  }

  QueryBuilder<Favorites, Favorites, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('type', caseSensitive: caseSensitive);
  }

  QueryBuilder<Favorites, Favorites, QDistinct> distinctByVoteAverage() {
    return addDistinctByInternal('voteAverage');
  }
}

extension FavoritesQueryProperty
    on QueryBuilder<Favorites, Favorites, QQueryProperty> {
  QueryBuilder<Favorites, String, QQueryOperations> backdropPathProperty() {
    return addPropertyNameInternal('backdropPath');
  }

  QueryBuilder<Favorites, List<int>, QQueryOperations> genreIdsProperty() {
    return addPropertyNameInternal('genreIds');
  }

  QueryBuilder<Favorites, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Favorites, String, QQueryOperations> overviewProperty() {
    return addPropertyNameInternal('overview');
  }

  QueryBuilder<Favorites, String, QQueryOperations> posterPathProperty() {
    return addPropertyNameInternal('posterPath');
  }

  QueryBuilder<Favorites, String, QQueryOperations> releaseDateProperty() {
    return addPropertyNameInternal('releaseDate');
  }

  QueryBuilder<Favorites, String, QQueryOperations> titleProperty() {
    return addPropertyNameInternal('title');
  }

  QueryBuilder<Favorites, String, QQueryOperations> typeProperty() {
    return addPropertyNameInternal('type');
  }

  QueryBuilder<Favorites, double, QQueryOperations> voteAverageProperty() {
    return addPropertyNameInternal('voteAverage');
  }
}

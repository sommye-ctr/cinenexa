// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installed_extensions.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetInstalledExtensionsCollection on Isar {
  IsarCollection<InstalledExtensions> get installedExtensions =>
      this.collection();
}

const InstalledExtensionsSchema = CollectionSchema(
  name: r'InstalledExtensions',
  id: -7786967811191324809,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'devEmail': PropertySchema(
      id: 2,
      name: r'devEmail',
      type: IsarType.string,
    ),
    r'devName': PropertySchema(
      id: 3,
      name: r'devName',
      type: IsarType.string,
    ),
    r'devUrl': PropertySchema(
      id: 4,
      name: r'devUrl',
      type: IsarType.string,
    ),
    r'domainId': PropertySchema(
      id: 5,
      name: r'domainId',
      type: IsarType.string,
    ),
    r'endpoint': PropertySchema(
      id: 6,
      name: r'endpoint',
      type: IsarType.string,
    ),
    r'icon': PropertySchema(
      id: 7,
      name: r'icon',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'providedRating': PropertySchema(
      id: 9,
      name: r'providedRating',
      type: IsarType.long,
    ),
    r'providesAnime': PropertySchema(
      id: 10,
      name: r'providesAnime',
      type: IsarType.bool,
    ),
    r'providesMovie': PropertySchema(
      id: 11,
      name: r'providesMovie',
      type: IsarType.bool,
    ),
    r'providesShow': PropertySchema(
      id: 12,
      name: r'providesShow',
      type: IsarType.bool,
    ),
    r'rating': PropertySchema(
      id: 13,
      name: r'rating',
      type: IsarType.double,
    ),
    r'ratingCount': PropertySchema(
      id: 14,
      name: r'ratingCount',
      type: IsarType.long,
    ),
    r'stId': PropertySchema(
      id: 15,
      name: r'stId',
      type: IsarType.string,
    ),
    r'userData': PropertySchema(
      id: 16,
      name: r'userData',
      type: IsarType.string,
    )
  },
  estimateSize: _installedExtensionsEstimateSize,
  serialize: _installedExtensionsSerialize,
  deserialize: _installedExtensionsDeserialize,
  deserializeProp: _installedExtensionsDeserializeProp,
  idName: r'id',
  indexes: {
    r'stId': IndexSchema(
      id: 800747657079054539,
      name: r'stId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'stId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _installedExtensionsGetId,
  getLinks: _installedExtensionsGetLinks,
  attach: _installedExtensionsAttach,
  version: '3.0.0',
);

int _installedExtensionsEstimateSize(
  InstalledExtensions object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.devEmail;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.devName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.devUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.domainId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.endpoint;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.icon;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userData;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _installedExtensionsSerialize(
  InstalledExtensions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.description);
  writer.writeString(offsets[2], object.devEmail);
  writer.writeString(offsets[3], object.devName);
  writer.writeString(offsets[4], object.devUrl);
  writer.writeString(offsets[5], object.domainId);
  writer.writeString(offsets[6], object.endpoint);
  writer.writeString(offsets[7], object.icon);
  writer.writeString(offsets[8], object.name);
  writer.writeLong(offsets[9], object.providedRating);
  writer.writeBool(offsets[10], object.providesAnime);
  writer.writeBool(offsets[11], object.providesMovie);
  writer.writeBool(offsets[12], object.providesShow);
  writer.writeDouble(offsets[13], object.rating);
  writer.writeLong(offsets[14], object.ratingCount);
  writer.writeString(offsets[15], object.stId);
  writer.writeString(offsets[16], object.userData);
}

InstalledExtensions _installedExtensionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InstalledExtensions();
  object.createdAt = reader.readDateTimeOrNull(offsets[0]);
  object.description = reader.readStringOrNull(offsets[1]);
  object.devEmail = reader.readStringOrNull(offsets[2]);
  object.devName = reader.readStringOrNull(offsets[3]);
  object.devUrl = reader.readStringOrNull(offsets[4]);
  object.domainId = reader.readStringOrNull(offsets[5]);
  object.endpoint = reader.readStringOrNull(offsets[6]);
  object.icon = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[8]);
  object.providedRating = reader.readLongOrNull(offsets[9]);
  object.providesAnime = reader.readBoolOrNull(offsets[10]);
  object.providesMovie = reader.readBoolOrNull(offsets[11]);
  object.providesShow = reader.readBoolOrNull(offsets[12]);
  object.rating = reader.readDoubleOrNull(offsets[13]);
  object.ratingCount = reader.readLongOrNull(offsets[14]);
  object.stId = reader.readStringOrNull(offsets[15]);
  object.userData = reader.readStringOrNull(offsets[16]);
  return object;
}

P _installedExtensionsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readBoolOrNull(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset)) as P;
    case 13:
      return (reader.readDoubleOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _installedExtensionsGetId(InstalledExtensions object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _installedExtensionsGetLinks(
    InstalledExtensions object) {
  return [];
}

void _installedExtensionsAttach(
    IsarCollection<dynamic> col, Id id, InstalledExtensions object) {
  object.id = id;
}

extension InstalledExtensionsQueryWhereSort
    on QueryBuilder<InstalledExtensions, InstalledExtensions, QWhere> {
  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InstalledExtensionsQueryWhere
    on QueryBuilder<InstalledExtensions, InstalledExtensions, QWhereClause> {
  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhereClause>
      stIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'stId',
        value: [null],
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhereClause>
      stIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'stId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhereClause>
      stIdEqualTo(String? stId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'stId',
        value: [stId],
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterWhereClause>
      stIdNotEqualTo(String? stId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stId',
              lower: [],
              upper: [stId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stId',
              lower: [stId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stId',
              lower: [stId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stId',
              lower: [],
              upper: [stId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension InstalledExtensionsQueryFilter on QueryBuilder<InstalledExtensions,
    InstalledExtensions, QFilterCondition> {
  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'devEmail',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'devEmail',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'devEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'devEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'devEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'devEmail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'devEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'devEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'devEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'devEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'devEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'devEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'devName',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'devName',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'devName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'devName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'devName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'devName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'devName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'devName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'devName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'devName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'devName',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'devName',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'devUrl',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'devUrl',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'devUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'devUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'devUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'devUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'devUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'devUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'devUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'devUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'devUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      devUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'devUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'domainId',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'domainId',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'domainId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'domainId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      domainIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endpoint',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endpoint',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endpoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endpoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endpoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endpoint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'endpoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'endpoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'endpoint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'endpoint',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endpoint',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      endpointIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'endpoint',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'icon',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'icon',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'icon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'icon',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icon',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      iconIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'icon',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
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

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
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

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providedRatingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'providedRating',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providedRatingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'providedRating',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providedRatingEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'providedRating',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providedRatingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'providedRating',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providedRatingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'providedRating',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providedRatingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'providedRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providesAnimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'providesAnime',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providesAnimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'providesAnime',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providesAnimeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'providesAnime',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providesMovieIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'providesMovie',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providesMovieIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'providesMovie',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providesMovieEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'providesMovie',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providesShowIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'providesShow',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providesShowIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'providesShow',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      providesShowEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'providesShow',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ratingCount',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ratingCount',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ratingCount',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ratingCount',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ratingCount',
        value: value,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      ratingCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ratingCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stId',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stId',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stId',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      stIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stId',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userData',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userData',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userData',
        value: '',
      ));
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterFilterCondition>
      userDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userData',
        value: '',
      ));
    });
  }
}

extension InstalledExtensionsQueryObject on QueryBuilder<InstalledExtensions,
    InstalledExtensions, QFilterCondition> {}

extension InstalledExtensionsQueryLinks on QueryBuilder<InstalledExtensions,
    InstalledExtensions, QFilterCondition> {}

extension InstalledExtensionsQuerySortBy
    on QueryBuilder<InstalledExtensions, InstalledExtensions, QSortBy> {
  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDevEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devEmail', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDevEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devEmail', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDevName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devName', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDevNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devName', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDevUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devUrl', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDevUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devUrl', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByEndpoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpoint', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByEndpointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpoint', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByProvidedRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providedRating', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByProvidedRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providedRating', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByProvidesAnime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesAnime', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByProvidesAnimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesAnime', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByProvidesMovie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesMovie', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByProvidesMovieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesMovie', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByProvidesShow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesShow', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByProvidesShowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesShow', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByRatingCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingCount', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByRatingCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingCount', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByStId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stId', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByStIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stId', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByUserData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userData', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      sortByUserDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userData', Sort.desc);
    });
  }
}

extension InstalledExtensionsQuerySortThenBy
    on QueryBuilder<InstalledExtensions, InstalledExtensions, QSortThenBy> {
  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDevEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devEmail', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDevEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devEmail', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDevName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devName', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDevNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devName', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDevUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devUrl', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDevUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'devUrl', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByEndpoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpoint', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByEndpointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpoint', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByProvidedRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providedRating', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByProvidedRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providedRating', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByProvidesAnime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesAnime', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByProvidesAnimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesAnime', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByProvidesMovie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesMovie', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByProvidesMovieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesMovie', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByProvidesShow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesShow', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByProvidesShowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providesShow', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByRatingCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingCount', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByRatingCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratingCount', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByStId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stId', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByStIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stId', Sort.desc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByUserData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userData', Sort.asc);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QAfterSortBy>
      thenByUserDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userData', Sort.desc);
    });
  }
}

extension InstalledExtensionsQueryWhereDistinct
    on QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct> {
  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByDevEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'devEmail', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByDevName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'devName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByDevUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'devUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByDomainId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'domainId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByEndpoint({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endpoint', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByIcon({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'icon', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByProvidedRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'providedRating');
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByProvidesAnime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'providesAnime');
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByProvidesMovie() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'providesMovie');
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByProvidesShow() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'providesShow');
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByRatingCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratingCount');
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByStId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InstalledExtensions, InstalledExtensions, QDistinct>
      distinctByUserData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userData', caseSensitive: caseSensitive);
    });
  }
}

extension InstalledExtensionsQueryProperty
    on QueryBuilder<InstalledExtensions, InstalledExtensions, QQueryProperty> {
  QueryBuilder<InstalledExtensions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InstalledExtensions, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations>
      devEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'devEmail');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations>
      devNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'devName');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations>
      devUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'devUrl');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations>
      domainIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'domainId');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations>
      endpointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endpoint');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations> iconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'icon');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<InstalledExtensions, int?, QQueryOperations>
      providedRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'providedRating');
    });
  }

  QueryBuilder<InstalledExtensions, bool?, QQueryOperations>
      providesAnimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'providesAnime');
    });
  }

  QueryBuilder<InstalledExtensions, bool?, QQueryOperations>
      providesMovieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'providesMovie');
    });
  }

  QueryBuilder<InstalledExtensions, bool?, QQueryOperations>
      providesShowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'providesShow');
    });
  }

  QueryBuilder<InstalledExtensions, double?, QQueryOperations>
      ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<InstalledExtensions, int?, QQueryOperations>
      ratingCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratingCount');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations> stIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stId');
    });
  }

  QueryBuilder<InstalledExtensions, String?, QQueryOperations>
      userDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userData');
    });
  }
}

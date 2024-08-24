// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extension_stream.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ExtensionStreamSchema = Schema(
  name: r'ExtensionStream',
  id: -882916709709716030,
  properties: {
    r'country': PropertySchema(
      id: 0,
      name: r'country',
      type: IsarType.string,
    ),
    r'dubbed': PropertySchema(
      id: 1,
      name: r'dubbed',
      type: IsarType.bool,
    ),
    r'extension': PropertySchema(
      id: 2,
      name: r'extension',
      type: IsarType.object,
      target: r'Extension',
    ),
    r'external': PropertySchema(
      id: 3,
      name: r'external',
      type: IsarType.string,
    ),
    r'fileIndex': PropertySchema(
      id: 4,
      name: r'fileIndex',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.double,
    ),
    r'magnet': PropertySchema(
      id: 6,
      name: r'magnet',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'quality': PropertySchema(
      id: 8,
      name: r'quality',
      type: IsarType.string,
    ),
    r'seeds': PropertySchema(
      id: 9,
      name: r'seeds',
      type: IsarType.long,
    ),
    r'size': PropertySchema(
      id: 10,
      name: r'size',
      type: IsarType.double,
    ),
    r'streamGroup': PropertySchema(
      id: 11,
      name: r'streamGroup',
      type: IsarType.string,
    ),
    r'subbed': PropertySchema(
      id: 12,
      name: r'subbed',
      type: IsarType.bool,
    ),
    r'subtitles': PropertySchema(
      id: 13,
      name: r'subtitles',
      type: IsarType.objectList,
      target: r'Subtitle',
    ),
    r'torrent': PropertySchema(
      id: 14,
      name: r'torrent',
      type: IsarType.bool,
    ),
    r'url': PropertySchema(
      id: 15,
      name: r'url',
      type: IsarType.string,
    ),
    r'ytId': PropertySchema(
      id: 16,
      name: r'ytId',
      type: IsarType.string,
    )
  },
  estimateSize: _extensionStreamEstimateSize,
  serialize: _extensionStreamSerialize,
  deserialize: _extensionStreamDeserialize,
  deserializeProp: _extensionStreamDeserializeProp,
);

int _extensionStreamEstimateSize(
  ExtensionStream object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.country;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.extension;
    if (value != null) {
      bytesCount += 3 +
          ExtensionSchema.estimateSize(
              value, allOffsets[Extension]!, allOffsets);
    }
  }
  {
    final value = object.external;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.magnet;
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
    final value = object.quality;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.streamGroup;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.subtitles;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Subtitle]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += SubtitleSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.url;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ytId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _extensionStreamSerialize(
  ExtensionStream object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.country);
  writer.writeBool(offsets[1], object.dubbed);
  writer.writeObject<Extension>(
    offsets[2],
    allOffsets,
    ExtensionSchema.serialize,
    object.extension,
  );
  writer.writeString(offsets[3], object.external);
  writer.writeLong(offsets[4], object.fileIndex);
  writer.writeDouble(offsets[5], object.id);
  writer.writeString(offsets[6], object.magnet);
  writer.writeString(offsets[7], object.name);
  writer.writeString(offsets[8], object.quality);
  writer.writeLong(offsets[9], object.seeds);
  writer.writeDouble(offsets[10], object.size);
  writer.writeString(offsets[11], object.streamGroup);
  writer.writeBool(offsets[12], object.subbed);
  writer.writeObjectList<Subtitle>(
    offsets[13],
    allOffsets,
    SubtitleSchema.serialize,
    object.subtitles,
  );
  writer.writeBool(offsets[14], object.torrent);
  writer.writeString(offsets[15], object.url);
  writer.writeString(offsets[16], object.ytId);
}

ExtensionStream _extensionStreamDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExtensionStream();
  object.country = reader.readStringOrNull(offsets[0]);
  object.dubbed = reader.readBoolOrNull(offsets[1]);
  object.extension = reader.readObjectOrNull<Extension>(
    offsets[2],
    ExtensionSchema.deserialize,
    allOffsets,
  );
  object.external = reader.readStringOrNull(offsets[3]);
  object.fileIndex = reader.readLongOrNull(offsets[4]);
  object.id = reader.readDouble(offsets[5]);
  object.magnet = reader.readStringOrNull(offsets[6]);
  object.name = reader.readStringOrNull(offsets[7]);
  object.quality = reader.readStringOrNull(offsets[8]);
  object.seeds = reader.readLongOrNull(offsets[9]);
  object.size = reader.readDoubleOrNull(offsets[10]);
  object.streamGroup = reader.readStringOrNull(offsets[11]);
  object.subbed = reader.readBoolOrNull(offsets[12]);
  object.subtitles = reader.readObjectList<Subtitle>(
    offsets[13],
    SubtitleSchema.deserialize,
    allOffsets,
    Subtitle(),
  );
  object.torrent = reader.readBoolOrNull(offsets[14]);
  object.url = reader.readStringOrNull(offsets[15]);
  object.ytId = reader.readStringOrNull(offsets[16]);
  return object;
}

P _extensionStreamDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<Extension>(
        offset,
        ExtensionSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset)) as P;
    case 13:
      return (reader.readObjectList<Subtitle>(
        offset,
        SubtitleSchema.deserialize,
        allOffsets,
        Subtitle(),
      )) as P;
    case 14:
      return (reader.readBoolOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ExtensionStreamQueryFilter
    on QueryBuilder<ExtensionStream, ExtensionStream, QFilterCondition> {
  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'country',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'country',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'country',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'country',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      countryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      dubbedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dubbed',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      dubbedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dubbed',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      dubbedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dubbed',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      extensionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'extension',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      extensionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'extension',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'external',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'external',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'external',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'external',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'external',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'external',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'external',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'external',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'external',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'external',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'external',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      externalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'external',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      fileIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileIndex',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      fileIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileIndex',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      fileIndexEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      fileIndexGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      fileIndexLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      fileIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      idEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      idGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      idLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      idBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'magnet',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'magnet',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'magnet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'magnet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'magnet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'magnet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'magnet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'magnet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'magnet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'magnet',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'magnet',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      magnetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'magnet',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
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

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
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

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
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

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
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

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
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

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
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

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quality',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quality',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quality',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quality',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      qualityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quality',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      seedsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'seeds',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      seedsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'seeds',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      seedsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seeds',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      seedsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seeds',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      seedsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seeds',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      seedsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seeds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      sizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      sizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      sizeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      sizeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      sizeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      sizeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'streamGroup',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'streamGroup',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streamGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streamGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streamGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'streamGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'streamGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'streamGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'streamGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      streamGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'streamGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subbedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subbed',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subbedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subbed',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subbedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subbed',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subtitlesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subtitles',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subtitlesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subtitles',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subtitlesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subtitles',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subtitlesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subtitles',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subtitlesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subtitles',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subtitlesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subtitles',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subtitlesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subtitles',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subtitlesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subtitles',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      torrentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'torrent',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      torrentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'torrent',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      torrentEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'torrent',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'url',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'url',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ytId',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ytId',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ytId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ytId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ytId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ytId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ytId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ytId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ytId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ytId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ytId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      ytIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ytId',
        value: '',
      ));
    });
  }
}

extension ExtensionStreamQueryObject
    on QueryBuilder<ExtensionStream, ExtensionStream, QFilterCondition> {
  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      extension(FilterQuery<Extension> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'extension');
    });
  }

  QueryBuilder<ExtensionStream, ExtensionStream, QAfterFilterCondition>
      subtitlesElement(FilterQuery<Subtitle> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'subtitles');
    });
  }
}

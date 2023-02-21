// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetProgressCollection on Isar {
  IsarCollection<Progress> get progress => this.collection();
}

const ProgressSchema = CollectionSchema(
  name: r'Progress',
  id: 4416052739984182258,
  properties: {
    r'episodeNo': PropertySchema(
      id: 0,
      name: r'episodeNo',
      type: IsarType.long,
    ),
    r'movie': PropertySchema(
      id: 1,
      name: r'movie',
      type: IsarType.object,
      target: r'Movie',
    ),
    r'pausedAt': PropertySchema(
      id: 2,
      name: r'pausedAt',
      type: IsarType.dateTime,
    ),
    r'playbackId': PropertySchema(
      id: 3,
      name: r'playbackId',
      type: IsarType.long,
    ),
    r'progress': PropertySchema(
      id: 4,
      name: r'progress',
      type: IsarType.double,
    ),
    r'seasonNo': PropertySchema(
      id: 5,
      name: r'seasonNo',
      type: IsarType.long,
    ),
    r'show': PropertySchema(
      id: 6,
      name: r'show',
      type: IsarType.object,
      target: r'Tv',
    ),
    r'stream': PropertySchema(
      id: 7,
      name: r'stream',
      type: IsarType.object,
      target: r'ExtensionStream',
    ),
    r'subtitle': PropertySchema(
      id: 8,
      name: r'subtitle',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _progressEstimateSize,
  serialize: _progressSerialize,
  deserialize: _progressDeserialize,
  deserializeProp: _progressDeserializeProp,
  idName: r'id',
  indexes: {
    r'pausedAt': IndexSchema(
      id: -3957613417905400958,
      name: r'pausedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'pausedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'Movie': MovieSchema,
    r'Genre': GenreSchema,
    r'Tv': TvSchema,
    r'TvSeason': TvSeasonSchema,
    r'ExtensionStream': ExtensionStreamSchema,
    r'Subtitle': SubtitleSchema,
    r'Extension': ExtensionSchema
  },
  getId: _progressGetId,
  getLinks: _progressGetLinks,
  attach: _progressAttach,
  version: '3.0.0',
);

int _progressEstimateSize(
  Progress object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.movie;
    if (value != null) {
      bytesCount +=
          3 + MovieSchema.estimateSize(value, allOffsets[Movie]!, allOffsets);
    }
  }
  {
    final value = object.show;
    if (value != null) {
      bytesCount +=
          3 + TvSchema.estimateSize(value, allOffsets[Tv]!, allOffsets);
    }
  }
  {
    final value = object.stream;
    if (value != null) {
      bytesCount += 3 +
          ExtensionStreamSchema.estimateSize(
              value, allOffsets[ExtensionStream]!, allOffsets);
    }
  }
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _progressSerialize(
  Progress object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.episodeNo);
  writer.writeObject<Movie>(
    offsets[1],
    allOffsets,
    MovieSchema.serialize,
    object.movie,
  );
  writer.writeDateTime(offsets[2], object.pausedAt);
  writer.writeLong(offsets[3], object.playbackId);
  writer.writeDouble(offsets[4], object.progress);
  writer.writeLong(offsets[5], object.seasonNo);
  writer.writeObject<Tv>(
    offsets[6],
    allOffsets,
    TvSchema.serialize,
    object.show,
  );
  writer.writeObject<ExtensionStream>(
    offsets[7],
    allOffsets,
    ExtensionStreamSchema.serialize,
    object.stream,
  );
  writer.writeLong(offsets[8], object.subtitle);
  writer.writeString(offsets[9], object.type);
}

Progress _progressDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Progress();
  object.episodeNo = reader.readLongOrNull(offsets[0]);
  object.id = id;
  object.movie = reader.readObjectOrNull<Movie>(
    offsets[1],
    MovieSchema.deserialize,
    allOffsets,
  );
  object.pausedAt = reader.readDateTimeOrNull(offsets[2]);
  object.playbackId = reader.readLongOrNull(offsets[3]);
  object.progress = reader.readDouble(offsets[4]);
  object.seasonNo = reader.readLongOrNull(offsets[5]);
  object.show = reader.readObjectOrNull<Tv>(
    offsets[6],
    TvSchema.deserialize,
    allOffsets,
  );
  object.stream = reader.readObjectOrNull<ExtensionStream>(
    offsets[7],
    ExtensionStreamSchema.deserialize,
    allOffsets,
  );
  object.subtitle = reader.readLongOrNull(offsets[8]);
  object.type = reader.readString(offsets[9]);
  return object;
}

P _progressDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<Movie>(
        offset,
        MovieSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readObjectOrNull<Tv>(
        offset,
        TvSchema.deserialize,
        allOffsets,
      )) as P;
    case 7:
      return (reader.readObjectOrNull<ExtensionStream>(
        offset,
        ExtensionStreamSchema.deserialize,
        allOffsets,
      )) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _progressGetId(Progress object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _progressGetLinks(Progress object) {
  return [];
}

void _progressAttach(IsarCollection<dynamic> col, Id id, Progress object) {
  object.id = id;
}

extension ProgressQueryWhereSort on QueryBuilder<Progress, Progress, QWhere> {
  QueryBuilder<Progress, Progress, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhere> anyPausedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'pausedAt'),
      );
    });
  }
}

extension ProgressQueryWhere on QueryBuilder<Progress, Progress, QWhereClause> {
  QueryBuilder<Progress, Progress, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Progress, Progress, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> idBetween(
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

  QueryBuilder<Progress, Progress, QAfterWhereClause> pausedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'pausedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> pausedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pausedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> pausedAtEqualTo(
      DateTime? pausedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'pausedAt',
        value: [pausedAt],
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> pausedAtNotEqualTo(
      DateTime? pausedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pausedAt',
              lower: [],
              upper: [pausedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pausedAt',
              lower: [pausedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pausedAt',
              lower: [pausedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pausedAt',
              lower: [],
              upper: [pausedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> pausedAtGreaterThan(
    DateTime? pausedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pausedAt',
        lower: [pausedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> pausedAtLessThan(
    DateTime? pausedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pausedAt',
        lower: [],
        upper: [pausedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterWhereClause> pausedAtBetween(
    DateTime? lowerPausedAt,
    DateTime? upperPausedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pausedAt',
        lower: [lowerPausedAt],
        includeLower: includeLower,
        upper: [upperPausedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProgressQueryFilter
    on QueryBuilder<Progress, Progress, QFilterCondition> {
  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'episodeNo',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'episodeNo',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodeNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episodeNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episodeNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> episodeNoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episodeNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Progress, Progress, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'movie',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> movieIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'movie',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> pausedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pausedAt',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> pausedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pausedAt',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> pausedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pausedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> pausedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pausedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> pausedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pausedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> pausedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pausedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> playbackIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playbackId',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition>
      playbackIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playbackId',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> playbackIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playbackId',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> playbackIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playbackId',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> playbackIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playbackId',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> playbackIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playbackId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> progressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> progressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> progressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> progressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'seasonNo',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'seasonNo',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seasonNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seasonNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seasonNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> seasonNoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seasonNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'show',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> showIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'show',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> streamIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stream',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> streamIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stream',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> subtitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subtitle',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> subtitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subtitle',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> subtitleEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtitle',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> subtitleGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subtitle',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> subtitleLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subtitle',
        value: value,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> subtitleBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subtitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension ProgressQueryObject
    on QueryBuilder<Progress, Progress, QFilterCondition> {
  QueryBuilder<Progress, Progress, QAfterFilterCondition> movie(
      FilterQuery<Movie> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'movie');
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> show(
      FilterQuery<Tv> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'show');
    });
  }

  QueryBuilder<Progress, Progress, QAfterFilterCondition> stream(
      FilterQuery<ExtensionStream> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'stream');
    });
  }
}

extension ProgressQueryLinks
    on QueryBuilder<Progress, Progress, QFilterCondition> {}

extension ProgressQuerySortBy on QueryBuilder<Progress, Progress, QSortBy> {
  QueryBuilder<Progress, Progress, QAfterSortBy> sortByEpisodeNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeNo', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByEpisodeNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeNo', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByPausedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedAt', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByPausedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedAt', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByPlaybackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackId', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByPlaybackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackId', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortBySeasonNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonNo', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortBySeasonNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonNo', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortBySubtitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortBySubtitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ProgressQuerySortThenBy
    on QueryBuilder<Progress, Progress, QSortThenBy> {
  QueryBuilder<Progress, Progress, QAfterSortBy> thenByEpisodeNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeNo', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByEpisodeNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeNo', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByPausedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedAt', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByPausedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedAt', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByPlaybackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackId', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByPlaybackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackId', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenBySeasonNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonNo', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenBySeasonNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonNo', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenBySubtitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenBySubtitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.desc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Progress, Progress, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ProgressQueryWhereDistinct
    on QueryBuilder<Progress, Progress, QDistinct> {
  QueryBuilder<Progress, Progress, QDistinct> distinctByEpisodeNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episodeNo');
    });
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctByPausedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pausedAt');
    });
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctByPlaybackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playbackId');
    });
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctBySeasonNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seasonNo');
    });
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctBySubtitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subtitle');
    });
  }

  QueryBuilder<Progress, Progress, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension ProgressQueryProperty
    on QueryBuilder<Progress, Progress, QQueryProperty> {
  QueryBuilder<Progress, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Progress, int?, QQueryOperations> episodeNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodeNo');
    });
  }

  QueryBuilder<Progress, Movie?, QQueryOperations> movieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movie');
    });
  }

  QueryBuilder<Progress, DateTime?, QQueryOperations> pausedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pausedAt');
    });
  }

  QueryBuilder<Progress, int?, QQueryOperations> playbackIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playbackId');
    });
  }

  QueryBuilder<Progress, double, QQueryOperations> progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<Progress, int?, QQueryOperations> seasonNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seasonNo');
    });
  }

  QueryBuilder<Progress, Tv?, QQueryOperations> showProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'show');
    });
  }

  QueryBuilder<Progress, ExtensionStream?, QQueryOperations> streamProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stream');
    });
  }

  QueryBuilder<Progress, int?, QQueryOperations> subtitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subtitle');
    });
  }

  QueryBuilder<Progress, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_page1_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsPage1Store on _DetailsPage1Store, Store {
  final _$genresAtom = Atom(name: '_DetailsPage1Store.genres');

  @override
  List<Genre> get genres {
    _$genresAtom.reportRead();
    return super.genres;
  }

  @override
  set genres(List<Genre> value) {
    _$genresAtom.reportWrite(value, super.genres, () {
      super.genres = value;
    });
  }

  final _$releaseDateAtom = Atom(name: '_DetailsPage1Store.releaseDate');

  @override
  String? get releaseDate {
    _$releaseDateAtom.reportRead();
    return super.releaseDate;
  }

  @override
  set releaseDate(String? value) {
    _$releaseDateAtom.reportWrite(value, super.releaseDate, () {
      super.releaseDate = value;
    });
  }

  final _$tvShowEndTimeAtom = Atom(name: '_DetailsPage1Store.tvShowEndTime');

  @override
  String? get tvShowEndTime {
    _$tvShowEndTimeAtom.reportRead();
    return super.tvShowEndTime;
  }

  @override
  set tvShowEndTime(String? value) {
    _$tvShowEndTimeAtom.reportWrite(value, super.tvShowEndTime, () {
      super.tvShowEndTime = value;
    });
  }

  final _$runtimeAtom = Atom(name: '_DetailsPage1Store.runtime');

  @override
  int? get runtime {
    _$runtimeAtom.reportRead();
    return super.runtime;
  }

  @override
  set runtime(int? value) {
    _$runtimeAtom.reportWrite(value, super.runtime, () {
      super.runtime = value;
    });
  }

  final _$_DetailsPage1StoreActionController =
      ActionController(name: '_DetailsPage1Store');

  @override
  void setGenres(List<Genre> data) {
    final _$actionInfo = _$_DetailsPage1StoreActionController.startAction(
        name: '_DetailsPage1Store.setGenres');
    try {
      return super.setGenres(data);
    } finally {
      _$_DetailsPage1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReleaseDate(String? releaseDate) {
    final _$actionInfo = _$_DetailsPage1StoreActionController.startAction(
        name: '_DetailsPage1Store.setReleaseDate');
    try {
      return super.setReleaseDate(releaseDate);
    } finally {
      _$_DetailsPage1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTvShowEndTime(String? date) {
    final _$actionInfo = _$_DetailsPage1StoreActionController.startAction(
        name: '_DetailsPage1Store.setTvShowEndTime');
    try {
      return super.setTvShowEndTime(date);
    } finally {
      _$_DetailsPage1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRuntime(int? runtime) {
    final _$actionInfo = _$_DetailsPage1StoreActionController.startAction(
        name: '_DetailsPage1Store.setRuntime');
    try {
      return super.setRuntime(runtime);
    } finally {
      _$_DetailsPage1StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
genres: ${genres},
releaseDate: ${releaseDate},
tvShowEndTime: ${tvShowEndTime},
runtime: ${runtime}
    ''';
  }
}

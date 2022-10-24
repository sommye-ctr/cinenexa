// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayerStore on _PlayerStoreBase, Store {
  late final _$showControlsAtom =
      Atom(name: '_PlayerStoreBase.showControls', context: context);

  @override
  bool get showControls {
    _$showControlsAtom.reportRead();
    return super.showControls;
  }

  @override
  set showControls(bool value) {
    _$showControlsAtom.reportWrite(value, super.showControls, () {
      super.showControls = value;
    });
  }

  late final _$bufferingAtom =
      Atom(name: '_PlayerStoreBase.buffering', context: context);

  @override
  bool get buffering {
    _$bufferingAtom.reportRead();
    return super.buffering;
  }

  @override
  set buffering(bool value) {
    _$bufferingAtom.reportWrite(value, super.buffering, () {
      super.buffering = value;
    });
  }

  late final _$lockedAtom =
      Atom(name: '_PlayerStoreBase.locked', context: context);

  @override
  bool get locked {
    _$lockedAtom.reportRead();
    return super.locked;
  }

  @override
  set locked(bool value) {
    _$lockedAtom.reportWrite(value, super.locked, () {
      super.locked = value;
    });
  }

  late final _$speedIndexAtom =
      Atom(name: '_PlayerStoreBase.speedIndex', context: context);

  @override
  int get speedIndex {
    _$speedIndexAtom.reportRead();
    return super.speedIndex;
  }

  @override
  set speedIndex(int value) {
    _$speedIndexAtom.reportWrite(value, super.speedIndex, () {
      super.speedIndex = value;
    });
  }

  late final _$fitIndexAtom =
      Atom(name: '_PlayerStoreBase.fitIndex', context: context);

  @override
  int get fitIndex {
    _$fitIndexAtom.reportRead();
    return super.fitIndex;
  }

  @override
  set fitIndex(int value) {
    _$fitIndexAtom.reportWrite(value, super.fitIndex, () {
      super.fitIndex = value;
    });
  }

  late final _$subtitleDelayAtom =
      Atom(name: '_PlayerStoreBase.subtitleDelay', context: context);

  @override
  int get subtitleDelay {
    _$subtitleDelayAtom.reportRead();
    return super.subtitleDelay;
  }

  @override
  set subtitleDelay(int value) {
    _$subtitleDelayAtom.reportWrite(value, super.subtitleDelay, () {
      super.subtitleDelay = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_PlayerStoreBase.position', context: context);

  @override
  Duration get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Duration value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$bufferedAtom =
      Atom(name: '_PlayerStoreBase.buffered', context: context);

  @override
  Duration get buffered {
    _$bufferedAtom.reportRead();
    return super.buffered;
  }

  @override
  set buffered(Duration value) {
    _$bufferedAtom.reportWrite(value, super.buffered, () {
      super.buffered = value;
    });
  }

  late final _$selectedSubtitleAtom =
      Atom(name: '_PlayerStoreBase.selectedSubtitle', context: context);

  @override
  int? get selectedSubtitle {
    _$selectedSubtitleAtom.reportRead();
    return super.selectedSubtitle;
  }

  @override
  set selectedSubtitle(int? value) {
    _$selectedSubtitleAtom.reportWrite(value, super.selectedSubtitle, () {
      super.selectedSubtitle = value;
    });
  }

  late final _$selectedTrackAtom =
      Atom(name: '_PlayerStoreBase.selectedTrack', context: context);

  @override
  int? get selectedTrack {
    _$selectedTrackAtom.reportRead();
    return super.selectedTrack;
  }

  @override
  set selectedTrack(int? value) {
    _$selectedTrackAtom.reportWrite(value, super.selectedTrack, () {
      super.selectedTrack = value;
    });
  }

  late final _$subtitlesAtom =
      Atom(name: '_PlayerStoreBase.subtitles', context: context);

  @override
  ObservableMap<int, String>? get subtitles {
    _$subtitlesAtom.reportRead();
    return super.subtitles;
  }

  @override
  set subtitles(ObservableMap<int, String>? value) {
    _$subtitlesAtom.reportWrite(value, super.subtitles, () {
      super.subtitles = value;
    });
  }

  late final _$tracksAtom =
      Atom(name: '_PlayerStoreBase.tracks', context: context);

  @override
  ObservableMap<int, String>? get tracks {
    _$tracksAtom.reportRead();
    return super.tracks;
  }

  @override
  set tracks(ObservableMap<int, String>? value) {
    _$tracksAtom.reportWrite(value, super.tracks, () {
      super.tracks = value;
    });
  }

  late final _$_PlayerStoreBaseActionController =
      ActionController(name: '_PlayerStoreBase', context: context);

  @override
  void setSubtitleDelay(int delay) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setSubtitleDelay');
    try {
      return super.setSubtitleDelay(delay);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSpeedIndex(int index) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setSpeedIndex');
    try {
      return super.setSpeedIndex(index);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFitIndex(int index) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setFitIndex');
    try {
      return super.setFitIndex(index);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPosition(Duration duration) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setPosition');
    try {
      return super.setPosition(duration);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBuffered(Duration duration) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setBuffered');
    try {
      return super.setBuffered(duration);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowControls(bool show) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setShowControls');
    try {
      return super.setShowControls(show);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBuffering(bool buffer) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setBuffering');
    try {
      return super.setBuffering(buffer);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocked(bool lock) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setLocked');
    try {
      return super.setLocked(lock);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSubtitles(Map<int, String> sub) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setSubtitles');
    try {
      return super.setSubtitles(sub);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTracks(Map<int, String> track) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setTracks');
    try {
      return super.setTracks(track);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedTrack(int? track) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setSelectedTrack');
    try {
      return super.setSelectedTrack(track);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedSubtitle(int? subtitle) {
    final _$actionInfo = _$_PlayerStoreBaseActionController.startAction(
        name: '_PlayerStoreBase.setSelectedSubtitle');
    try {
      return super.setSelectedSubtitle(subtitle);
    } finally {
      _$_PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showControls: ${showControls},
buffering: ${buffering},
locked: ${locked},
speedIndex: ${speedIndex},
fitIndex: ${fitIndex},
subtitleDelay: ${subtitleDelay},
position: ${position},
buffered: ${buffered},
selectedSubtitle: ${selectedSubtitle},
selectedTrack: ${selectedTrack},
subtitles: ${subtitles},
tracks: ${tracks}
    ''';
  }
}

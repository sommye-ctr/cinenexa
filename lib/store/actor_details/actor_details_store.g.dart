// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ActorDetailsStore on _ActorDetailsStore, Store {
  final _$baseModelAtom = Atom(name: '_ActorDetailsStore.baseModel');

  @override
  BaseModel get baseModel {
    _$baseModelAtom.reportRead();
    return super.baseModel;
  }

  @override
  set baseModel(BaseModel value) {
    _$baseModelAtom.reportWrite(value, super.baseModel, () {
      super.baseModel = value;
    });
  }

  final _$actorAtom = Atom(name: '_ActorDetailsStore.actor');

  @override
  People? get actor {
    _$actorAtom.reportRead();
    return super.actor;
  }

  @override
  set actor(People? value) {
    _$actorAtom.reportWrite(value, super.actor, () {
      super.actor = value;
    });
  }

  final _$creditsAtom = Atom(name: '_ActorDetailsStore.credits');

  @override
  ObservableList<BaseModel> get credits {
    _$creditsAtom.reportRead();
    return super.credits;
  }

  @override
  set credits(ObservableList<BaseModel> value) {
    _$creditsAtom.reportWrite(value, super.credits, () {
      super.credits = value;
    });
  }

  final _$_fetchActorDetailsAsyncAction =
      AsyncAction('_ActorDetailsStore._fetchActorDetails');

  @override
  Future<dynamic> _fetchActorDetails() {
    return _$_fetchActorDetailsAsyncAction
        .run(() => super._fetchActorDetails());
  }

  final _$_ActorDetailsStoreActionController =
      ActionController(name: '_ActorDetailsStore');

  @override
  void onItemClicked(BuildContext context, BaseModel baseModel) {
    final _$actionInfo = _$_ActorDetailsStoreActionController.startAction(
        name: '_ActorDetailsStore.onItemClicked');
    try {
      return super.onItemClicked(context, baseModel);
    } finally {
      _$_ActorDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
baseModel: ${baseModel},
actor: ${actor},
credits: ${credits}
    ''';
  }
}

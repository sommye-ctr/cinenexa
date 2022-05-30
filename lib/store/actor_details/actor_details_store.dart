import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/models/people.dart';
import 'package:watrix/services/requests.dart';

import '../../screens/details_page.dart';

part 'actor_details_store.g.dart';

class ActorDetailsStore extends _ActorDetailsStore with _$ActorDetailsStore {
  ActorDetailsStore({required BaseModel baseModel})
      : super(baseModel: baseModel);
}

abstract class _ActorDetailsStore with Store {
  @observable
  BaseModel baseModel;

  @observable
  People? actor;

  @observable
  ObservableList<BaseModel> credits = <BaseModel>[].asObservable();

  _ActorDetailsStore({
    required this.baseModel,
  }) {
    _fetchActorDetails();
  }

  @action
  Future _fetchActorDetails() async {
    Map obj = await Requests.getPeopleDetails(id: baseModel.id!);
    actor = obj['person'];
    credits.addAll(obj['credits']);
  }

  @action
  void onItemClicked(BuildContext context, BaseModel baseModel) {
    Navigator.pushNamed(
      context,
      DetailsPage.routeName,
      arguments: baseModel,
    );
  }
}

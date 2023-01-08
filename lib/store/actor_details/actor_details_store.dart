import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:cinenexa/models/local/enums/sort_movies.dart';
import 'package:cinenexa/models/network/enums/entity_type.dart';
import 'package:cinenexa/services/network/repository.dart';
import 'package:cinenexa/services/network/requests.dart';

import '../../models/network/base_model.dart';
import '../../models/network/people.dart';
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

  @observable
  ObservableList<BaseModel> topMovies = <BaseModel>[].asObservable();

  @observable
  ObservableList<BaseModel> topTv = <BaseModel>[].asObservable();

  _ActorDetailsStore({
    required this.baseModel,
  }) {
    _fetchActorDetails();
  }

  @action
  Future _fetchActorDetails() async {
    var value = await Future.wait([
      Repository.getPeopleDetails(id: baseModel.id!),
      Repository.discover(
        query: Requests.discover(
          type: EntityType.movie,
          withPeople: baseModel.id!.toString(),
          sortMoviesBy: SortMoviesBy.voteAverage,
        ),
        type: EntityType.movie,
      ),
    ]);
    actor = (value[0] as Map)['person'];
    credits.addAll((value[0] as Map)['credits']);
    topMovies.addAll(value[1] as List<BaseModel>);
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

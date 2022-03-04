import 'package:equatable/equatable.dart';

import '../services/entity_type.dart';
import '../services/requests.dart';

abstract class SearchPageState extends Equatable {
  final Future future;

  SearchPageState({Future? future})
      : this.future =
            future ?? Requests.titlesFuture(Requests.popular(EntityType.movie));

  @override
  List<Object?> get props => [future];
}

class SearchNotDone extends SearchPageState {
  SearchNotDone({Future? future})
      : super(
          future: future,
        );

  @override
  List<Object?> get props => super.props;
}

class SearchDone extends SearchPageState {
  final String searchTerm;

  SearchDone({required this.searchTerm, Future? future})
      : super(future: future);

  @override
  List<Object?> get props => [future, searchTerm];
}

enum SearchType {
  movie,
  tv,
  people,
}

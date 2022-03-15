import 'package:equatable/equatable.dart';

import '../../../models/discover.dart';

abstract class FiltersPageEvent extends Equatable {
  final Discover filters;

  FiltersPageEvent({required this.filters});

  @override
  List<Object?> get props => [filters];
}

class FiltersPageSortByChanged extends FiltersPageEvent {}

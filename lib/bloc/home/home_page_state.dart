import 'package:equatable/equatable.dart';
import 'package:watrix/bloc/home/home_page_event.dart';
import 'package:watrix/models/discover.dart';

abstract class HomePageState extends Equatable {
  final int index;
  final HomePageTabType type;

  HomePageState({required this.index, required this.type});

  @override
  List<Object?> get props => [
        index,
        type,
      ];
}

class HomePageInitial extends HomePageState {
  HomePageInitial({
    required int index,
    required HomePageTabType type,
  }) : super(index: index, type: type);
}

class HomePageFilterApplySuccess extends HomePageState {
  final Discover filters;

  HomePageFilterApplySuccess({
    required this.filters,
    required int index,
    required HomePageTabType type,
  }) : super(index: index, type: type);

  @override
  List<Object?> get props => [
        filters,
        index,
        type,
      ];
}

/* class HomePageFilterReset extends HomePageState {
  HomePageFilterReset({
    required int index,
    required HomePageTabType type,
  }) : super(index: index, type: type);
} */

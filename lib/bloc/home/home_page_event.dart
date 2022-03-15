import 'package:equatable/equatable.dart';
import 'package:watrix/models/discover.dart';

abstract class HomePageEvent extends Equatable {
  final int index;
  final HomePageTabType type;

  HomePageEvent({required this.index, required this.type});

  @override
  List<Object?> get props => [index, type];
}

class HomePageTabChanged extends HomePageEvent {
  HomePageTabChanged({required int index, required HomePageTabType type})
      : super(
          index: index,
          type: type,
        );

  @override
  List<Object?> get props => [
        index,
        type,
      ];
}

class HomePageFilterApplied extends HomePageEvent {
  final Discover discover;

  HomePageFilterApplied(
      {required this.discover,
      required int index,
      required HomePageTabType type})
      : super(
          index: index,
          type: type,
        );

  @override
  List<Object?> get props => [discover];
}

enum HomePageTabType {
  featured,
  movies,
  tv,
  list,
}

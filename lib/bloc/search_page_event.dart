import 'package:equatable/equatable.dart';
import 'package:watrix/bloc/search_page_state.dart';

abstract class SearchPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchClicked extends SearchPageEvent {}

class SearchBackClicked extends SearchPageEvent {}

class SearchTermChanged extends SearchPageEvent {
  final String searchTerm;

  SearchTermChanged({required this.searchTerm});

  @override
  List<Object?> get props => [searchTerm];
}

class SearchTypeChanged extends SearchPageEvent {
  final int index;
  final SearchType searchType;

  SearchTypeChanged({
    required this.index,
    required this.searchType,
  });

  @override
  List<Object?> get props => [index];
}

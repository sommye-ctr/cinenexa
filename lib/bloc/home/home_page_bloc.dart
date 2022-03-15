import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watrix/bloc/home/home_page_state.dart';
import 'package:watrix/bloc/home/home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(HomePageTabType type)
      : super(HomePageInitial(index: 0, type: type)) {
    on<HomePageTabChanged>(_tabChanged);
    on<HomePageFilterApplied>(_filterApplied);
  }

  _tabChanged(HomePageTabChanged event, Emitter<HomePageState> emit) {
    emit(HomePageInitial(index: event.index, type: event.type));
  }

  _filterApplied(HomePageFilterApplied event, Emitter<HomePageState> emit) {
    emit(HomePageFilterApplySuccess(
        filters: event.discover, index: event.index, type: event.type));
  }
}

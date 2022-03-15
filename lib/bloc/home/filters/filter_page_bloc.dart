import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watrix/bloc/home/filters/filter_page_state.dart';
import 'package:watrix/bloc/home/filters/filter_page_event.dart';
import 'package:watrix/bloc/home/home_page_bloc.dart';

class FiltersPageBloc extends Bloc<FiltersPageEvent, FiltersPageState> {
  HomePageBloc? homePageBloc;
  FiltersPageBloc(FiltersPageState initialState, {this.homePageBloc}) : super(initialState);

  void ss(){
    homePageBloc.
  }
}

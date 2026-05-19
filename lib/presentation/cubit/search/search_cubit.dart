import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/presentation/cubit/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  final TextEditingController searchController = TextEditingController(text: 'UX Design');

  void onKeywordChanged(String value) => emit(state.copyWith(keyword: value));
  void onSortChanged(String value) => emit(state.copyWith(sort: value));
  void onLevelChanged(String value) => emit(state.copyWith(level: value));

  void applyFilter({String? topic, double? rating, String? level}) {
    emit(state.copyWith(topic: topic, minRating: rating, level: level ?? state.level));
  }

  void clearFilter() => emit(state.copyWith(clearTopic: true, clearRating: true, level: 'all'));

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}

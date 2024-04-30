import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/data/model/Movies/movies_model.dart';
import 'package:moviesapp/repository/movies/movies_repo_imp.dart';
import 'package:moviesapp/utils/helper.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final _moviesRepo = MovieRepoImp();
  int page = 1;
  bool haveMoreData = false;

  MoviesBloc() : super(MoviesInitial()) {
    on<MoviesFetchDataPaginationEvent>(_fetchMoviesListPagination);
  }

  FutureOr<void> _fetchMoviesListPagination(
      MoviesEvent event, Emitter<MoviesState> emit) async {
    if (event is MoviesFetchDataPaginationEvent) {
      final cachedData =
          await ApiCacheHelper.getJsonResponse('movies/${event.moviesType}');
      emit(MoviesPageLoadingMore());
      if (cachedData != null) {
        final data = MoviesModel.fromJson(cachedData);
        emit(MoviesPageLoaded(data));
      } else {
        await _moviesRepo
            .getMoviesPaginationData(event.moviesType, page)
            .onError(
                (error, stackTrace) => emit(MoviesPageError(error.toString())))
            .then((value) {
          if (value.success!) {
            emit(MoviesPagingLoaded(value));
          } else {
            emit(MoviesPageError(value.statusmessage!));
          }
        });
      }
    }
  }
}

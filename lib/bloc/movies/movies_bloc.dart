import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/data/model/Movies/movies_model.dart';
import 'package:moviesapp/repository/movies/movies_repo_imp.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, NewsState> {
  final _newsRepo = MovieRepoImp();
  int page = 1;
  bool haveMoreData = false;

  MoviesBloc() : super(MoviesInitial()) {
    on<MoviesFetchDataPaginationEvent>(_fetchMoviesListPagination);
  }

  FutureOr<void> _fetchMoviesListPagination(
      MoviesEvent event, Emitter<NewsState> emit) async {
    if (event is MoviesFetchDataPaginationEvent) {
      if (page == 1) {
        emit(MoviesPageLoadingMore());
      }
      await _newsRepo
          .getMoviesPaginationData(event.moviesType, page)
          .onError(
              (error, stackTrace) => emit(MoviesPageError(error.toString())))
          .then((value) {
        MoviesModel moviesList = MoviesModel.fromJson(value);
        if (moviesList.success!) {
          emit(MoviesMorePageLoaded(moviesList));
          page++;
        } else {
          emit(MoviesPageError(moviesList.status_message!));
        }
      });
    }
  }
}

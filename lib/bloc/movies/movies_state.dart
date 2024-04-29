part of 'movies_bloc.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesPageLoading extends MoviesState {}

class MoviesPageLoadingMore extends MoviesState {}

class MoviesPageLoaded extends MoviesState {
  late final MoviesModel data;
  MoviesPageLoaded(this.data);
}

class MoviesPagingLoaded extends MoviesState {
  late final MoviesModel data;
  MoviesPagingLoaded(this.data);
}

class MoviesMorePageLoaded extends MoviesState {
  late final MoviesModel data;
  MoviesMorePageLoaded(this.data);
}

class MoviesPageError extends MoviesState {
  late final String errorMessage;
  MoviesPageError(this.errorMessage);
}

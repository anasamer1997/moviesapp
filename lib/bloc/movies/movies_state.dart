part of 'movies_bloc.dart';

@immutable
abstract class NewsState {}

class MoviesInitial extends NewsState {}

class MoviesPageLoading extends NewsState {}

class MoviesPageLoadingMore extends NewsState {}

class MoviesPageLoaded extends NewsState {
  late final MoviesModel data;
  MoviesPageLoaded(this.data);
}

class MoviesPagingLoaded extends NewsState {
  late final MoviesModel data;
  MoviesPagingLoaded(this.data);
}

class MoviesMorePageLoaded extends NewsState {
  late final MoviesModel data;
  MoviesMorePageLoaded(this.data);
}

class MoviesPageError extends NewsState {
  late final String errorMessage;
  MoviesPageError(this.errorMessage);
}

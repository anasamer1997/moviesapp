part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class MoviesFetchDataPaginationEvent extends MoviesEvent {
  final String moviesType;
  MoviesFetchDataPaginationEvent(this.moviesType);
}

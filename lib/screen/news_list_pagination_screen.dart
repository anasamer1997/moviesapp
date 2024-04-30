import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesapp/bloc/movies/movies_bloc.dart';
import 'package:moviesapp/data/model/Movies/movies_model.dart';
import 'package:moviesapp/screen/movie_detailes_screen.dart';

class MoviesListPaginationScreen extends StatefulWidget {
  static const String id = "movies_list_pagination_screen";

  const MoviesListPaginationScreen({Key? key}) : super(key: key);

  @override
  State<MoviesListPaginationScreen> createState() =>
      _MoviesListPaginationScreenState();
}

class _MoviesListPaginationScreenState
    extends State<MoviesListPaginationScreen> {
  late MoviesBloc _moviesBloc;
  String moviesType = "day";
  List<Result> _moviesList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print("initState");
    _moviesBloc = BlocProvider.of(context);
    _moviesBloc.add(MoviesFetchDataPaginationEvent(moviesType));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        bloc: _moviesBloc,
        builder: (context, state) {
          if (state is MoviesPageLoadingMore) {
            _moviesList = [];
            return const Center(child: CircularProgressIndicator());
          } else if (state is MoviesPageError) {
            return Text(state.errorMessage);
          } else if (state is MoviesPagingLoaded) {
            _moviesList.addAll(state.data.results);
          }
          return _moviesistView();
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (_moviesBloc.page > 1) {
                _moviesBloc.page -= 1;
                _moviesBloc.add(MoviesFetchDataPaginationEvent(moviesType));
              }
            },
            heroTag: null,
            tooltip: "previous",
            child: const Icon(Icons.arrow_left),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              _moviesBloc.page += 1;
              _moviesBloc.add(MoviesFetchDataPaginationEvent(moviesType));
            },
            heroTag: null,
            tooltip: "next",
            child: const Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }

  Widget _moviesistView() {
    return ListView(
      controller: _scrollController
        ..addListener(() {
          if (_scrollController.offset ==
                  _scrollController.position.maxScrollExtent &&
              _moviesBloc.haveMoreData) {
            _moviesBloc.haveMoreData = false;
            _moviesBloc.add(MoviesFetchDataPaginationEvent(moviesType));
          }
        }),
      children: [
        ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: _moviesList.length,
          itemBuilder: (context, index) {
            return _moviesListItems(_moviesList[index], index);
          },
        ),
        _moviesBloc.haveMoreData ? _bottomLoaderView() : Container()
      ],
    );
  }

  Widget _moviesListItems(Result movie, int index) {
    return Card(
      child: ListTile(
        title: Text(
          movie.title,
        ),
        subtitle: Text(movie.mediaType),
        trailing: Text(movie.releaseDate),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieDetailesScreen(movie: movie),
          ));
        },
      ),
    );
  }

  Widget _bottomLoaderView() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(color: Colors.red),
      ),
    );
  }
}

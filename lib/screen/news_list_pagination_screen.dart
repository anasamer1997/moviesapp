import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesapp/bloc/movies/movies_bloc.dart';
import 'package:moviesapp/data/model/Movies/movies_model.dart';

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
  final List<Result> _moviesList = [];
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
              return const CircularProgressIndicator();
            } else if (state is MoviesPageError) {
              return Text(state.errorMessage);
            } else if (state is MoviesMorePageLoaded) {
              _moviesList.addAll(state.data.results);
              if (_moviesList.length >= state.data.totalResults) {
                _moviesBloc.haveMoreData = false;
              } else {
                _moviesBloc.haveMoreData = true;
              }
            }
            return _moviesistView();
          },
        ));
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
        leading: const CircleAvatar(),
        title: Text(
          movie.title,
        ),
        subtitle: Text(movie.originalName),
        onTap: () {
          // Navigator.of(context, rootNavigator: true)
          //     .pushNamed(NewsDetailScreen.id, arguments: article);
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

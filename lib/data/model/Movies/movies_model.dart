import 'dart:convert';

class MoviesModel {
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;
  final bool? success;
  final String? status_message;

  MoviesModel(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults,
      this.success = true,
      this.status_message = ''});

  factory MoviesModel.fromRawJson(String str) =>
      MoviesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
      page: json["page"],
      results: json["results"] == null
          ? []
          : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      totalPages: json["total_pages"] ?? 0,
      totalResults: json["total_results"] ?? 0,
      success: json['success'] ?? true,
      status_message: json['status_message'] ?? '');

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  final String backdropPath;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String mediaType;
  final bool adult;
  final String name;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final DateTime firstAirDate;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;
  final String originalTitle;
  final String title;
  final DateTime releaseDate;
  final bool video;

  Result({
    required this.backdropPath,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.name,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
    required this.originalTitle,
    required this.title,
    required this.releaseDate,
    required this.video,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        adult: json["adult"],
        name: json["name"],
        originalLanguage: json["original_language"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalTitle: json["original_title"],
        title: json["title"],
        releaseDate: DateTime.parse(json["release_date"]),
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "adult": adult,
        "name": name,
        "original_language": originalLanguage,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_title": originalTitle,
        "title": title,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "video": video,
      };
}

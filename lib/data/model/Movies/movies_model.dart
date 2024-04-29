import 'dart:convert';

class MoviesModel {
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;
  final bool? success;
  final String? statusmessage;

  MoviesModel(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults,
      this.success = true,
      this.statusmessage = ''});

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
      statusmessage: json['status_message'] ?? '');

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
  final String? overview;
  final String mediaType;
  final bool adult;
  final String? name;
  final String originalLanguage;
  final List<int> genreIds;
  final String? originalTitle;
  final String title;
  final String releaseDate;

  Result({
    required this.backdropPath,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.mediaType,
    required this.adult,
    required this.name,
    required this.originalLanguage,
    required this.genreIds,
    required this.originalTitle,
    required this.title,
    required this.releaseDate,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        overview: json["overview"] ?? '',
        mediaType: json["media_type"],
        adult: json["adult"],
        name: json["name"],
        originalLanguage: json["original_language"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalTitle: json["original_title"] ?? '',
        title: json["title"],
        releaseDate: json["release_date"] ?? '',
        originalName: json['original_name'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "original_name": originalName,
        "overview": overview,
        "media_type": mediaType,
        "adult": adult,
        "name": name,
        "original_language": originalLanguage,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "original_title": originalTitle,
        "title": title,
      };
}

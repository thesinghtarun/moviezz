class ActorsOfMovie {
  final int id;
  final List<MovieCast> cast;

  ActorsOfMovie({
    required this.id,
    required this.cast,
  });

  factory ActorsOfMovie.fromJson(Map<String, dynamic> json) {
    return ActorsOfMovie(
      id: json['id'],
      cast: List<MovieCast>.from(json['cast'].map((x) => MovieCast.fromJson(x))),
    );
  }
}

class MovieCast {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;

  MovieCast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory MovieCast.fromJson(Map<String, dynamic> json) {
    return MovieCast(
      adult: json['adult'],
      gender: json['gender'],
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      originalName: json['original_name'],
      popularity: json['popularity'].toDouble(),
      profilePath: json['profile_path'] ?? '',
      castId: json['cast_id'],
      character: json['character'],
      creditId: json['credit_id'],
      order: json['order'],
    );
  }
}
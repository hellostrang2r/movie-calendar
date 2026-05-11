class Movie {
  const Movie({
    required this.movieCd,
    required this.title,
    required this.openDate,
    required this.genre,
    required this.nation,
    required this.director,
    this.isReRelease = false,
    this.posterUrl,
    this.overview,
  });

  final String movieCd;
  final String title;
  final DateTime openDate;
  final String genre;
  final String nation;
  final String director;
  final bool isReRelease;
  final String? posterUrl;
  final String? overview;
}

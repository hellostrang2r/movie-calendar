import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMoviesByMonth(DateTime firstDay, DateTime lastDay);
}

List<Movie> _moviesFromJson(String body) {
  final List<dynamic> data = jsonDecode(body);

  return data.map((json) {
    return Movie(
      movieCd: json['movieCd'] as String,
      title: json['movieNm'] as String,
      openDate: DateTime.parse(json['openDt'] as String),
      genre: json['genreNm'] as String? ?? '기타',
      nation: json['nationAlt'] as String? ?? '미상',
      director: json['director'] as String? ?? '정보 없음',
      isReRelease: json['isReRelease'] as bool? ?? false,
      posterUrl: json['posterUrl'] as String?,
      overview: json['overview'] as String?,
    );
  }).toList();
}

List<Movie> _filterMoviesByRange(
  List<Movie> movies,
  DateTime firstDay,
  DateTime lastDay,
) {
  return movies.where((movie) {
    final d = movie.openDate;
    final afterOrSame = !d.isBefore(
      DateTime(firstDay.year, firstDay.month, firstDay.day),
    );
    final beforeOrSame = !d.isAfter(
      DateTime(lastDay.year, lastDay.month, lastDay.day),
    );
    return afterOrSame && beforeOrSame;
  }).toList();
}

Future<List<Movie>> _loadBundledMoviesByMonth(
  DateTime firstDay,
  DateTime lastDay,
) async {
  final body = await rootBundle.loadString('data/movies.json');
  return _filterMoviesByRange(_moviesFromJson(body), firstDay, lastDay);
}

class MockMovieRepository implements MovieRepository {
  @override
  Future<List<Movie>> fetchMoviesByMonth(
    DateTime firstDay,
    DateTime lastDay,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final sample = <Movie>[
      Movie(
        movieCd: '20260001',
        title: '봄의 장면',
        openDate: DateTime(firstDay.year, firstDay.month, 2),
        genre: '드라마',
        nation: '한국',
        director: '김다온',
      ),
      Movie(
        movieCd: '20260002',
        title: '문라이트 시티',
        openDate: DateTime(firstDay.year, firstDay.month, 2),
        genre: '로맨스',
        nation: '한국',
        director: '이서현',
      ),
      Movie(
        movieCd: '20260003',
        title: '심연의 항해',
        openDate: DateTime(firstDay.year, firstDay.month, 8),
        genre: '스릴러',
        nation: '미국',
        director: 'Daniel Hart',
      ),
      Movie(
        movieCd: '20260004',
        title: '낮과 밤 사이',
        openDate: DateTime(firstDay.year, firstDay.month, 8),
        genre: '미스터리',
        nation: '한국',
        director: '박예준',
      ),
      Movie(
        movieCd: '20260005',
        title: '소년과 별',
        openDate: DateTime(firstDay.year, firstDay.month, 14),
        genre: '애니메이션',
        nation: '일본',
        director: 'Aoi Tanaka',
      ),
      Movie(
        movieCd: '20260006',
        title: '리와인드 1999',
        openDate: DateTime(firstDay.year, firstDay.month, 18),
        genre: 'SF',
        nation: '영국',
        director: 'Emily Rose',
      ),
      Movie(
        movieCd: '20260007',
        title: '클래식 리마스터',
        openDate: DateTime(firstDay.year, firstDay.month, 18),
        genre: '드라마',
        nation: '프랑스',
        director: 'Jean Moreau',
        isReRelease: true,
      ),
      Movie(
        movieCd: '20260008',
        title: '도시의 초상',
        openDate: DateTime(firstDay.year, firstDay.month, 24),
        genre: '독립영화',
        nation: '한국',
        director: '최민석',
      ),
      Movie(
        movieCd: '20260009',
        title: '한여름의 끝',
        openDate: DateTime(firstDay.year, firstDay.month, 24),
        genre: '멜로',
        nation: '한국',
        director: '정하린',
      ),
      Movie(
        movieCd: '20260010',
        title: '라스트 스테이션',
        openDate: DateTime(firstDay.year, firstDay.month, 24),
        genre: '액션',
        nation: '미국',
        director: 'Chris Nolan Jr.',
      ),
      Movie(
        movieCd: '20260011',
        title: '하늘 아래 우리',
        openDate: DateTime(firstDay.year, firstDay.month, 30),
        genre: '다큐멘터리',
        nation: '한국',
        director: '윤세아',
      ),
    ];

    return _filterMoviesByRange(sample, firstDay, lastDay);
  }
}

class GithubMovieRepository implements MovieRepository {
  final String url =
      'https://raw.githubusercontent.com/hellostrang2r/movie-calendar/main/data/movies.json';

  @override
  Future<List<Movie>> fetchMoviesByMonth(
    DateTime firstDay,
    DateTime lastDay,
  ) async {
    try {
      final response = await http
          .get(Uri.parse('$url?t=${DateTime.now().millisecondsSinceEpoch}'))
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        return _filterMoviesByRange(
          _moviesFromJson(response.body),
          firstDay,
          lastDay,
        );
      }
    } catch (_) {
      // Fall back to the bundled data below.
    }

    return _loadBundledMoviesByMonth(firstDay, lastDay);
  }
}

class LocalMovieRepository implements MovieRepository {
  @override
  Future<List<Movie>> fetchMoviesByMonth(
    DateTime firstDay,
    DateTime lastDay,
  ) async {
    try {
      final localDataUri = kIsWeb
          ? Uri.base.resolve(
              'data/movies.json?t=${DateTime.now().millisecondsSinceEpoch}',
            )
          : Uri.parse(
              'http://localhost:8000/data/movies.json?t=${DateTime.now().millisecondsSinceEpoch}',
            );
      final response = await http
          .get(localDataUri)
          .timeout(const Duration(milliseconds: 500));

      if (response.statusCode == 200) {
        return _filterMoviesByRange(
          _moviesFromJson(response.body),
          firstDay,
          lastDay,
        );
      }
    } catch (_) {
      // Fall back to the bundled data below.
    }

    return _loadBundledMoviesByMonth(firstDay, lastDay);
  }
}

import 'dart:async';
import 'package:my_tmdb/resources/movie_api_provider.dart';
import 'package:my_tmdb/models/item_model.dart';
import 'package:my_tmdb/models/trailer_model.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) =>
      moviesApiProvider.fetchTrailer(movieId);
}

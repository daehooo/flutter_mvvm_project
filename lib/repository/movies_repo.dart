import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/service/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;
  MoviesRepository(this._apiService);

  Future<List<MovieModel>> fetchMovies({int page =1}) async {
    return await _apiService.fetchMovies(page: page);
  }

  // List<MovieGenre> cachedGenres = [];

  Future<List<MovieGenre>> fetchGenres() async {
    return await _apiService.fetchGenres();
    // return cachedGenres = await _apiService.fetchGenres();
  
  }
}


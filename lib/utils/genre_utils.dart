import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';

class GenreUtils {
  static List<MovieGenre> movieGenresNames(List<int> genresId) {
    final movieRepository = getIt<MoviesRepository>();
    final cachedGenres = [];
    // TODO: We need to get the correct cached genres
    List<MovieGenre> genresNames = [];
    for(var genreId in genresId) {
      var genre = cachedGenres.firstWhere((g) => g.id == genreId, orElse: () => MovieGenre(id: 5448484, name: 'Unkown'));
      genresNames.add(genre);
    }
    return genresNames;
  }
}
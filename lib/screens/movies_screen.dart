import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/screens/favorite_screen.dart';

import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {


  final List<MovieModel> _movies = [];
  int _currentPage = 1;
  bool _isFetching = false;
  final ScrollController _scrollController= ScrollController();

  void _onScroll(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isFetching) {
        _fetchMovies();

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchMovies();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchMovies() async {
    if(_isFetching) return;
    setState((){
      _isFetching = true;
    });
    
    try {
      final List<MovieModel> movies = await getIt<MoviesRepository>().fetchMovies();
      setState(() {
        _movies.addAll(movies);
        _currentPage++;
      });
    } catch (error) {
      getIt<NavigationService>().showSnackbar("Error fetching movies: $error");
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
    }

    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies",),
        actions: [
          IconButton(
            onPressed: (){
              // getIt<NavigationService>().showDialog(FavoriteScreen());
              getIt<NavigationService>().navigate(const FavoriteScreen());
              // getIt<NavigationService>().showSnackbar();              
              },
            icon: const Icon(
              MyAppIcons.favoriteRounded,
              color: Colors.red,
            ),
          ),
            IconButton(
            onPressed: () async {
                 final List<MovieGenre> genres = await getIt<MoviesRepository>().fetchGenres();
              log("Genres are $genres");
             },
            icon: const Icon(
                MyAppIcons.darkMode,
            ),
          ),
        // Text(movieName),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _movies.length + (_isFetching ? 1 : 0),
        itemBuilder: (context, index) {
          if(index < _movies.length) {
            return  MoviesWidget(
              movieModel: _movies[index],
            );
           } else {
            return const CircularProgressIndicator.adaptive();
          }
      }),
    );
  }
}

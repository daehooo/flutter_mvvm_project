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

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

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
       
        itemCount: 10,
        itemBuilder: (context, index) {
            return  MoviesWidget(
            );

      }),
    );
  }
}
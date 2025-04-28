import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/constants/theme_data.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/screens/favorite_screen.dart';

import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // themeProvider.themeData;
    // final themeProvider = ThemeProvider.


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
            Consumer(
              builder: (context, ThemeProvider themeProvider, child) {
                return IconButton(
                  onPressed: () async {
                    themeProvider.toggleTheme();
                  },
                  icon:  Icon(
                    themeProvider.themeData == MyThemeData.darkTheme ? MyAppIcons.darkMode:
                    MyAppIcons.lightMode,

                  ),
                );
              },
              child: Text("Theme mode",),
            ),
        // Text(movieName),
        ],
      ),
      body: Consumer(
        builder: (context, MoviesProvider moviesProvider, child) {
          if(moviesProvider.isLoading && moviesProvider.moviesList.isEmpty) {
            return Center(child: CircularProgressIndicator.adaptive(),);
          } else if(moviesProvider.fetchMoviesError.isNotEmpty) {
            Center(child: Text(moviesProvider.fetchMoviesError),);
          }
          return NotificationListener(
            
            onNotification: (ScrollNotification scrollInfo) {
              if(scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !moviesProvider.isLoading) {
                moviesProvider.getMovies();
                return true;
              }
              return false;
            },
            child: ListView.builder( 
            itemCount: moviesProvider.moviesList.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: moviesProvider.moviesList[index],
                child: const MoviesWidget());
            },
          ),
          );
        },
      ),
    );
  }
}
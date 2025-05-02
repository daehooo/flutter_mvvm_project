import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:mvvm_statemanagements/screens/favorite_screen.dart';

import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/viewmodel/theme_provider.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';

class MovieScreen extends ConsumerWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider.notifier);

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
                await ref.read(themeProvider.notifier).toggleTheme();
             },
            icon:  Icon(
              themeState == ThemeEnums.dark ?  MyAppIcons.darkMode : MyAppIcons.lightMode,

            ),
          ),
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
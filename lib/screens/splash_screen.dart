import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


    Future<void> loadInitialData(BuildContext context) async {
      await Future.microtask(() async {
        if(!context.mounted) return;
        await Provider.of<MoviesProvider>(context, listen:  false).getMovies();
      });

      }
 @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);


    return Scaffold(
      body: 
          FutureBuilder(future: loadInitialData(context), builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator.adaptive();
            } else if (snapshot.hasError) {
              if(moviesProvider.genresList.isNotEmpty) {
                 WidgetsBinding.instance.addPostFrameCallback((_) { 
              getIt<NavigationService>().navigateReplace(const MovieScreen());
            }); 
              }
              return 
              Provider.of<MoviesProvider>(context).isLoading ? Center(child: CircularProgressIndicator.adaptive(),) : 

              MyErrorWidget(errorText: snapshot.error.toString(), retryFunction: ()async {
                loadInitialData(context);
              });
            } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<MoviesProvider>(context, listen: false).getMovies(); 
              getIt<NavigationService>().navigateReplace(const MovieScreen());
            }); 
              return SizedBox.shrink();
            }
          })

      // true ? const Center(child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //   Text("Loading...",),
      //   SizedBox(height: 20,),
      //   CircularProgressIndicator.adaptive(),
      // ],),) : 
      // MyErrorWidget(errorText: '_errorMessage', retryFunction: (){},),
    );
  }
}
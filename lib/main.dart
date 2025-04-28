import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_statemanagements/screens/splash_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';
import 'package:provider/provider.dart';


void main()  {
  setupLocator();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

    ]).then((_) async {
      await dotenv.load(fileName: "assets/.env");
       runApp( const MyApp());
    });
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider<MoviesProvider>(
            create: (_) => MoviesProvider(),  
          ),
          ChangeNotifierProvider<FavoritesProvider>(
            create: (_) => FavoritesProvider(),
          ),

        ],
        child: Consumer(
          builder: (context, ThemeProvider themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: getIt<NavigationService>().navigatorKey,
              title: 'Movies App',
              theme: themeProvider.themeData,
              home: const SplashScreen(),
            );
          },
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_statemanagements/constants/theme_data.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/screens/splash_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';


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

  // final navigationKey = NavigationService().navigatorKey;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: getIt<NavigationService>().navigatorKey,
      title: 'Movies App',
      theme: MyThemeData.lightTheme,
      home: const SplashScreen(),
    );
  }
}

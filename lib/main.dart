import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/constants/theme_data.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/viewmodel/theme_provider.dart';


void main()  {
  setupLocator();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

    ]).then((_) async {
      await dotenv.load(fileName: "assets/.env");
       runApp( 
        const ProviderScope(
          child: MyApp()
        )
       );

    });
}

class MyApp extends ConsumerWidget {
   const MyApp({super.key});

  // final navigationKey = NavigationService().navigatorKey;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: getIt<NavigationService>().navigatorKey,
      title: 'Movies App',
      theme: themeState == ThemeEnums.dark ? MyThemeData.darkTheme : MyThemeData.lightTheme,
      home: const MovieScreen(),
    );
  }
}

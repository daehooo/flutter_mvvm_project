import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _isLoading = true;
  String _errorMessage = '';
  final _movieRepository = getIt<MoviesRepository>();


  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });
    try {
      await _movieRepository.fetchGenres();
      await getIt<NavigationService>().navigateReplace(const MoviesScreen());
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      _isLoading ? const Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("Loading...",),
        SizedBox(height: 20,),
        CircularProgressIndicator.adaptive(),
      ],),) : 
      MyErrorWidget(errorText: _errorMessage, retryFunction: _loadData,),
    );
  }
}
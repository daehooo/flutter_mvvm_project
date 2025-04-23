import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      true ? const Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("Loading...",),
        SizedBox(height: 20,),
        CircularProgressIndicator.adaptive(),
      ],),) : 
      MyErrorWidget(errorText: '_errorMessage', retryFunction: (){},),
    );
  }
}
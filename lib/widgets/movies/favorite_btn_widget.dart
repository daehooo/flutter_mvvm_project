import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';


class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      // TODO: Implement the favorite logic
    }, 
    icon: const Icon(
      MyAppIcons.favoriteRounded,
      color: null,
      size: 20,
    ),
    );
  }
}
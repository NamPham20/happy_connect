import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadDataSignIn extends ConsumerStatefulWidget{
   LoadDataSignIn({super.key, required this.request});
  Map<String,String>  request;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoadDataSignInState();

}

class LoadDataSignInState extends ConsumerState<LoadDataSignIn>{
  @override
  Widget build(BuildContext context) {
   return SafeArea(
       child: Scaffold(
          body: ,
      )
   );
  }
}


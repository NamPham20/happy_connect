import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_connect/views/sign_in_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  // Tìm camera trước (selfie)
  CameraDescription? frontCamera;
  for (var camera in cameras) {
    if (camera.lensDirection == CameraLensDirection.front) {
      frontCamera = camera;
      break;
    }
  }
  final selectedCamera = frontCamera ?? cameras.first;
  runApp( ProviderScope(child: MyApp(camera: selectedCamera,)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.camera});
  final CameraDescription camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  SignInPage(camera: camera,),
    );
  }
}



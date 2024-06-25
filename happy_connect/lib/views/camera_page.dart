import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';


final showImageProvider = StateProvider<bool>((ref) {
  return false;
});

final imagePickedProvider = StateProvider<XFile?>((ref) {
  return null;
});

final isHorizontalProvider = StateProvider<bool>((ref) {
  return false;
});


class CameraPage extends ConsumerStatefulWidget{

  final CameraDescription camera;

  const CameraPage({super.key, required this.camera});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CameraPageState();
}

class CameraPageState  extends ConsumerState<CameraPage>{

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool showImage = false;
  XFile? imagePicked ;
  bool _isHorizontal = false;
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    //camera
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();

    // Bắt đầu lắng nghe sự kiện từ cảm biến gia tốc
    _streamSubscription= accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        // Kiểm tra nếu thiết bị nằm ngang (landscape)
        if (event.x.abs() > 5) {
          _isHorizontal = true;
        } else {
          _isHorizontal = false;
        }
      });
    });
  }




  @override
  void dispose() {
    _controller.dispose();
    _streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    showImage = ref.watch(showImageProvider);
    imagePicked = ref.watch(imagePickedProvider);

   return Scaffold(
     appBar: AppBar(
       title: const Text("Chấm công", style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
       centerTitle: true,
       backgroundColor: Colors.red,
     ),
     body: FutureBuilder<void>(
       future: _initializeControllerFuture,
       builder: (context, snapshot) {
         if (snapshot.connectionState == ConnectionState.done) {
           return Stack(
               children:[
             Container(
               margin: const EdgeInsets.all(4),
               padding: const EdgeInsets.all(4),
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 color: Colors.white
               ),
               child: Column(
                 children: [
                   ClipRRect(
                       borderRadius: BorderRadius.circular(12),
                       child: CameraPreview(_controller),
                   ),
                   Expanded(
                     child: Center(
                       child: Row(
                         children: [
                           const Spacer(flex: 1,),
                           IconButton(
                               onPressed: () async{
                                 try {
                                   await _initializeControllerFuture;
                                   final image = await _controller.takePicture();
                                   ref.read(imagePickedProvider.notifier).state = image;
                                 } catch (e) {
                                   print(e);
                                 }
                                 ref.read(showImageProvider.notifier).state = !showImage;
                               },
                               style: IconButton.styleFrom(
                                 backgroundColor: Colors.red
                               ),
                               icon: const Icon(
                                 Icons.camera_alt_outlined,
                                 color: Colors.white,
                                 size: 50,
                               )
                           ),
                           Expanded(
                             flex: 1,
                               child: Center(
                                 child: Container(
                                   height: 120,
                                   width: 60,
                                   color: Colors.red,
                                 ),
                               )
                           )
                         ],
                       ),
                     ),
                   )

                 ],
               ),
             ),
                 if(!_isHorizontal) Positioned(
                   bottom: 0,
                     child: Container(
                       height: MediaQuery.of(context).size.height*0.4,
                         width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                         borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.5), // Màu và độ mờ của bóng
                             spreadRadius: 3, // Bán kính lan rộng của bóng
                             blurRadius: 7, // Độ mờ của bóng
                             offset: const Offset(0, 3), // Độ lệch của bóng
                           ),
                         ],
                       ),
                       child: const Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Hướng dẫn chụp", style: TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.w500,
                             color: Colors.black
                           ),),
                           Text("Vui lòng quay ngang điện thoại để chụp ảnh", style: TextStyle(
                               fontSize: 18,
                               color: Colors.black
                           ),),
                           Text("(Chú ý : Chấm công 2 lần như truyền thống )", style: TextStyle(
                               fontSize: 14,
                               color: Colors.black
                           ),),
                         ],
                       ),
                     )
                 ),
             if(showImage) Container(
               margin: const EdgeInsets.all(4),
               padding: const EdgeInsets.all(4),
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12),
                   color: Colors.white
               ),
               child: Column(
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(12),
                     child: Transform(
                       alignment: Alignment.center,
                       transform: Matrix4.rotationY(3.14159),
                         child: Image.file(File(imagePicked!.path)))
                   ),
                   Expanded(
                     child: Center(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           IconButton(
                               onPressed: () {
                                 ref.read(showImageProvider.notifier).state = !showImage;
                               },
                               style: IconButton.styleFrom(
                                   backgroundColor: Colors.red
                               ),
                               icon: const Icon(
                                 Icons.cancel_outlined,
                                 color: Colors.white,
                                 size: 50,
                               )
                           ),
                           IconButton(
                               onPressed: () {
                               },
                               style: IconButton.styleFrom(
                                   backgroundColor: Colors.red
                               ),
                               icon: const Icon(
                                 Icons.send,
                                 color: Colors.white,
                                 size: 50,
                               )
                           ),
                       
                         ],
                       ),
                     ),
                   )

                 ],
               ),
             )
             
              ]
           );
         } else {
           return const Center(child: CircularProgressIndicator());
         }
       },
     ),
   );
  }
}
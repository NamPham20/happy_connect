import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_connect/provider/pick_image_provider.dart';
import 'package:happy_connect/views/account_page.dart';
import 'package:happy_connect/views/camera_page.dart';
import 'package:happy_connect/views/sample_image.dart';


final selectedProvider = StateProvider<int>((ref) {
  return 0;
});


class MainPage extends ConsumerStatefulWidget{
  const MainPage({super.key, required this.camera});
  final CameraDescription camera;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MainPageState();
  
}

class MainPageState extends ConsumerState<MainPage>{

  int selected = 0;
  XFile? imageSelected ;
  @override
  Widget build(BuildContext context) {
    selected = ref.watch(selectedProvider);
    imageSelected = ref.watch(imagePickerProvider);
   return Scaffold(
     body: displayPage(selected),
     bottomNavigationBar:
       BottomAppBar(
         elevation: 12,
       shadowColor: Colors.grey,
       notchMargin: 14,
       shape: const CircularNotchedRectangle(),
       height: 100,
       color: Colors.white,
       child: Row(
         children: [
           const SizedBox(width: 22,),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               IconButton(
                   onPressed: (){
                     ref.read(selectedProvider.notifier).state = 0;
                   },
                   icon:  Icon(
                     Icons.image_outlined,
                     color: selected==0 ? Colors.red: Colors.grey,
                   ),
               ),
                Text("Ảnh mẫu",
                 style: TextStyle(
                   color: selected==0 ? Colors.red: Colors.grey,
               ),)
             ],
           ),
           const Spacer(),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               IconButton(
                 onPressed: (){
                   ref.read(selectedProvider.notifier).state = 1;
                 },
                 icon:  Icon(
                     Icons.person_outline,
                   color: selected==1 ? Colors.red: Colors.grey,
                 ),
               ),
                Text("Tài khoản",
                 style: TextStyle(
                     color: selected ==1 ? Colors.red: Colors.grey,
                 ),)
             ],
           ),
           const SizedBox(width: 22,),
         ],
       )
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     floatingActionButton: FloatingActionButton(
       elevation: 8,
       backgroundColor: Colors.red,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(40)
       ), onPressed: () async{
      // await ref.read(imagePickerProvider.notifier).pickImageFromCamera();
       Navigator.push(context, MaterialPageRoute(builder: (context)=> CameraPage(camera: widget.camera)));
     },
       child: const Icon(Icons.camera_alt_outlined,color: Colors.white,),
     ),
   );
  }

  Widget displayPage(int selected) {
    switch(selected){
      case 0 : return const SampleImage();
      case 1 : return const AccountPage();
      case 3 : return CameraPage(camera: widget.camera);
      default : return const Center(child: Text("Có lỗi xảy ra , xin thử lại sau"),);
    }
  }
}
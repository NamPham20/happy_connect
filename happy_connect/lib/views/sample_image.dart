import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../custom_paint/draw_header.dart';

class SampleImage extends ConsumerStatefulWidget{
  const SampleImage({super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SampleImageState();
}

class SampleImageState extends ConsumerState<SampleImage>{

  List<XFile> xFileList =[];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
     //backgroundColor: Colors.grey.withOpacity(0.2),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipPath(
                clipper: WavyClipper(),
                child: Container(
                  width: size.width,
                  height: size.height*0.2,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/bg_header.png"),
                          fit: BoxFit.cover
                      )
                  ),
                  child: const Stack(
                    children: [
                      Positioned(
                          top: 50,
                          left: 20,
                          child: Text("Happy Connect",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SfProDisplay',
                                fontSize: 24
                            ),)
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error,color: Colors.blue.withOpacity(0.8),),
                        const Text("Chọn ảnh bên dưới để thay đổi ảnh mẫu của bạn nhé",
                        style: TextStyle(color: Colors.blueAccent),),
                      ],
                    ),
                  )
              )
            ],
          ),
          Expanded(child: displayExamplePhoto(xFileList))
        ],
      ),
    );
  }

  Widget displayExamplePhoto(List<XFile> xFileList) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.8

        ),
        itemCount: xFileList.length+1,
        itemBuilder: (context,index){
          if(index==0){
            return DottedBorder(
              borderType: BorderType.RRect,
                strokeCap: StrokeCap.butt,
                radius: const Radius.circular(8),
                dashPattern: const [10,6],
                strokeWidth: 1,
                color: Colors.grey.withOpacity(0.8),
                stackFit: StackFit.passthrough,
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width *0.45,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: Colors.red,),
                        Text("Thêm ảnh mẫu", style: TextStyle(color: Colors.red,fontSize: 12),)
                      ],
                    ),
                  ),
                )
            );
          }else{
            return Center(
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white
                  ),
                  child: Image.file(File(xFileList[index-1].path))
                ),
              ),
            );
          }
        }
    );
  }
}
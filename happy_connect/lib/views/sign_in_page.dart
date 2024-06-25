
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_connect/model/account.dart';
import 'package:happy_connect/views/main_page.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../provider/login_provider.dart';
import 'package:happy_connect/model/account.dart';
import 'package:http/http.dart' as http;


final obscureTextProvider = StateProvider<bool>((ref) {
  return false;
});


class SignInPage extends ConsumerStatefulWidget{
  const SignInPage({super.key, required this.camera});
  final CameraDescription camera;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignInPageState();

}

class SignInPageState extends ConsumerState<SignInPage>{

  TextEditingController? usernameController;
  TextEditingController? passwordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  Future<void> login(String username, String password) async {
    final response =  http.post(Uri.parse('https://api-hp.viettelsoftware.com:8443/api/v1/login',),body: {
      'username': username,
      'password': password,
      'grant_type': 'password'
    });

    if (response.hashCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(camera: widget.camera),));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

  }
  

  
  @override
  Widget build(BuildContext context) {
    bool obscureText = false;
    obscureText= ref.watch(obscureTextProvider);

    return SafeArea(
        child: KeyboardDismisser(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/main_background.png"),
                      fit: BoxFit.cover
                )
              ),
                child:  Stack(
                  alignment: Alignment.topCenter,
                  children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height:MediaQuery.of(context).size.height*0.5,
                        child: const Center(
                            child: Text("HAPPY CONNECT",style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SfProDisplay',
                              fontSize: 30
                            ), )
                        )
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0),
                          ),
                        ),
                        child:   SingleChildScrollView(
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: Text("ĐĂNG NHẬP",style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'SfProDisplay',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28
                                ), ),
                              ),
                              const Text(
                                "Nhập thông tin chi tiết của bạn bên dưới",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'SfProDisplay',
                                    fontSize: 14
                                ),
                              ),
                              const SizedBox(height: 12,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                                child: TextField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: "Nhập tài khoản",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32)
                                    )
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: !obscureText,
                                  decoration: InputDecoration(
                                      hintText: "Nhập mật khẩu",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(32)
                                      ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: IconButton(
                                          onPressed:(){
                                            ref.read(obscureTextProvider.notifier).state = !obscureText;
                                          },
                                          icon: obscureText
                                              ? Icon(Icons.visibility,color: Colors.blueGrey.withOpacity(0.8),)
                                              :Icon(Icons.visibility_off,color: Colors.blueGrey.withOpacity(0.8),),
                                      ),
                                    )
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async{
                                    String username = usernameController!.text.trim();
                                    String password = passwordController!.text.trim();
                                    Map<String, String> requestBody = {
                                      'username': username,
                                      'password': password,
                                      'grant_type':'password'
                                    };
                                    print(requestBody.toString());
                                    ref.watch(requestDataLoginProvider(requestBody))
                                         .when(
                                       data: (data){
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => MainPage(camera: widget.camera,),
                                           ),
                                         );

                                       },
                                       error:  (error, stackTrace) {
                                         // Hiển thị lỗi nếu có lỗi xảy ra
                                         ScaffoldMessenger.of(context).showSnackBar(
                                           SnackBar(content: Text('Error: $error')),
                                         );
                                       },
                                       loading: () {
                                         print("Loading");
                                       },
                                     );

                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                    )
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                                    child: Text(
                                      "Đăng Nhập",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'SfProDisplay',
                                          fontSize: 18
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ),
        )
    );
  }

}
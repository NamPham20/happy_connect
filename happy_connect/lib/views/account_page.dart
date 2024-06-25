import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_connect/views/admin_main_page.dart';
import 'package:happy_connect/views/history_check_page.dart';

class AccountPage extends ConsumerStatefulWidget{
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AccountPageState();
}

class AccountPageState extends ConsumerState<AccountPage>{

  bool isAdmin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          displayHeader(),
          Expanded(child: listAction())
        ],
      ),
    );
  }

  Widget displayHeader() {
    return Container(
      height: MediaQuery.of(context).size.height*0.4,
      width: MediaQuery.of(context).size.width,
      decoration:  const BoxDecoration(
          image: DecorationImage(
              image:  AssetImage("assets/images/main_background.png"),
              fit: BoxFit.cover
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: Icon(Icons.person_outline,size: 50,),
          ),
          const SizedBox(height: 16,),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8)
            ),
            child: const Column(
              children: [
                Text("tts_nampp", style: TextStyle(color: Colors.white,fontSize: 16),),
                SizedBox(height: 4,),
                Text("tts_nampp@viettel.com.vn",style: TextStyle(color: Colors.white,fontSize: 16))
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget listAction(){
    return ListView(
      padding: EdgeInsets.zero,
      children: [
      if(isAdmin) Card(
          color: Colors.white,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminMainPage() ));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 18),
              child: Row(
                children: [
                  Icon(Icons.manage_accounts_rounded,color: Colors.red,),
                  SizedBox(width: 8,),
                  Text("Admin",style: TextStyle(color: Colors.black,fontSize: 16 ),),
                  Spacer(),
                  Icon(Icons.navigate_next)
                ],
              ),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryCheckPage() ));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 18),
              child: Row(
                children: [
                  Icon(Icons.calendar_today,color: Colors.red,),
                  SizedBox(width: 8,),
                  Text("Lịch sử chấm công",style: TextStyle(color: Colors.black,fontSize: 16 ),),
                  Spacer(),
                  Icon(Icons.navigate_next)
                ],
              ),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: InkWell(
            onTap: (){},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 18),
              child: Row(
                children: [
                  Icon(Icons.groups_outlined,color: Colors.red,),
                  SizedBox(width: 8,),
                  Text("Nhóm",style: TextStyle(color: Colors.black,fontSize: 16 ),),
                  Spacer(),
                  Icon(Icons.navigate_next)
                ],
              ),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: InkWell(
            onTap: (){},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 18),
              child: Row(
                children: [
                  Icon(Icons.person_off,color: Colors.red,),
                  SizedBox(width: 8,),
                  Text("Xoá Tài Khoản",style: TextStyle(color: Colors.black,fontSize: 16 ),),
                ],
              ),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: InkWell(
            onTap: (){},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 18),
              child: Row(
                children: [
                  Icon(Icons.logout,color: Colors.red,),
                  SizedBox(width: 8,),
                  Text("Đăng xuất",style: TextStyle(color: Colors.black,fontSize: 16 ),),

                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16,),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Đánh giá", style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Chia sẻ cảm nhận của bạn để giúp chúng tôi cải thiện ứng dụng nhằm nâng cao trải nghiệm của người dùng")
        ),
        Padding(
            padding: const EdgeInsets.only(left: 8),
          child: RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
        const SizedBox(height: 50,),
        const Text("version : 1.0.0"),
        const SizedBox(height: 10,),
      ],
    );
  }
  
}
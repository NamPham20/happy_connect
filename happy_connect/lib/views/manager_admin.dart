import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_connect/model/employee.dart';
import 'package:happy_connect/ultity/bottom_sheet.dart';

class ManagerAdmin extends ConsumerStatefulWidget{
  const ManagerAdmin({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ManagerAdminState();


}


class ManagerAdminState extends ConsumerState<ManagerAdmin>{


  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2)); // Giả lập thời gian tải dữ liệu
    setState(() {
     for (var element in employees) {
       element.isAdmin = false;
     }// Tải lại dữ liệu mới
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Quản lý Admin",style: TextStyle(color: Colors.white),),
            centerTitle: true,
            backgroundColor: Colors.red,
          ),

          body: Column(
            children: [
              // search bar
              Container(
                color: Colors.red,
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search,size: 20,),
                            hintText: "Tìm kiếm bằng tên hoặc Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.filter_list_alt,color: Colors.white,)
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Danh sách Admin : ", style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
                      ),
                      Expanded(
                          child:RefreshIndicator(
                            onRefresh:_refresh,
                            child: ListView.builder(
                              itemCount: employees.length,
                                itemBuilder: (context,index){
                              return Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(backgroundColor: Colors.blueAccent,),
                                      const SizedBox(width: 12,),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(employees[index].name, style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 14),),
                                          Text(employees[index].email, style: const TextStyle(fontSize: 12),)
                                        ],
                                      )),
                                      Switch(
                                          value: employees[index].isAdmin,
                                          onChanged: (value){
                                            setState(() {
                                              employees[index].isAdmin = value;
                                            });
                                          },
                                        activeColor: Colors.green,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Colors.grey.withOpacity(0.2),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12
                        ),
                        child: ElevatedButton(
                            onPressed: ()=> showButtonSheet(context,size),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                            ),
                            backgroundColor: Colors.red
                          ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add,color: Colors.white,),
                                  Text("Thêm Admin",style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),

                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );

  }

  void showButtonSheet(BuildContext context,Size size){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
          return CustomBottomSheet(employees: employees);
        }
    );
  }

}
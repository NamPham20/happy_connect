import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/employee.dart';

class CustomBottomSheet extends ConsumerStatefulWidget{
  CustomBottomSheet({super.key, required this.employees });
  List<Employee> employees;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BottomSheetState();

}

class BottomSheetState  extends ConsumerState<CustomBottomSheet>{

  List<Employee> employees=[];
  @override
  void initState() {
    employees = widget.employees;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height:MediaQuery.of(context).size.height*0.9,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            height:4,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.red,
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.clear)
              ),
              const Expanded(
                  flex: 1,
                  child: Text(textAlign: TextAlign.center ,"Thêm Admin",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)
              ),
              TextButton(
                onPressed: (){},
                child: const Text("Thêm",style: TextStyle(color: Colors.red),),

              )
            ],
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
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
                    onChanged: (value){
                      if(value==""){
                        setState(() {
                          employees = widget.employees;
                        });
                      }else {
                        setState(() {
                        employees= findByNameOrEmail(value,widget.employees);
                      });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Danh sách nhân viên  : ", style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        itemCount: employees.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                  ],
                ),
              )),

        ],
      ),
    );
  }

  List<Employee> findByNameOrEmail(String value, List<Employee> employees) {
    List<Employee> checkList = [];
    for(var employee in employees){
      if(employee.name.contains(value) || employee.email.contains(value)){
        checkList.add(employee);
      }
    }
    return checkList;
  }
}
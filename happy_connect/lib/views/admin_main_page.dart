import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_connect/views/manager_admin.dart';

class AdminMainPage extends ConsumerStatefulWidget{
  const AdminMainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AdminMainPageState();

}

class AdminMainPageState extends ConsumerState<AdminMainPage>{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Admin", style: TextStyle(color: Colors.white),),
            centerTitle: true,
            backgroundColor: Colors.red,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                customPieChart(),
                customGildFunction(),
              ],
            ),
          ),
    ));
  }

  Widget customPieChart(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.4,
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PieChart(
                      PieChartData(
                          sections: [
                            PieChartSectionData(
                              color: Colors.blue,
                              value: 45,
                              title: "45%",
                              radius: 100,
                              titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            PieChartSectionData(
                              color: Colors.red,
                              value: 55,
                              title: '55%',
                              radius: 80,
                              titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                          centerSpaceRadius: 0,
                          sectionsSpace: 8

                      )
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.blueAccent
                    ),
                  ),
                  const SizedBox(width: 4,),
                  const Text("Nhân viên đã chấm công")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.red
                    ),
                  ),
                  const SizedBox(width: 4,),
                  const Text("Nhân viên chưa chấm công")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customGildFunction() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
          crossAxisCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.8,
        children: [
          Card(
            color: Colors.white,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ManagerAdmin()));
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.manage_accounts_rounded,color: Colors.red,),
                    SizedBox(height: 4,),
                    Text("Quản lý Admin",style: TextStyle(color: Colors.red),)
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
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.image,color: Colors.red,),
                    SizedBox(height: 4,),
                    Text("Duyệt ảnh mẫu",style: TextStyle(color: Colors.red))
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
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.list,color: Colors.red,),
                    SizedBox(height: 4,),
                    Text("Danh sách nhân viên onsite",style: TextStyle(color: Colors.red))
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
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pending_actions,color: Colors.red,),
                    SizedBox(height: 4,),
                    Text("Lịch sử chấm công ",style: TextStyle(color: Colors.red))
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
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.error,color: Colors.red,),
                    SizedBox(height: 4,),
                    Text("Báo cáo số lượng user",style: TextStyle(color: Colors.red))
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
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Icon(Icons.warning,color: Colors.red,),
                    SizedBox(height: 4,),
                    Text("Báo cáo số lượng request",style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
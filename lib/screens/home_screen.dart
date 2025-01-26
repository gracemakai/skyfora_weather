import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text('Lower Kabete'),
        leading: const Icon(Icons.location_on_outlined),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          )
        ],
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.3.sh,
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('24 C', style: TextStyle(
                      fontSize: 50.sp,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600
                    ),),
                    Text('Mostly Clear', style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white70,
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.air, color: Colors.white,),
                              SizedBox(width: 0.01.sw,),
                              const Text('Mostly Clear', style: TextStyle(
                                color: Colors.white70,
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.water_drop_outlined, color: Colors.white,),
                              SizedBox(width: 0.01.sw,),
                              const Text('32%', style: TextStyle(
                                color: Colors.white70,
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.wind_power, color: Colors.white,),
                              SizedBox(width: 0.01.sw,),
                              const Text('12km/h', style: TextStyle(
                                color: Colors.white70,
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.01.sh,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Today', style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp
                  ),),
                  SizedBox(
                    height: 0.1.sh,
                    child: ListView.builder(
                      itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index){
                      return SizedBox(
                        width: 0.15.sw,
                        child: Column(
                          children: [
                            Text('Now', style: TextStyle(
                                color: Colors.black26,
                                fontSize: 14.sp
                            ),),
                            const Icon(Icons.sunny),
                            Text('24.', style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp
                            ),),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 0.01.sh,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('5 day forecast', style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp
                  ),),
                  SizedBox(
                    height: 0.5.sh,
                    child: ListView.builder(
                        itemCount: 7,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tomorrow', style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14.sp
                                ),),
                                Text('24.', style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp
                                ),),
                                const Icon(Icons.sunny),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

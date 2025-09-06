import 'package:cairometro/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.back_ground,
      appBar: AppBar(
        backgroundColor: AppColor.back_ground,
        surfaceTintColor: AppColor.back_ground,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: AppColor.Black,)),
        title: Text(
          'Metro Map',
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            // Image - logo
            Center(
              child: Container(
                color: AppColor.back_ground.withOpacity(0.8),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image
                      Image.asset(
                        'assets/images/logo.png',
                        width: 150,
                        height: 150,
                      ),

                      // Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Cairo',style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: AppColor.color1
                          ),),
                          Text('Metro',style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: AppColor.color2
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Image - Map
            InteractiveViewer(
              panEnabled: true,
              minScale: 1,
              maxScale: 4,
              child: SizedBox(
                width: 1.sw,
                height: 0.6.sh,
                child: Image.asset(
                  "assets/images/img.jpg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

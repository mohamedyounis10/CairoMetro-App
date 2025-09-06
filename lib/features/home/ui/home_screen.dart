import 'package:cairometro/core/app_color.dart';
import 'package:cairometro/features/home/cubit/logic.dart';
import 'package:cairometro/features/home/cubit/state.dart';
import 'package:cairometro/features/home/ui/map_screen.dart';
import 'package:cairometro/features/home/ui/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context,state){
        if(state is MapPage){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (c){
              return MapScreen();
            })
          );
        }
        if(state is TicketPage){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (c){
                return TicketScreen();
              })
          );
        }
      },
      builder: (context,state){
        final cubit = context.read<HomeCubit>();
      return Scaffold(
        backgroundColor: AppColor.back_ground,
        body: Column(
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
                        width: 150.w,
                        height: 150.h,
                      ),

                      // Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Cairo',style: TextStyle(
                              fontSize: 25.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: AppColor.color1
                          ),),
                          Text('Metro',style: TextStyle(
                              fontSize: 25.sp,
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

            SizedBox(height: 70.h),

            // Buttons
            CustomButton(
              width: 330.w,
              text: "Tickets",
              onTap: () {
                cubit.ticketPage();
              },
            ),
            SizedBox(height: 10.h),
            CustomButton(
              width: 330.w,
              text: "Metro Map",
              backgroundColor: AppColor.color2,
              onTap: () {
                cubit.mapPage();
              },
            ),
          ],
        ),
      );
      },
    );
  }
}
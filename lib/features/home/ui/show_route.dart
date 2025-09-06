import 'package:cairometro/core/app_color.dart';
import 'package:cairometro/features/home/cubit/logic.dart';
import 'package:cairometro/features/home/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/station.dart';

class ShowRoute extends StatelessWidget {
  const ShowRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          backgroundColor: AppColor.back_ground,
          appBar: AppBar(
            backgroundColor:  AppColor.back_ground,
            surfaceTintColor:  AppColor.back_ground,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back, color: AppColor.Black, size: 24.sp),
            ),
            title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                Text(
                  cubit.from!.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColor.color1,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ' To ',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Poppins",
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  cubit.to!.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColor.color2,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (cubit.path.isNotEmpty)
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Info Chips
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0.r),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Duration
                                    Expanded(
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          color: Color(0xFFE4E9F2),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12.r),
                                            bottomLeft: Radius.circular(12.r),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                 Icon(Icons.access_time_filled, color: AppColor.color2),
                                                 SizedBox(width: 4.w),
                                                 Text(
                                                  'Time',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.color2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                             SizedBox(height: 4.h),
                                            Text(
                                              "${cubit.durationMinutes}",
                                              style:  TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                color: AppColor.grey600,
                                              ),
                                            ),
                                             Text(
                                              "Minute",
                                              style: TextStyle(
                                                color:AppColor.grey600,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 7.w,),

                                    // Number of Stations
                                    Expanded(
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          color: Color(0xFFE4E9F2),
                                          border: Border(
                                            left: BorderSide(color: AppColor.back_ground, width: 1.0.w),
                                            right: BorderSide(color: AppColor.back_ground, width: 1.0.w),
                                          ),
                                        ),
                                        padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                 Icon(Icons.train, color: AppColor.color2),
                                                 SizedBox(width: 2.w),
                                                 Text(
                                                  'Stations',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.color2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              "${cubit.numStations}",
                                              style:  TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                color:AppColor.grey600,
                                              ),
                                            ),
                                            Text(
                                              "Stations",
                                              style: TextStyle(
                                                color: AppColor.grey600,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 7.w,),

                                    // Price
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE4E9F2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                        ),
                                        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                 Icon(Icons.attach_money, color: AppColor.color2),
                                                 SizedBox(width: 4.w),
                                                 Text(
                                                  'Price',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.color2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                             SizedBox(height: 4.h),
                                            // Price
                                            Text(
                                              "${cubit.ticketPrice}",
                                              style:  TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                color: AppColor.grey600,
                                              ),
                                            ),
                                             Text(
                                              "EGP",
                                              style: TextStyle(
                                                color: AppColor.grey600,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // Ticket
                            Text(
                              "Your Ticket color :",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.asset(cubit.ticketImage),
                            SizedBox(height: 10.h),

                            // Trip Description
                            Container(
                              height: 70.h,
                              padding: EdgeInsets.all(10.w),
                              decoration:  BoxDecoration(
                                color: AppColor.back_ground,
                                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Trip description",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Take the line number ${cubit.path.first.line}",
                                    style: TextStyle(
                                      color: AppColor.grey600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),

                            // Route
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColor.back_ground,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children:  [
                                      Icon(Icons.alt_route, color: AppColor.color2), // Updated color
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Metro route",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Divider(),

                                  // Direction Name
                                  Container(
                                    padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                                    decoration: BoxDecoration(
                                      color:  AppColor.grey200,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      children: [
                                         Icon(Icons.looks_one, color:AppColor.color2, size: 18),
                                         SizedBox(width: 8.w),
                                        Text(
                                          'Line no. ${cubit.path.first.line}',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h),

                                  // Display Stations
                                  ...cubit.path.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    Station s = entry.value;
                                    bool isFirst = index == 0;
                                    bool isLast = index == cubit.path.length - 1;
                                    bool isLineChange =
                                        index > 0 && cubit.path[index].line != cubit.path[index - 1].line;

                                    List<Widget> stationWidgets = [];

                                    if (isLineChange) {
                                      stationWidgets.add(
                                        Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 16.0.w),
                                          child: Row(
                                            children: [
                                              Icon(Icons.sync_alt, color: AppColor.color1),
                                              SizedBox(width: 8.w),
                                              Text(
                                                "Change Line",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.color1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      stationWidgets.add(
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                                          decoration: BoxDecoration(
                                            color: AppColor.grey200,
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.looks_one, color:AppColor.color2, size: 18),
                                              SizedBox(width: 8.w),
                                              Text(
                                                'Line no. ${s.line}',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      stationWidgets.add( SizedBox(height: 12.h));
                                    }

                                    stationWidgets.add(
                                      Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Station dot and line
                                              Container(
                                                width: 18.w,
                                                margin:  EdgeInsets.only(left: 4.w),
                                                child: Column(
                                                  children: [
                                                    if (!isFirst)
                                                      Container(
                                                        height: 10.h,
                                                        width: 2.w,
                                                        color: AppColor.color1,
                                                      ),
                                                    Icon(
                                                      isFirst || isLast ? Icons.circle : Icons.circle_outlined,
                                                      size: isFirst || isLast ? 20 : 12,
                                                      color: isFirst || isLast ?  AppColor.color1 : AppColor.color1 ,
                                                    ),
                                                    if (!isLast)
                                                      Container(
                                                        height: 10.h,
                                                        width: 2.w,
                                                        color: AppColor.color1 ,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Expanded(
                                                child: Text(
                                                  s.name,
                                                  style: TextStyle(
                                                    fontWeight: isFirst || isLast ? FontWeight.bold : FontWeight.normal,
                                                    color: isFirst || isLast ? Colors.black : Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                              if (isLast)
                                                Icon(
                                                  Icons.check_circle,
                                                  color:  AppColor.color2,
                                                  size: 20,
                                                ),
                                            ],
                                          ),
                                          if (!isLast)
                                             SizedBox(height: 12.h),
                                        ],
                                      ),
                                    );
                                    return Column(children: stationWidgets);
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

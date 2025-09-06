import 'package:cairometro/features/home/cubit/logic.dart';
import 'package:cairometro/features/home/cubit/state.dart';
import 'package:cairometro/features/home/ui/show_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/app_color.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../models/station.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is EmptyFiled) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Please Choose Stations"),
              backgroundColor: Colors.grey,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
        if (state is NextPage) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (c) => ShowRoute()),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final stationsBox = Hive.box<Station>('stations');
        final allStations = stationsBox.values
            .fold<Map<String, Station>>({}, (map, station) {
          map[station.name] = station;
          return map;
        })
            .values
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
        
        final fromStations = allStations;
        
        final toStations = cubit.from == null
            ? allStations 
            : allStations.where((s) => s.name != cubit.from!.name).toList();
        return Scaffold(
          backgroundColor: AppColor.back_ground,
          appBar: AppBar(
            backgroundColor: AppColor.back_ground,
            surfaceTintColor: AppColor.back_ground,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back, color: AppColor.Black, size: 24.sp),
            ),
            title: Text(
              'Tickets',
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo + Word
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 150.w,
                          height: 150.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cairo',
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                color: AppColor.color1,
                              ),
                            ),
                            Text(
                              'Metro',
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                color: AppColor.color2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // From
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.grey200,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black26,
                          blurRadius: 4.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<Station>(
                      value: cubit.from,
                      dropdownColor: AppColor.back_ground,
                      decoration: InputDecoration(
                        hintText: "From",
                        filled: true,
                        fillColor: AppColor.grey200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                      ),
                      items: fromStations.map((s) {
                        return DropdownMenuItem(
                          value: s,
                          child: Text(s.name, style: TextStyle(fontSize: 14.sp)),
                        );
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) cubit.setFrom(v);
                      },
                    ),
                  ),
                  SizedBox(height: 17.h),

                  // To
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.grey200,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black26,
                          blurRadius: 4.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<Station>(
                      value: cubit.to,
                      dropdownColor: AppColor.back_ground,
                      decoration: InputDecoration(
                        hintText: "To",
                        filled: true,
                        fillColor: AppColor.grey200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                      ),
                      items: toStations.map((s) {
                        return DropdownMenuItem(
                          value: s,
                          child: Text(s.name, style: TextStyle(fontSize: 14.sp)),
                        );
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) cubit.setTo(v);
                      },
                    ),
                  ),
                  SizedBox(height: 50.h),

                  // Show Route
                  CustomButton(
                    width: 330.w,
                    backgroundColor: AppColor.color2,
                    text: "Show Route",
                    onTap: () async {
                      if (cubit.from == null || cubit.to == null) {
                        cubit.emptyFiled();
                      } else {
                        await context.read<HomeCubit>().saveTripToHistory();
                        cubit.nextPage();
                      }
                    },
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

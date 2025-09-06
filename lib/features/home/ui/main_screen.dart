import 'package:cairometro/features/home/cubit/logic.dart';
import 'package:cairometro/features/home/cubit/state.dart';
import 'package:cairometro/features/home/ui/alert_screen.dart';
import 'package:cairometro/features/home/ui/instructions.dart';
import 'package:cairometro/features/home/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_color.dart';
import 'home_screen.dart';
import 'history.dart';

class MainScreen extends StatelessWidget{
  // Pages
  final List<Widget> _pages = [
    HomeScreen(),
    AlertScreen(),
    HistoryScreen(),
    InstructionsScreen()
  ];

  // AppBars
  AppBar? buildAppBar(int index, BuildContext context) {
    switch(index) {
      case 0:
        return AppBar(
          surfaceTintColor: AppColor.back_ground,
          backgroundColor:AppColor.back_ground,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c){
                  return SearchScreen();
                }));
              }, icon: Icon(Icons.search,size: 30,)),
            ),
          ],
        );
      case 1:
        return  AppBar(
          backgroundColor: AppColor.back_ground,
          surfaceTintColor: AppColor.back_ground,
          title: Text(
            'Alerts',
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        );
      case 2:
        return AppBar(
          backgroundColor: AppColor.back_ground,
          surfaceTintColor: AppColor.back_ground,
          title: Text('History',
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        );
      default:
        return AppBar(
          backgroundColor: AppColor.back_ground,
          surfaceTintColor: AppColor.back_ground,
          title: Text(
           'Instructions',
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context,state){},
      builder: (context,state){
        final cubit = context.read<HomeCubit>();
      return Scaffold(
        backgroundColor: AppColor.back_ground,
        appBar: buildAppBar(cubit.selectedIndex, context),
        body: _pages[cubit.selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColor.color2,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: BottomNavigationBar(
              currentIndex: cubit.selectedIndex,
              backgroundColor: AppColor.color2,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColor.color1,
              unselectedItemColor: AppColor.back_ground,
              showSelectedLabels: false,
              showUnselectedLabels: true,
              onTap: cubit.changePage,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  activeIcon: Container(
                    decoration: BoxDecoration(
                      color: cubit.selectedIndex == 0 ? AppColor.back_ground : AppColor.color2,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.home,
                      color: cubit.selectedIndex == 0 ? AppColor.color1 : AppColor.back_ground,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  activeIcon: Container(
                    decoration: BoxDecoration(
                      color: cubit.selectedIndex == 1 ? AppColor.back_ground : AppColor.color2,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.notifications,
                      color: cubit.selectedIndex == 1 ? AppColor.color1 : AppColor.back_ground,
                    ),
                  ),
                  label: 'Alerts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  activeIcon: Container(
                    decoration: BoxDecoration(
                      color: cubit.selectedIndex == 2 ? AppColor.back_ground : AppColor.color2,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.history,
                      color: cubit.selectedIndex == 2 ? AppColor.color1 : AppColor.back_ground,
                    ),
                  ),
                  label: "History",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.insert_drive_file_outlined),
                  activeIcon: Container(
                    decoration: BoxDecoration(
                      color: cubit.selectedIndex == 3 ?AppColor.back_ground : AppColor.color2,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.insert_drive_file_outlined,
                      color: cubit.selectedIndex == 3 ? AppColor.color1 : AppColor.back_ground,
                    ),
                  ),
                  label:'Instructions',
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
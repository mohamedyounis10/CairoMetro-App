import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_color.dart';
import '../../../core/widgets/custom_textformfield_container.dart';
import '../../../core/widgets/station_card.dart';
import '../cubit/logic.dart';
import '../cubit/state.dart';

class SearchScreen extends StatelessWidget{
  // Variables
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        
        return Scaffold(
          backgroundColor: AppColor.back_ground,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.back_ground,
            elevation: 0,
            title: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColor.Black),
                  onPressed: () {
                    cubit.clearSearch();
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: CustomTextFormFieldContainer(
                    controller: textController,
                    labelText: "Search nearby places",
                    onChanged: (value) {
                      cubit.searchStations(value);
                    },
                  ),
                ),
                if (cubit.searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, color: AppColor.Black),
                    onPressed: () {
                      textController.clear();
                      cubit.clearSearch();
                    },
                  ),
              ],
            ),
          ),
          body: Padding(
            padding:  EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (cubit.searchQuery.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 64.sp,
                            color:AppColor.grey600,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Search nearby places',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColor.grey600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Try: "University", "Hospital", "Museum"',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColor.grey600,
                              fontFamily: 'Poppins',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                else if (cubit.searchResults.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64.sp,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No results found',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.grey[600],
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Try searching for different keywords',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[500],
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Found ${cubit.searchResults.length} result(s)',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: AppColor.Black,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Expanded(
                          child: ListView.builder(
                            itemCount: cubit.searchResults.length,
                            itemBuilder: (context, index) {
                              final station = cubit.searchResults[index];
                              return buildStationCard(
                                context,
                                station,
                                cubit.searchQuery,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

}
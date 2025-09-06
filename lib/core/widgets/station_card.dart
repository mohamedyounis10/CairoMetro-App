import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/station.dart';
import '../../../core/app_color.dart';

Widget buildStationCard(BuildContext context, Station station, String searchQuery, {VoidCallback? onTap}) {
  return Card(
    color: AppColor.back_ground,
    margin: EdgeInsets.only(bottom: 12.h),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColor.color2,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.train,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
      title: Text(
        station.name,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          color: AppColor.Black,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),
          Text(
            'Line ${station.line}',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColor.color1,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          if (station.nearbyPlaces.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              'Nearby: ${station.nearbyPlaces.join(', ')}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
                fontFamily: 'Poppins',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
      trailing: station.isInterchange
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColor.color1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Interchange',
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : null,
      onTap: onTap,
    ),
  );
}

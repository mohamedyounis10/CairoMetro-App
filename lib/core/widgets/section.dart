import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSection(String title, List<String> items, Color cardColor, Color iconColor) {
  return Card(
    color: cardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    elevation: 4,
    margin: EdgeInsets.symmetric(vertical: 10.h),
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.h),
          ...items.map(
                (item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, size: 18.sp, color: iconColor),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(item, style: TextStyle(fontSize: 16.sp)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

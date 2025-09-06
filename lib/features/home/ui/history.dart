import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import '../../../core/app_color.dart';
import '../cubit/logic.dart';
import '../cubit/state.dart';
import '../../../models/search_record.dart';
import '../../../models/station.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Padding(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder(
              future: context.read<HomeCubit>().initUser(),
              builder: (context, snapshot) {
                final history = context.read<HomeCubit>().currentUser?.history ?? [];
                if (history.isEmpty) {
                  return Center(
                    child: Text(
                      'No history yet',
                      style: TextStyle(fontSize: 16.sp, color: AppColor.grey600),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: history.length,
                  separatorBuilder: (_, __) =>  Divider(height: 1.h),
                  itemBuilder: (context, index) {
                    final SearchRecord r = history[index];
                    final hasTicketInfo = r.ticketPrice != null && r.fromStationName != null && r.toStationName != null;

                    final showPathNotifier = ValueNotifier<bool>(false);

                    return ValueListenableBuilder<bool>(
                      valueListenable: showPathNotifier,
                      builder: (context, showPath, _) {
                        return Card(
                          color: AppColor.back_ground,
                          margin:  EdgeInsets.symmetric(vertical: 4.h),
                          child: Container(
                            color: AppColor.back_ground,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: r.hasMatch ? AppColor.color2 : AppColor.grey400,
                                    child: Icon(
                                      r.hasMatch ? Icons.check : Icons.search,
                                      color: Colors.white,
                                      size: 18.sp,
                                    ),
                                  ),
                                  title: Text(
                                    hasTicketInfo
                                        ? "${r.fromStationName} → ${r.toStationName}"
                                        : r.query,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: hasTicketInfo
                                      ? Wrap(
                                    spacing: 12,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.attach_money, size: 14, color: AppColor.color2),
                                          SizedBox(width: 4.w),
                                          Text("${r.ticketPrice} EGP", style: TextStyle(fontSize: 12.sp)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.schedule, size: 14, color: AppColor.grey600),
                                          SizedBox(width: 4.w),
                                          Text("${r.durationMinutes} min", style: TextStyle(fontSize: 12.sp)),
                                        ],
                                      ),
                                    ],
                                  )
                                      : Text(
                                    r.hasMatch ? "Nearest: ${r.matchedStationName}" : "No nearby station",
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          showPath ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                          color: AppColor.color1,
                                        ),
                                        onPressed: () {
                                          showPathNotifier.value = !showPathNotifier.value;
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline),
                                        onPressed: () => context.read<HomeCubit>().removeHistoryItem(r.id),
                                      ),
                                    ],
                                  ),
                                ),
                                if (showPath && hasTicketInfo)
                                  Container(
                                    color: AppColor.back_ground,
                                    child: _buildRouteDetails(r)),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );

              },
            ),
        );
      },
    );
  }

  Widget _buildRouteDetails(SearchRecord record) {
    final stationsBox = Hive.box<Station>('stations');
    final stations = record.routePath?.map((id) => stationsBox.get(id)).where((s) => s != null).cast<Station>().toList() ?? [];

    return Container(
      padding:  EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.back_ground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Route Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                icon: Icons.attach_money,
                label: 'Price',
                value: '${record.ticketPrice} EGP',
                color: AppColor.color2,
              ),
              _buildInfoItem(
                icon: Icons.schedule,
                label: 'Duration',
                value: '${record.durationMinutes} min',
                color: AppColor.color1,
              ),
              _buildInfoItem(
                icon: Icons.train,
                label: 'Stations',
                value: '${record.numStations}',
                color: AppColor.grey600,
              ),
            ],
          ),

          if (stations.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Divider(),
            SizedBox(height: 8.h),

            // Route Path Title
            Row(
              children: [
                Icon(Icons.route, color: AppColor.color1, size: 20),
                SizedBox(width: 8.w),
                Text(
                  'Route Path',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.color1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Stations List
            ...stations.asMap().entries.map((entry) {
              int index = entry.key;
              Station station = entry.value;
              final isFirst = index == 0;
              final isLast = index == stations.length - 1;
              final isLineChange = index > 0 &&
                  stations[index].line != stations[index - 1].line;

              return Column(
                children: [
                  if (isLineChange) ...[
                    SizedBox(height: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColor.color2.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Change to Line ${station.line}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.color2,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                  Row(
                    children: [
                      // Station indicator
                      Container(
                        width: 16.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFirst || isLast
                              ? AppColor.color2
                              : AppColor.color1,
                          border: Border.all(
                            color: AppColor.back_ground,
                            width: 2.w,
                          ),
                        ),
                        child: Icon(
                          isFirst
                              ? Icons.play_arrow
                              : isLast
                                  ? Icons.stop
                                  : Icons.circle,
                          color: AppColor.back_ground,
                          size: 10,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Station info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              station.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (station.isInterchange)
                              Text(
                                'Interchange Station',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: AppColor.color2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Line indicator
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColor.color1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Line ${station.line}',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: AppColor.back_ground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!isLast)
                    Container(
                      margin: EdgeInsets.only(left: 7, top: 4, bottom: 4),
                      width: 2.w,
                      height: 16.h,
                      color: AppColor.grey400,
                    ),
                ],
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}




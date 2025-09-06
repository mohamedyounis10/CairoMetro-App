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
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: history.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final SearchRecord r = history[index];
                    final hasTicketInfo = r.ticketPrice != null && r.fromStationName != null && r.toStationName != null;
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: hasTicketInfo 
                        ? ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: r.hasMatch ? AppColor.color2 : AppColor.grey400,
                              child: Icon(
                                r.hasMatch ? Icons.check : Icons.search,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            title: Text(
                              r.query,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            if (r.hasMatch)
                              Text('Nearest: ${r.matchedStationName}')
                            else
                              Text('No nearby station'),
                                if (hasTicketInfo) ...[
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.train, size: 16, color: AppColor.color1),
                                      SizedBox(width: 4),
                                      Text(
                                        '${r.fromStationName} → ${r.toStationName}',
                                        style: TextStyle(fontSize: 12.sp, color: AppColor.color1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money, size: 16, color: AppColor.color2),
                                      SizedBox(width: 4),
                                  Text(
                                    '${r.ticketPrice} ${'egp'}',
                                    style: TextStyle(fontSize: 12.sp, color: AppColor.color2, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 16),
                                  Icon(Icons.schedule, size: 16, color: AppColor.grey600),
                                  SizedBox(width: 4),
                                  Text(
                                    '${r.durationMinutes} ${'min'}',
                                    style: TextStyle(fontSize: 12.sp, color: AppColor.grey600),
                                  ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => context.read<HomeCubit>().removeHistoryItem(r.id),
                            ),
                            children: [
                              _buildRouteDetails(r),
                            ],
                          )
                        : ListTile(
                            leading: CircleAvatar(
                              backgroundColor: r.hasMatch ? AppColor.color2 : AppColor.grey400,
                              child: Icon(
                                r.hasMatch ? Icons.check : Icons.search,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            title: Text(
                              r.query,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              r.hasMatch
                                  ? 'Nearest: ${r.matchedStationName}'
                                  : 'No nearby station',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => context.read<HomeCubit>().removeHistoryItem(r.id),
                            ),
                          ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.grey200.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
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
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 8),
            
            // Route Path Title
            Row(
              children: [
                Icon(Icons.route, color: AppColor.color1, size: 20),
                SizedBox(width: 8),
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
            SizedBox(height: 12),
            
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
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColor.color2.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
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
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFirst || isLast 
                              ? AppColor.color2 
                              : AppColor.color1,
                          border: Border.all(
                            color: AppColor.back_ground,
                            width: 2,
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
                      SizedBox(width: 12),
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
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                      width: 2,
                      height: 16,
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
        SizedBox(height: 4),
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




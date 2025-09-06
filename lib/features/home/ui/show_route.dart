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
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Info Chips
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
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
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.access_time_filled, color: Color(0xFF003D6D)),
                                                const SizedBox(width: 4),
                                                const Text(
                                                  'Time',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF003D6D),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "${cubit.durationMinutes}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xFF4B4E53),
                                              ),
                                            ),
                                            const Text(
                                              "Minute",
                                              style: TextStyle(
                                                color: Color(0xFF4B4E53),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 7,),

                                    // Number of Stations
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE4E9F2),
                                          border: Border(
                                            left: BorderSide(color: Color(0xFFF1F4F9), width: 1.0),
                                            right: BorderSide(color: Color(0xFFF1F4F9), width: 1.0),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.train, color: Color(0xFF003D6D)),
                                                const SizedBox(width: 4),
                                                const Text(
                                                  'Stations',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF003D6D),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "${cubit.numStations}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xFF4B4E53),
                                              ),
                                            ),
                                            const Text(
                                              "Stations",
                                              style: TextStyle(
                                                color: Color(0xFF4B4E53),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 7,),

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
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.attach_money, color: Color(0xFF003D6D)),
                                                const SizedBox(width: 4),
                                                const Text(
                                                  'Price',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF003D6D),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            // Price
                                            Text(
                                              "${cubit.ticketPrice}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xFF4B4E53),
                                              ),
                                            ),
                                            const Text(
                                              "EGP",
                                              style: TextStyle(
                                                color: Color(0xFF4B4E53),
                                                fontSize: 12,
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
                            SizedBox(height: 20),

                            // Ticket
                            Text(
                              "Your Ticket color :",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.asset(cubit.ticketImage),
                            SizedBox(height: 10),

                            // Trip Description
                            Container(
                              height: 70,
                              padding: EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xffe4e4e4),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                  SizedBox(height: 4),
                                  Text(
                                    "Take the line number ${cubit.path.first.line}",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),

                            // Route
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
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
                                    children: const [
                                      Icon(Icons.alt_route, color: Color(0xFF003D6D)), // Updated color
                                      SizedBox(width: 8),
                                      Text(
                                        "Metro route",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Divider(),

                                  // Direction Name
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F4F9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.looks_one, color: Color(0xFF003D6D), size: 18),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Line no. ${cubit.path.first.line}',
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),

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
                                          padding:  EdgeInsets.symmetric(vertical: 16.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.sync_alt, color: AppColor.color1),
                                              SizedBox(width: 8),
                                              Text(
                                                "Change Line",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFC04F03),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      stationWidgets.add(
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF1F4F9),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.looks_one, color: Color(0xFF003D6D), size: 18),
                                              SizedBox(width: 8),
                                              Text(
                                                'Line no. ${s.line}',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      stationWidgets.add(const SizedBox(height: 12));
                                    }

                                    stationWidgets.add(
                                      Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // 🔹 Station dot and line
                                              Container(
                                                width: 18,
                                                margin: const EdgeInsets.only(left: 4),
                                                child: Column(
                                                  children: [
                                                    if (!isFirst)
                                                      Container(
                                                        height: 10,
                                                        width: 2,
                                                        color: const Color(0xFFC04F03),
                                                      ),
                                                    Icon(
                                                      isFirst || isLast ? Icons.circle : Icons.circle_outlined,
                                                      size: isFirst || isLast ? 20 : 12,
                                                      color: isFirst || isLast ?  AppColor.color1 : AppColor.color1 ,
                                                    ),
                                                    if (!isLast)
                                                      Container(
                                                        height: 10,
                                                        width: 2,
                                                        color: AppColor.color2 ,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 8),
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
                                                  color: const Color(0xFF003D6D),
                                                  size: 20,
                                                ),
                                            ],
                                          ),
                                          if (!isLast)
                                            const SizedBox(height: 12),
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

import 'package:cairometro/features/splash/ui/splash_screen.dart';
import 'package:cairometro/models/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/services/data_seeder.dart';
import 'features/home/cubit/logic.dart';
import 'models/line.dart';
import 'models/station.dart';
import 'models/search_record.dart';
import 'models/app_user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(LineAdapter());
  Hive.registerAdapter(StationAdapter());
  Hive.registerAdapter(RouteModelAdapter());
  Hive.registerAdapter(SearchRecordAdapter());
  Hive.registerAdapter(AppUserAdapter());

  await Hive.openBox<Station>('stations');
  await Hive.openBox<Line>('lines');
  await Hive.openBox<RouteModel>('routes');
  await Hive.openBox<AppUser>('user');

  await DataSeeder.seedFromAssetsIfEmpty();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
             BlocProvider(create: (_) => HomeCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cairo Metro',
            home: child,
          ),
        );
      },
      child: SplashScreen()
    );
  }
}

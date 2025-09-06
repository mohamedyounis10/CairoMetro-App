import 'package:cairometro/core/app_color.dart';
import 'package:cairometro/features/home/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1;
      });
    });

    Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainScreen()),
        );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/img.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Overlay + Animation
          Center(
            child: Container(
              color: AppColor.back_ground.withOpacity(0.8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Animation (Zoom in)
                    TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 1200),
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      curve: Curves.easeOutBack,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 200.w,
                        height: 200.h,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Text Animation (Fade In)
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(seconds: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cairo',
                            style: TextStyle(
                              fontSize: 35.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: AppColor.color1,
                            ),
                          ),
                          Text(
                            'Metro',
                            style: TextStyle(
                              fontSize: 35.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: AppColor.color2,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reciply/constants/app_colors.dart';
import 'package:reciply/constants/app_images.dart';
import 'package:reciply/constants/localization_constains.dart';
import 'package:reciply/presentation/widgets/size.dart';
import 'package:reciply/presentation/widgets/text_display.dart';

import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.logoIcon, width: 0.135.sw),
                WidthBox(16),
                AppTextDisplay(
                  translation: kAppName,
                  fontFamily: "Pacifico",
                  color: AppColor.primaryColor,
                  fontSize: 36.sp,
                ),
              ],
            ),
          ),
        ),
      );
}

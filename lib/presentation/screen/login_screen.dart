import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reciply/constants/app_colors.dart';
import 'package:reciply/constants/app_images.dart';
import 'package:reciply/constants/localization_constains.dart';
import 'package:reciply/presentation/widgets/blur_edit_text.dart';
import 'package:reciply/presentation/widgets/blur_widget.dart';
import 'package:reciply/presentation/widgets/button_display.dart';
import 'package:reciply/presentation/widgets/size.dart';
import 'package:reciply/presentation/widgets/text_display.dart';
import 'package:reciply/presentation/widgets/text_field_display.dart';
import 'package:reciply/routes.dart';
import 'package:reciply/utils/navigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var phoneOrEmailController = TextEditingController();
  bool emailIsNull = false;

  final passwordController = TextEditingController();
  bool passwordIsNull = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(overflow: Overflow.visible, children: [
        Image.asset(
          AppImages.background,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        BlurWidget(
          sigmaX: 1.0,
          sigmaY: 1.0,
          child: SafeArea(child: buildBody(context)),
        ),
      ]),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeightBox(16),
            buildILogo(context),
            Column(
              children: [
                buildUserEmail(),
                HeightBox(16),
                buildUserPassword(),
              ],
            ),
            continueAsGuest(),
            buildLoginButton(),
            HeightBox(24),
          ],
        ),
      ),
    );
  }

  Widget buildILogo(BuildContext context) {
    return Center(
      child: AppTextDisplay(
        translation: kAppName,
        fontFamily: "Pacifico",
        color: AppColor.white,
        fontSize: 36.sp,
      ),
    );
  }

  Widget buildUserEmail() {
    return BlurEditText(
      controller: phoneOrEmailController,
      errorText: emailIsNull,
      translation: kEmail,
    );
  }

  Widget buildUserPassword() {
    return BlurEditText(
      controller: passwordController,
      errorText: passwordIsNull,
      obscureText: true,
      translation: kPassword,
    );
  }

  Widget continueAsGuest() {
    return TextButton(
      onPressed: () => pushName(context, AppRouter.homeScreen),
      child: AppTextDisplay(
        translation: kContinueAsGuest,
        color: AppColor.white,
        fontSize: 14.sp,
      ),
    );
  }

  Widget buildLoginButton() {
    return AppButton(
      translation: kLogin,
      textColor: AppColor.darkGrey,
      onTap: () {
        if (formKey.currentState!.validate()) {
          pushName(context, AppRouter.homeScreen);
        }
      },
    );
  }

  Widget buildGuestText() {
    return InkWell(
      onTap: () {},
      child: AppTextDisplay(
        translation: kContinueAsGuest,
        color: AppColor.brown,
      ),
    );
  }
}

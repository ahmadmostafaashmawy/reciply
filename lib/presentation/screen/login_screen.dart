import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reciply/constants/app_colors.dart';
import 'package:reciply/constants/constants.dart';
import 'package:reciply/constants/localization_constains.dart';
import 'package:reciply/presentation/widgets/background_scaffold.dart';
import 'package:reciply/presentation/widgets/blur_edit_text.dart';
import 'package:reciply/presentation/widgets/button_display.dart';
import 'package:reciply/presentation/widgets/size.dart';
import 'package:reciply/presentation/widgets/snak_bar.dart';
import 'package:reciply/presentation/widgets/text_display.dart';
import 'package:reciply/routes.dart';
import 'package:reciply/utils/app_edit_validator.dart';
import 'package:reciply/utils/navigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  bool emailIsNull = false;

  final passwordController = TextEditingController();
  bool passwordIsNull = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: BackgroundScaffold(
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.fromLTRB(0.1.sw, 0.17.sh, 0.1.sw, 0.3.sw),
      child: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildILogo(context),
                HeightBox(16),
                Column(
                  children: [
                    buildUserEmail(),
                    HeightBox(16),
                    buildUserPassword(),
                  ],
                ),
                HeightBox(16),
                continueAsGuest(),
                HeightBox(16),
                buildLoginButton(context),
              ],
            ),
          ),
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
      controller: emailController,
      errorText: emailIsNull,
      translation: kEmail,
      validator: (value) => validatorEmail(value, context),
    );
  }

  Widget buildUserPassword() {
    return BlurEditText(
      controller: passwordController,
      errorText: passwordIsNull,
      obscureText: true,
      validator: (value) => validatorPasswordRequired(value, context),
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

  Widget buildLoginButton(BuildContext buildContext) {
    return AppButton(
      translation: kLogin,
      borderColor: AppColor.brown,
      textColor: AppColor.brown,
      onTap: () {
        if (formKey.currentState!.validate()) {
          if (emailController.text == adminEmail &&
              passwordController.text == adminPassword) {
            popAllAndPushName(context, AppRouter.homeScreen);
          } else {
            final snackBar = SnackBar(
                content: AppTextDisplay(
              translation: kAuthNotCorrect,
              color: AppColor.white,
            ));
            _scaffoldKey.currentState!.showSnackBar(snackBar);
          }
        }
      },
    );
  }
}

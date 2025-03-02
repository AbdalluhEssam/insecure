import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:insecure/core/constant/icon_broken.dart';
import 'package:insecure/core/constant/imageassets.dart';
import 'package:insecure/core/helper/spacing.dart';
import 'package:insecure/core/theming/styles.dart';
import '../../controller/login_controller.dart';
import '../../../../core/class/handlingdataview.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/functions/alertextiapp.dart';
import '../../../../core/functions/validinput.dart';
import '../widget/auth/custombuttonauth.dart';
import '../widget/auth/customtextformauth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: alertExitApp,
          child: GetBuilder<LoginControllerImp>(
            builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: SingleChildScrollView(
                child: Form(
                  key: controller.formState,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(30.0.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImageAssets.logoApp),
                            horizontalSpace(15),
                            Text(
                              "Insecure",
                              style: AppFonts.font24BlackBold,
                            )
                          ],
                        ),
                        verticalSpace(30),
                        Container(
                          width: context.width,
                          height: context.height * 0.7,
                          margin: EdgeInsets.symmetric(vertical: 20.h),
                          padding: EdgeInsets.all(24.r),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColor.white,
                            border: Border.all(
                                color: AppColor.black.withOpacity(0.5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome !",
                                style: AppFonts.font19BoldBlackColor,
                              ),
                              verticalSpace(15),
                              Text(
                                "Sign in to your account ",
                                style: AppFonts.font24BoldBlackColor,
                              ),
                              verticalSpace(30),
                              CustomFormAuth(
                                isNamber: false,
                                valid: (val) {
                                  return validInput(val!, 1, 100, "code");
                                },
                                onChanged: (val) {
                                  controller.formState.currentState!.validate();
                                  return null;
                                },
                                mycontroller: controller.email,
                                label: "Student Code",
                                hinttext: "Enter your Code",
                                iconData: IconBroken.Message,
                              ),
                              verticalSpace(12),
                              GetBuilder<LoginControllerImp>(
                                builder: (controller) => CustomFormAuth(
                                  isNamber: false,
                                  onTap: () {
                                    controller.showPassword();
                                  },
                                  obscureText: controller.isShowPassword,
                                  valid: (val) {
                                    return validInput(val!, 1, 40, "password");
                                  },
                                  onChanged: (val) {
                                    controller.formState.currentState!
                                        .validate();
                                    return null;
                                  },
                                  mycontroller: controller.password,
                                  label: "Password",
                                  hinttext: "Enter your password".tr,
                                  iconData: controller.isShowPassword
                                      ? FontAwesome.eye_off
                                      : FontAwesome.eye,
                                ),
                              ),
                              CheckboxListTile(
                                checkColor: AppColor.white,
                                activeColor: AppColor.primaryColor,
                                value: controller.isRemember,
                                onChanged: (value) {
                                  controller.isRemember = value!;

                                  controller.update();
                                },
                                title: Text("Remember me"),
                                dense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 6,
                                ),
                                visualDensity: VisualDensity.compact,
                                controlAffinity: ListTileControlAffinity
                                    .leading, // Place checkbox on the left
                              ),
                              verticalSpace(16),
                              CustomButtonAuth(
                                text: "Login",
                                onPressed: () async {
                                  await controller.login();
                                },
                              ),
                              verticalSpace(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login as teaching member ?",
                                    style: TextStyle(
                                        color: AppColor.gray,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.spMin),
                                  ),
                                  horizontalSpace(8),
                                  GestureDetector(
                                    onTap: () {
                                      controller.update();
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.spMin,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpace(8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:insecure/core/constant/icon_broken.dart';
import 'package:insecure/core/constant/imageassets.dart';
import 'package:insecure/core/constant/routes.dart';
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
              widget: Form(
                key: controller.formState,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(30.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      verticalSpace(10),
                      Expanded(
                        child: Container(
                          width: context.width,
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
                              Container(
                                margin: EdgeInsets.only(top: 20.h),
                                decoration: const BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30))),
                                child: DropdownButton<String>(
                                  value: controller.selectedValue,
                                  hint: const Text(
                                    "Select your role",
                                    style: TextStyle(
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  isExpanded: true,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  underline: Container(
                                    width: Get.width,
                                    height: 1.h,
                                    decoration: const BoxDecoration(
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  dropdownColor: AppColor.white,
                                  items: controller.options.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.spMin),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.selectedValue = newValue;
                                    log(controller.selectedValue.toString());
                                    controller.update();
                                  },
                                ),
                              ),
                              verticalSpace(16),
                              CustomButtonAuth(
                                text: "Login",
                                onPressed: () async {
                                  Get.offAllNamed(AppRoute.homeScreen);
                                  // controller.myServices.sharedPreferences
                                  //     .setString("step", "2");
                                  // if (controller.selectedValue == "Doctor") {
                                  //   await controller.loginInAdmin();
                                  // } else {
                                  //   await controller.login();
                                  // }
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
                                      controller.selectedValue =
                                          "Teaching Member";
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
                      ),
                    ],
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

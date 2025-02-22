import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insecure/core/constant/routes.dart';

import '../../../core/class/statusrequest.dart';

import '../../../core/functions/handlingdatacontroller.dart';
import '../../../core/services/services.dart';
import '../data/data_source/auth/login.dart';
import '../data/model/student_model.dart';

abstract class LoginController extends GetxController {
  login();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());
  Map user = {};
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;
  StatusRequest statusRequest = StatusRequest.none;

  bool isShowPassword = true;
  bool isRemember = false;
  MyServices myServices = Get.find();
  late String token;
  late String cohortId;
  late String idNumber;
  late String nameCohorts;
  late String userID;
  late String codeSTD;
  late String nameSTD;
  late String emailSTD;
  late String studentPhone;
  late String imageUrl;

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  final nationalIdController = TextEditingController();
  String? nationalIdCode;
  String? nameCode;
  late UserModel userModel;
  @override
  login() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      await loginData.login(email.text.trim(), password.text.trim()).then(
        (value) async {
          statusRequest = handlingData(value);
          if (statusRequest == StatusRequest.success) {
            var userData = value["data"]; // بيانات المستخدم
            userModel = UserModel.fromJson(userData);

            // حفظ بيانات المستخدم في SharedPreferences
            await myServices.sharedPreferences
                .setString("user", jsonEncode(userModel.toJson()));
            await myServices.sharedPreferences.setString("step", "2");
            Get.offAllNamed(AppRoute.homeScreen);
          } else {
            Get.defaultDialog(
              title: "Error",
              middleText: "Please try again",
            );
          }
        },
      );
      update();
      // myServices.sharedPreferences.setString("step", "2");
    }
    update();
  }

  @override
  void onInit() async {
    email = TextEditingController();
    password = TextEditingController();
    // userModel = UserModel();
//  await FirebaseMessaging.instance.subscribeToTopic("general");

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}

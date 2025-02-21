

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/statusrequest.dart';

import '../../../core/functions/handlingdatacontroller.dart';
import '../../../core/services/services.dart';
import '../data/data_source/auth/login.dart';

abstract class LoginController extends GetxController {
  login();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());
  Map user = {};
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final GlobalKey<FormState> formState2 =
      GlobalKey<FormState>(); // Key for the second form

  late TextEditingController email;
  late TextEditingController password;
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestCode = StatusRequest.none;
  StatusRequest statusRequestLink = StatusRequest.none;

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

  String? selectedValue = "Student";

  final List<String> options = [
    'Student',
    'Doctor',
    'Guardian',
  ];
  final nationalIdController = TextEditingController();
  String? nationalIdCode;
  String? nameCode;

  @override
  login() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      await loginData.getToken(email.text.trim(), password.text.trim()).then(
        (value) async {
          statusRequest = handlingData(value);
        },
      );

      // myServices.sharedPreferences.setString("step", "2");
    }
    update();
  }

  @override
  void onInit() async {
    email = TextEditingController();
    password = TextEditingController();

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

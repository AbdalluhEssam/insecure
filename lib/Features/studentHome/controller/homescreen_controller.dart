import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insecure/Features/auth/data/model/student_model.dart';
import 'package:insecure/core/constant/imageassets.dart';
import 'package:insecure/core/constant/routes.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/services/services.dart';

abstract class HomeScreenController extends GetxController {}

class HomeScreenControllerImp extends HomeScreenController {
  MyServices myServices = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;
  late StatusRequest statusRequest;
  late String tokenSTD;
  late String tokenFirebase;
  late String idUserID;
  String userName = "";
  String userRole = "";
  String profileImage = "";
  void logout() async {
    await myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login);
  }

  // بيانات القائمة
  final List<Map<String, String>> menuItems = [
    {
      "title": "New complaint",
      "image": AppImageAssets.onBoardingImage1,
      "route": AppRoute.complaintScreen
    },
    {
      "title": "Complaint status",
      "image": AppImageAssets.onBoardingImage2,
      "route": AppRoute.complaintStatus
    },
  ];
  final List<Map<String, String>> doctorItems = [
    {
      "title": "Browse the complaint",
      "image": AppImageAssets.onBoardingImage1,
      "route": AppRoute.complaintScreen
    },
    {
      "title": "Check-out",
      "image": AppImageAssets.onBoardingImage2,
      "route": AppRoute.complaintStatus
    },
  ];

  // المتغيرات لحفظ حالة الإشعارات والتحديثات
  var isNotificationEnabled = false;
  var isUpdatesEnabled = false;

  // دالة لتبديل حالة الإشعارات
  void toggleNotification(bool value) {
    isNotificationEnabled = value;
    update();
  }

  // دالة لتبديل حالة التحديثات
  void toggleUpdates(bool value) {
    isUpdatesEnabled = value;
    update();
  }

  late UserModel userModel;

  Future<UserModel?> getUserData() async {
    String? userData = myServices.sharedPreferences.getString("user");

    userModel = UserModel.fromJson(jsonDecode(userData!));
    return userModel;
  }

  String imageSTD = '';
  String nameSTD = '';

  @override
  void onInit() async {
    getUserData();
    await FirebaseMessaging.instance.subscribeToTopic("users");
    await FirebaseMessaging.instance.subscribeToTopic(idUserID.toString());
    debugPrint("Successfully subscribed to 'admin' topic.");

    super.onInit();
  }
}

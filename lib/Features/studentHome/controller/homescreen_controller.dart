import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:insecure/Features/studentHome/screen/views/complaint_screen.dart';
import 'package:insecure/Features/studentHome/screen/views/home_view.dart';
import 'package:insecure/core/constant/imageassets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/class/download_app.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/icon_broken.dart';
import '../../../core/functions/translatedordatabase.dart';
import '../../../core/services/services.dart';
import '../../settings/screen/views/profile_view.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int currentPage);
}

class HomeScreenControllerImp extends HomeScreenController {
  MyServices myServices = Get.find();
  int currentIndex = 0;
  late StatusRequest statusRequest;
  late String tokenSTD;
  late String tokenFirebase;
  late String idUserID;
  final String userName = "Mohamed Elased";
  final String userRole = "Student - MIS 521111";
  final String profileImage = "assets/images/profile.png";

  // بيانات القائمة
  final List<Map<String, String>> menuItems = [
    {
      "title": "New complaint",
      "image": AppImageAssets.onBoardingImage1,
      "route": "/newComplaint"
    },
    {
      "title": "Complaint status",
      "image": AppImageAssets.onBoardingImage2,
      "route": "/complaintStatus"
    },
  ];
  List<AppBar> listOfAppBar = [
    AppBar(
      title: Text(
        "OI Tawasol".tr,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
          fontFamily: "Cairo",
        ),
      ),
    ),
    AppBar(
      title: const Text('الشكاوي و الاقتراحات'),
    ),
    AppBar(
      title: const Text("طريقة الاستخدام"),
    ),
    AppBar(
      toolbarHeight: 0,
      // title: const Text("الاعدادات"),
    )
  ];

  List<Widget> listPage = [
    const HomeStudentView(),
    const ComplaintScreen(),
    const ProfileEditScreen(),
  ];

  List<IconData> listOfIcons = [
    IconBroken.Home,
    IconBroken.Activity,
    IconBroken.Discovery,
    IconBroken.Setting,
  ];

  void updateListOfStrings(String langCode) {
    listOfStrings = [
      translateDataBase("الرئسية", "Home", langCode),
      translateDataBase("الشكاوى", "Complaints", langCode),
      translateDataBase("الاستخدام", "use", langCode),
      translateDataBase("الاعدادات", "Settings", langCode),
    ];
    update(); // Trigger UI update
  }

  List<String> listOfStrings = [
    translateDataBase("الرئسية", "الرئسية"),
    translateDataBase("الشكاوى", "الشكاوى"),
    translateDataBase("الاستخدام", "الاستخدام"),
    translateDataBase("الاعدادات", "الاعدادات"),
  ];

  @override
  changePage(currentPage) {
    currentIndex = currentPage;
    update();
    HapticFeedback.lightImpact();
    update();
  }

  initData() {
    tokenSTD = myServices.sharedPreferences.getString("tokenLogin") ?? "";
    imageSTD = myServices.sharedPreferences.getString("studentPhoto") ?? "";
    idUserID = myServices.sharedPreferences.getString("code") ?? "";
    nameSTD = myServices.sharedPreferences.getString("studentName") ?? "";

    log(idUserID.toString());
  }

  String imageSTD = '';
  String nameSTD = '';

  Future<void> subscribeToAdminTopic() async {
    try {
      // Check for the APNs token on iOS
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();

      if (apnsToken == null) {
        // Retry fetching the token if it's not yet available
        debugPrint("APNs token is not set. Retrying...");
        return Future.delayed(
            const Duration(seconds: 1), subscribeToAdminTopic);
      }

      // Proceed to subscribe to the topic
      await FirebaseMessaging.instance.subscribeToTopic("users");
      await FirebaseMessaging.instance.subscribeToTopic(idUserID.toString());
      debugPrint("Successfully subscribed to 'admin' topic.");
    } catch (e) {
      debugPrint("Error subscribing to topic: $e");
    }
  }

  @override
  void onInit() async {
    initData();
    if (Platform.isIOS) {
      subscribeToAdminTopic();
    } else {
      await FirebaseMessaging.instance.subscribeToTopic("users");
      await FirebaseMessaging.instance.subscribeToTopic(idUserID.toString());
      debugPrint("Successfully subscribed to 'admin' topic.");
    }
    _checkAppVersion();
    super.onInit();
  }

  String storeUrl = ''; // URL from Firebase
  String videoUrl = ''; // URL from Firebase
  bool payment = true; // URL from Firebase
  bool isUpdate = false;

  Future<void> _checkAppVersion() async {
    try {
      // Get app's current version
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      // Fetch app version info from Firebase Firestore
      FirebaseFirestore fireStore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot = await fireStore
          .collection('appInfo') // Collection in Firestore
          .doc('version') // Document containing version info
          .get();

      // Ensure the document exists and has data
      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        String latestVersion = data['latestVersion'];
        storeUrl = data['storeUrl'];
        isUpdate = data['update'];

        myServices.sharedPreferences.setString("storeUrl", storeUrl);

        videoUrl = data['videoUrl'];
        payment = data['payment'];
        myServices.sharedPreferences.setBool("payment", payment);

        log("latestVersion: $latestVersion");
        log("currentVersion: $currentVersion");

        listPage = [
          const HomeStudentView(),
          const ComplaintScreen(),
          const ProfileEditScreen(),
        ];
        update();
        // If versions don't match, show update dialog
        if (isUpdate == true && Platform.isAndroid) {
          if (currentVersion != latestVersion) {
            showUpdateDialog(storeUrl);
          }
        }
      } else {
        log('Document does not exist or is missing data');
      }
    } catch (e) {
      log('Error fetching version info: $e');
    }
  }
}

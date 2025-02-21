import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/functions/handlingdatacontroller.dart';
import '../../../core/services/services.dart';
import '../data/data_source/home_data.dart';
import '../screen/widget/dilog.dart';

abstract class ComplaintStudentController extends GetxController {
  addData(BuildContext context);
}

class ComplaintStudentControllerImp extends ComplaintStudentController {
  HomeData homeData = HomeData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  late String chortsId;
  late String idUserID;
  late String emailSTD;
  late String nameSTD;
  late String imageSTD;
  late String phoneSTD;
  late String codeSTD;
  late String tokenSTD;
  late String departmentSTD;
  late String studentBand;
  late bool isAdmin;

  initData() {
    chortsId = myServices.sharedPreferences.getString("chortsId") ?? "";
    emailSTD = myServices.sharedPreferences.getString("studentEmail") ?? "";
    nameSTD = myServices.sharedPreferences.getString("studentName") ?? "";
    imageSTD = myServices.sharedPreferences.getString("studentPhoto") ?? "";
    phoneSTD = myServices.sharedPreferences.getString("studentPhone") ?? "";
    codeSTD = myServices.sharedPreferences.getString("code") ?? "";
    tokenSTD = myServices.sharedPreferences.getString("tokenLogin") ?? "";
    departmentSTD = myServices.sharedPreferences.getString("studentDepartment") ?? "";
    studentBand = myServices.sharedPreferences.getString("studentBand") ?? "";
    idUserID = myServices.sharedPreferences.getString("idUserID") ?? "";
    isAdmin = myServices.sharedPreferences.getBool("isAdmin") ?? false;

    log(tokenSTD.toString());
    log("idUserID :$idUserID");
  }

  int typeSTD() {
    if (codeSTD[0] == "2") {
      return 2;
    } else {
      return 1;
    }

  }

  bool done = false;

  @override
  addData(context) async {
    if (formState.currentState?.validate() == true) {
      statusRequest = StatusRequest.loading;
      update(); // Update UI to show loading state
      try {
        // Generate complaint data
        String currentDate = DateFormat.yMd().format(DateTime.now()).toString();

        // Send complaint data
        var response = await homeData.addComplaintData(
          codeSTD.toString(),
          selectedCategory.toString(),
          addressController.text,
          detailsController.text,
          currentDate.toString(),
          typeSTD().toString(),
          tokenSTD.toString(),
          idUserID.toString(),
        );

        log("===================response=================== ${response.toString()}");

        // Handling the response and checking the status
        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          if (response['status'] == "success") {
            await Get.dialog(const ShowAlert());
            update();
            addressController.clear();
            detailsController.clear();
            // selectedCategory = '';
          }
          // If successful, show success alert dialog
        } else {
          statusRequest = StatusRequest.none;
          await Get.dialog(const ShowAlertError());
          update();

          log("Request failed with status: $statusRequest");
        }
      } catch (e, stacktrace) {
        // Log the error and stacktrace for debugging
        log("------------------//onError///------------------  $e");
        log(stacktrace.toString());
      } finally {
        // Ensure the UI is updated after the request completes
        statusRequest = StatusRequest.failure;
        update();
      }
    }
  }

  Map<String, String> complaintTypes = {
    "Education": "مشاكل تعليمية",
    "Technical": "مشكلة تقنية",
    "Students": "مشاكل طلابية",
    "Public": "مشكلة عامة",
  };


  @override
  void onInit() async{

    initData();
    typeSTD();

    statusRequest = StatusRequest.success;
    super.onInit();
  }

  String? selectedCategory;
  TextEditingController addressController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
}

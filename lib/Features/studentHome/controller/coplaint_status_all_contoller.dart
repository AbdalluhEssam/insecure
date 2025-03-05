import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:insecure/Features/auth/data/model/student_model.dart';
import 'package:insecure/core/functions/handlingdatacontroller.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/services/services.dart';
import '../data/data_source/home_data.dart';
import '../data/model/complain_model.dart';
import 'package:flutter/material.dart';

class ComplaintStatusAllController extends GetxController {
  HomeData homeData = HomeData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  List<ComplainAllModel> complaints = [];

  @override
  void onInit() {
    getUserData();
    log(userModel.userId.toString());
    fetchComplaints();
    super.onInit();
  }

  late UserModel userModel;

  Future<UserModel?> getUserData() async {
    String? userData = myServices.sharedPreferences.getString("user");

    userModel = UserModel.fromJson(jsonDecode(userData!));
    return userModel;
  }

  void fetchComplaints() async {
    complaints.clear();
    try {
      statusRequest = StatusRequest.loading;
      update(); // تحديث الواجهة لعرض حالة التحميل

      var response = await homeData.getAllComplaints();

      log("=================== response =================== ${response.toString()}");

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success &&
          response['status'] == "success") {
        statusRequest = StatusRequest.success;
        List data = response['data'] as List;

        complaints.addAll(data.map((e) => ComplainAllModel.fromJson(e)));

        update();
      } else {
        statusRequest = StatusRequest.failure;
        update(); // تحديث الواجهة لعرض حالة التحميل
      }
    } catch (e) {
      log("Error fetching complaints: $e");
      statusRequest = StatusRequest.failure;
      update(); // تحديث الواجهة لعرض حالة التحميل
    } finally {
      update();
    }
  }

  TextEditingController complaintReply = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void replayComplaints(String complaintId) async {
    if (formKey.currentState!.validate()) {
      try {
        statusRequest = StatusRequest.loading;
        update(); // تحديث الواجهة لعرض حالة التحميل

        var response =
            await homeData.replayComplaints(complaintReply.text, complaintId);

        log("=================== response =================== ${response.toString()}");

        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success &&
            response['status'] == "success") {
          statusRequest = StatusRequest.success;
          fetchComplaints();

          update();
        } else {
          statusRequest = StatusRequest.failure;
          update(); // تحديث الواجهة لعرض حالة التحميل
        }
      } catch (e) {
        log("Error fetching complaints: $e");
        statusRequest = StatusRequest.failure;
        update(); // تحديث الواجهة لعرض حالة التحميل
      } finally {
        update();
      }
    }
  }
}

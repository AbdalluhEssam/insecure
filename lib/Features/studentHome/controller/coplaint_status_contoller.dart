import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:insecure/Features/auth/data/model/student_model.dart';
import 'package:insecure/core/functions/handlingdatacontroller.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/services/services.dart';
import '../data/data_source/home_data.dart';
import '../data/model/complain_model.dart';

class ComplaintStatusController extends GetxController {
  HomeData homeData = HomeData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  List<ComplainModel> complaints = [];

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

      var response = await homeData.getComplaints(userModel.userId.toString());

      log("=================== response =================== ${response.toString()}");

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success &&
          response['status'] == "success") {
        statusRequest = StatusRequest.success;
        List data = response['data'] as List;

        complaints.addAll(data.map((e) => ComplainModel.fromJson(e)));

        update();
      }
    } catch (e) {
      log("Error fetching complaints: $e");
    } finally {
      update();
    }
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:insecure/Features/auth/data/model/student_model.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/constant/routes.dart';
import '../../../core/services/services.dart';
import '../data/data_source/home_data.dart';
import '../data/model/complain_model.dart';

class ComplaintStatusController extends GetxController {
  HomeData homeData = HomeData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  var complaints = <ComplainModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getUserData();
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
    try {
      isLoading(true);
      var response = await homeData.getComplaints(userModel.userId);
      if (statusRequest == StatusRequest.success) {
        var data = json.decode(response.body) as List;
        complaints.value =
            data.map((json) => ComplainModel.fromJson(json)).toList();
      }
    } finally {
      isLoading(false);
    }
  }
}

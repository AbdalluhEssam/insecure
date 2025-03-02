import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insecure/Features/auth/data/model/user_model.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/functions/handlingdatacontroller.dart';
import '../../../core/services/services.dart';
import '../data/data_source/home_data.dart';
import '../screen/widget/dilog.dart';

abstract class ComplaintStudentController extends GetxController {
  addData();
}

class ComplaintStudentControllerImp extends ComplaintStudentController {
  HomeData homeData = HomeData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  var subjectController = TextEditingController();
  var contentController = TextEditingController();
  var selectedComplaintType = "شكاوى تكنولوجيا".obs;
  var selectedAuthority = "الموارد البشرية".obs;
  var replyController = TextEditingController();
  var selectedImage = Rx<File?>(null); // الآن يمكن أن تكون الصورة `null`

  final List<String> complaintTypes = [
    "شكاوى تكنولوجيا",
    "شكاوى تعلمية",
    "شكاوى شخصية",
    "شكاوى عامة"
  ];
  final List<String> authorities = [
    "الموارد البشرية",
    "اعضاء هيئة التدريس",
    "اعضاء الهيئة المعاونة",
    "العميد"
  ];

  var selectedComplaintTypeIndex = 0.obs;
  var selectedAuthorityIndex = 0.obs;

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void sendComplaint() {
    Get.snackbar("نجاح", "تم إرسال الشكوى بنجاح");
  }

  late UserModel userModel;

  Future<UserModel?> getUserData() async {
    String? userData = myServices.sharedPreferences.getString("user");

    userModel = UserModel.fromJson(jsonDecode(userData!));
    return userModel;
  }

  @override
  addData() async {
    if (formState.currentState?.validate() == true) {
      statusRequest = StatusRequest.loading;
      update(); // تحديث الواجهة لعرض حالة التحميل

      try {
        var response = await homeData.addComplaintData(
          subjectController.text,
          contentController.text,
          selectedComplaintTypeIndex.value.toString(),
          selectedAuthorityIndex.value.toString(),
          userModel.userId.toString(),
          selectedImage.value, // الآن يمكن أن يكون `null`
        );

        log("=================== response =================== ${response.toString()}");

        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          if (response['status'] == "success") {
            await Get.dialog(const ShowAlert());
            subjectController.clear();
            contentController.clear();
            selectedImage.value = null; // إعادة تعيين الصورة بعد الإرسال
            Get.back();
            update();
          }
        } else {
          statusRequest = StatusRequest.none;
          await Get.dialog(const ShowAlertError());
          update();
          log("Request failed with status: $statusRequest");
        }
      } catch (e, stacktrace) {
        log("⚠️ خطأ أثناء إرسال البيانات: $e");
        log(stacktrace.toString());
      } finally {
        statusRequest = StatusRequest.failure;
        update();
      }
    }
  }

  @override
  void onInit() {
    statusRequest = StatusRequest.success;
    getUserData();
    log(userModel.userId.toString());
    super.onInit();
  }
}

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/apptheme.dart';
import '../../../core/constant/routes.dart';
import '../../../core/services/services.dart';
import '../../studentHome/controller/homescreen_controller.dart';

class SettingsController extends GetxController {
  MyServices myServices = Get.find();
  late String idUser;
  late String approve;
  late String nameCohorts;
  late String idNumber;
  late String cohortId;
  bool isAdmin = false;
  bool s = false;

  final ThemeService themeService = ThemeService();
  bool isDarkMode = ThemeService().isDarkMode();

  // payment = data['payment'];
  // myServices.sharedPreferences.setBool("payment", payment);

  late bool payment;

  void changeTheme() {
    themeService.changeTheme();
    isDarkMode = themeService.isDarkMode();
    if (isAdmin == false) {
      controllerImp.update();
    }

    update(); // Notify UI to rebuild
  }

  File? selectedImageFile;
  bool isImageSelected = false;

  void updateImage({String? newImageUrl, File? newImageFile}) {
    if (newImageUrl != null) {
      imageUrl = newImageUrl;
    }
    if (newImageFile != null) {
      selectedImageFile = newImageFile;
      isImageSelected = true; // تحديث حالة اختيار الصورة
    }

    update(); // تحديث الـ UI بعد تغيير الصورة
  }

  void uploadToServerImage() {
    if (selectedImageFile != null) {
      log("Image uploaded: ${selectedImageFile!.path}");

      // عرض التنبيه لتأكيد التغيير
      Get.dialog(
        AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "تنبيه",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            "هل تريد التغير الى هذه الصورة؟",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // إغلاق الـ Dialog بدون تحميل
              },
              child: const Text(
                "لا",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (statusRequest == StatusRequest.loading)
              const Center(child: CircularProgressIndicator()),
            if (statusRequest == StatusRequest.failure)
              const Center(child: Text("Error occurred!")), // خطأ
            if (statusRequest == StatusRequest.none)
              ElevatedButton(
                onPressed: () async {
           
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  "نعم",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 24.0,
        ),
      );
    } else {
      log("No image to upload.");
    }
  }

 

  void pickImage(BuildContext context, SettingsController controller) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        File imageFile = File(pickedImage.path); // تخزين الصورة كملف
        controller.updateImage(newImageFile: imageFile);
      } else {
        log("No image selected.");
      }
    } catch (e) {
      log("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("حدث خطأ أثناء اختيار الصورة. حاول مرة أخرى.")),
      );
    }
  }

  StatusRequest statusRequest = StatusRequest.none;

  late String tokenSTD;
  late String codeSTD;
  late String imageUrl;
  late String nameProfile;
  late String emailProfile;
  late String typeInstitute;
  late String storeUrl;

  initData() {
    idUser = myServices.sharedPreferences.getString("idUser") ?? '';
    storeUrl = myServices.sharedPreferences.getString("storeUrl") ?? '';
    typeInstitute =
        myServices.sharedPreferences.getString("typeInstitute") ?? '';
    log("typeInstitute : $typeInstitute".toString());
    isAdmin = myServices.sharedPreferences.getBool("isAdmin") ?? false;
    tokenSTD = myServices.sharedPreferences.getString("tokenLogin") ?? "";
    codeSTD = myServices.sharedPreferences.getString("code") ?? "";
    payment = myServices.sharedPreferences.getBool("payment") ?? false;
    nameCohorts = myServices.sharedPreferences.getString("nameCohorts") ?? "";
    idNumber = myServices.sharedPreferences.getString("idNumber") ?? "";
    imageUrl = isAdmin == true
        ? "${myServices.sharedPreferences.getString("publisherImage")}"
        : "${myServices.sharedPreferences.getString("studentPhoto")}";

    nameProfile = isAdmin == true
        ? '${myServices.sharedPreferences.getString("adminPublisherName")}'
        : '${myServices.sharedPreferences.getString("name")}';

    nameProfile = isAdmin == true
        ? '${myServices.sharedPreferences.getString("adminPublisherName")}'
        : '${myServices.sharedPreferences.getString("name")}';
    emailProfile = myServices.sharedPreferences.getString("email") ?? '';

    log(tokenSTD.toString());
  }


  

 
  late HomeScreenControllerImp controllerImp;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  logout() {
    // String id = myServices.sharedPreferences.getString("id") ?? "";
    FirebaseMessaging.instance.unsubscribeFromTopic(tokenSTD.toString());
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login);
  }
}

import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/routes.dart';
import '../../../core/functions/handlingdatacontroller.dart';
import '../../../core/services/services.dart';
import '../data/data_source/home_data.dart';
import '../data/model/posts_model.dart';

abstract class HomeStudentController extends GetxController {
  getData();
}

class HomeStudentControllerImp extends HomeStudentController {
  HomeData homeData = HomeData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  List<PostsModel> posts = [];

  StatusRequest statusRequest = StatusRequest.none;

  MyServices myServices = Get.find();

  late String chortsId;
  late String idUserID;
  late String emailSTD;
  late String nameSTD;
  late String imageSTD;
  late String phoneSTD;
  late String codeSTD;
  late String departmentSTD;
  late String studentBand;
  late String tokenSTD;
  late String tokenFirebase;
  PostsModel postsModel = PostsModel();

  var scannedData = ''.obs;

  // Method to handle the scanned data
  void handleScan(String data) {
    scannedData.value = data;
    Get.back(); // Close the scanner screen
  }

  initData() {
    chortsId = myServices.sharedPreferences.getString("chortsId") ?? "";
    emailSTD = myServices.sharedPreferences.getString("studentEmail") ?? "";
    nameSTD = myServices.sharedPreferences.getString("studentName") ?? "";
    imageSTD = myServices.sharedPreferences.getString("studentPhoto") ?? "";
    phoneSTD = myServices.sharedPreferences.getString("studentPhone") ?? "";
    codeSTD = myServices.sharedPreferences.getString("idUser") ?? "";
    tokenSTD = myServices.sharedPreferences.getString("tokenLogin") ?? "";
    departmentSTD = myServices.sharedPreferences.getString("studentDepartment") ?? "";
    studentBand = myServices.sharedPreferences.getString("studentBand") ?? "";
    idUserID = myServices.sharedPreferences.getString("idUserID") ?? "";
    log(tokenSTD.toString());
    log(idUserID.toString());
  }

  @override
  getData() async {
    posts.clear();
    try {
      statusRequest = StatusRequest.loading;
      update();
      var response = await homeData.getPostsData(departmentSTD, studentBand, codeSTD, tokenSTD, idUserID);
      statusRequest = handlingData(response);

      log("===================response=================== ${response.toString()}");

      log("===================response=================== ${response.toString()}");

      // التحقق من الاستجابة
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        log("===================responseHandlingData=================== ${response.toString()}");

        // التحقق إذا كان الرد عبارة عن Map ويحتوي على status و data
        if (response is Map && response.containsKey('status') && response.containsKey('data')) {
          String status = response['status'];
          dynamic data = response['data'];

          // إذا كانت حالة الرد هي success، نقوم بمعالجة البيانات
          if (status == 'success') {
            if (data is List) {
              // البيانات هي قائمة من المنشورات
              List<PostsModel> postList = data.map((e) {
                try {
                  return PostsModel.fromJson(e);
                } catch (e) {
                  log("Error parsing post: $e");
                  return null; // Handle parsing error
                }
              }).where((post) => post != null).cast<PostsModel>().toList(); // Remove any nulls

              // استخدام مجموعة Set لتجنب تكرار المنشورات حسب postText
              Set<String> uniquePostTexts = {};
              List<PostsModel> uniquePosts = [];

              for (var post in postList) {
                // تأكد من أن postText ليس null قبل التحقق منه
                if (post.postText != null && !uniquePostTexts.contains(post.postText)) {
                  uniquePostTexts.add(post.postText!); // استخدام `!` للتأكد من أن القيمة ليست null
                  uniquePosts.add(post);
                }
              }

              posts.addAll(uniquePosts);
              log("Total unique posts added: ${posts.length}");
            } else {
              log("Unexpected data format: ${data.toString()}");
            }
          } else if (status == 'no_data') {
            log("No posts found.");
            // يمكنك إضافة رسالة هنا تشير إلى أنه لا توجد بيانات جديدة
          } else {
            log("Unknown status: $status");
          }
        } else {
          log("Invalid response structure.");
        }
      } else {
        log("Request failed with status: $statusRequest");
      }
    } catch (e) {
      log("------------------//onError///------------------  $e");
    } finally {
      update();
    }
  }



  logout() {
    // String id = myServices.sharedPreferences.getString("id") ?? "";
    FirebaseMessaging.instance.unsubscribeFromTopic(tokenSTD.toString());
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login);
  }

  @override
  void onInit() async {
    initData();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values); // to re-show bars
    getData();
    super.onInit();
  }


  RegExp urlRegExp = RegExp(r"http(s)?://([\w-]+\.)+[\w-]+(/[\w- ;,./?%&=]*)?",
      caseSensitive: false, multiLine: true);

  RegExp urlRegExpImage = RegExp(
    r"http(s)?://([\w-]+\.)+[\w-]+(/[\w- ;,./?%&=]*)?\.(jpeg|jpg|gif|png|bmp)",
    caseSensitive: false,
    multiLine: true,
  );

  bool hasLink = false;
  bool hasLinkController = false;

  bool containsLink(String text) {
    return urlRegExp.hasMatch(text);
  }

  bool containsLinkImage(String text) {
    return urlRegExpImage.hasMatch(text);
  }

  String extractLink(String text) {
    RegExpMatch? match = urlRegExp.firstMatch(text);
    return match != null ? match.group(0)! : '';
  }

  String extractLinkImage(String text) {
    RegExpMatch? match = urlRegExpImage.firstMatch(text);
    return match != null ? match.group(0)! : '';
  }

  String removeLinks(String text) {
    return text.replaceAll(urlRegExp, '');
  }

  List<TextSpan> buildTextWithLinks(String text) {
    // Regular expression to find URLs
    final RegExp linkRegExp = RegExp(
      r"(https?:\/\/[^\s]+)", // Matches URLs starting with http or https
      caseSensitive: false,
    );

    List<TextSpan> spans = [];
    int currentIndex = 0;

    // Loop through all the matches
    for (final match in linkRegExp.allMatches(text)) {
      // Add any text before the match as a normal span
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
        ));
      }

      // Add the matched URL as a clickable link
      final String url = match.group(0)!;
      spans.add(TextSpan(
        text: url,
        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            final Uri urlS = Uri.parse(url);
            if (!await launchUrl(urlS)) throw 'Could not launch $urlS';
          },
      ));

      currentIndex = match.end;
    }

    // Add any remaining text after the last match
    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
      ));
    }

    return spans;
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insecure/core/class/statusrequest.dart';
import 'package:lottie/lottie.dart';
import '../constant/imageassets.dart';

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataRequest({
    super.key,
    required this.statusRequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Center(
              child:
                  Lottie.asset(AppImageAssets.loading, width: 250, height: 250),
            ),
          )
        : statusRequest == StatusRequest.offlineFailure
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AppImageAssets.offline,
                        width: 250, height: 250),
                    const SizedBox(height: 20),
                    const Text("لا يوجد اتصال بالإنترنت."),
                    const SizedBox(height: 20),
                    _retryButton(),
                  ],
                ),
              )
            : statusRequest == StatusRequest.serverFailure
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(AppImageAssets.offline,
                            width: 250, height: 250),
                        const SizedBox(height: 20),
                        const Text("لا يوجد اتصال بالإنترنت."),
                        const SizedBox(height: 20),
                        _retryButton(),
                      ],
                    ),
                  )
                : statusRequest == StatusRequest.failure
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(AppImageAssets.emptyDo),
                              const SizedBox(height: 20),
                              const Text("لم يتم العثور على بيانات."),
                            ],
                          ),
                        ),
                      )
                    : widget;
  }

  Widget _retryButton() {
    return ElevatedButton(
      onPressed: () {
        // Replace this with your reload function
        _reloadApp();
      },
      child: const Text("اعاده التحميل"),
    );
  }

  void _reloadApp() {
    // استخدم Get لتحديث التطبيق أو إعادة توجيه المستخدم
    Get.offAllNamed("/"); // استبدل `/` بالمسار الأساسي لشاشتك الرئيسية
  }
}

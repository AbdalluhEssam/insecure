import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insecure/Features/studentHome/controller/complaint_controller.dart';
import 'package:insecure/Features/studentHome/screen/widget/complaint_view.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ComplaintStudentControllerImp());
    return GetBuilder<ComplaintStudentControllerImp>(
      builder: (controller) => const ComplaintView(),
    );
  }
}

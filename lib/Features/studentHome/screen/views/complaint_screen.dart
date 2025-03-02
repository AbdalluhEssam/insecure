import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insecure/Features/auth/screen/widget/auth/customtextformauth.dart';
import 'package:insecure/Features/studentHome/controller/complaint_controller.dart';
import 'package:insecure/core/constant/color.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ComplaintStudentControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Complaint",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColor.backgroundColor,
        foregroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<ComplaintStudentControllerImp>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormAuth(
                      hinttext: "Enter Main Title",
                      label: "Subject",
                      iconData: Icons.title,
                      mycontroller: controller.subjectController,
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter subject";
                        }
                        return null;
                      },
                      isNamber: false),
                  SizedBox(height: 10),
                  Text("Complaint Type:"),
                  Obx(() => DropdownButtonFormField<int>(
                        value: controller.selectedComplaintTypeIndex
                            .value, // تخزين الـ index
                        decoration: InputDecoration(
                          fillColor: AppColor.secondColor.withOpacity(0.3),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.backgroundColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.backgroundColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.backgroundColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                        items: controller.complaintTypes
                            .asMap()
                            .entries
                            .map((entry) => DropdownMenuItem<int>(
                                  value:
                                      entry.key, // استخدام الـ index كـ value
                                  child: Text(entry.value),
                                ))
                            .toList(),
                        onChanged: (value) {
                          controller.selectedComplaintTypeIndex.value =
                              value! + 1;
                          log("Selected Complaint Type Index: ${controller.selectedComplaintTypeIndex.value}");
                        },
                      )),

                  SizedBox(height: 10),
                  Text("Complaint Authority:"),

                  Obx(() => DropdownButtonFormField<int>(
                        value: controller
                            .selectedAuthorityIndex.value, // تخزين الـ index
                        decoration: InputDecoration(
                          fillColor: AppColor.secondColor.withOpacity(0.3),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.backgroundColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.backgroundColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.backgroundColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                        items: controller.authorities
                            .asMap()
                            .entries
                            .map((entry) => DropdownMenuItem<int>(
                                  value:
                                      entry.key, // استخدام الـ index كـ value
                                  child: Text(entry.value),
                                ))
                            .toList(),
                        onChanged: (value) {
                          controller.selectedAuthorityIndex.value = value! + 1;
                          log("Selected Authority Index: ${controller.selectedAuthorityIndex.value}");
                        },
                      )),
                  SizedBox(height: 10),
                  CustomFormAuth(
                      hinttext: "The main content you want",
                      label: "Content of the Complaint:",
                      iconData: Icons.title,
                      mycontroller: controller.contentController,
                      maxLines: 4,
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter content of Complaint";
                        }
                        return null;
                      },
                      isNamber: false),
                  SizedBox(height: 10),
                  Text("Attach Image:"),
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.selectedImage.value !=
                              null) // عرض الصورة لو فقط تم اختيارها
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColor.secondColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColor.backgroundColor, width: 1),
                              ),
                              child: Image.file(controller.selectedImage.value!,
                                  height: 100),
                            ),
                          if (controller.selectedImage.value == null)
                            Row(children: [
                              ElevatedButton.icon(
                                onPressed: controller.pickImage,
                                icon: const Icon(Icons.image,
                                    color: Colors.white),
                                label: const Text("Choose Image",
                                    style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              const Text(
                                "Image Is Options:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                        ],
                      )),
                  const SizedBox(height: 10),

                  // إظهار حقل الرد بس لو فيه شكوى
                  // Obx(() {
                  //   if (controller.selectedComplaintType.value.isNotEmpty) {
                  //     return CustomFormAuth(
                  //         hinttext: "Enter Reply",
                  //         label: "Reply",
                  //         iconData: Icons.reply,
                  //         mycontroller: controller.replyController,
                  //         valid: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter your reply';
                  //           }
                  //           return null;
                  //         },
                  //         isNamber: false);
                  //   } else {
                  //     return const SizedBox(); // إخفاء الحقل لو مفيش شكوى
                  //   }
                  // }),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: controller.addData,
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(150.w, 50.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor: Colors.black),
                        child: Text("Send",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: Size(150.w, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

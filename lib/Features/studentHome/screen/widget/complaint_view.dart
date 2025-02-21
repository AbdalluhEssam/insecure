import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insecure/Features/studentHome/controller/complaint_controller.dart';
import 'package:insecure/view/widget/auth/customtextformauth.dart';
import '../../../../core/constant/apptheme.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/icon_broken.dart';

class ComplaintView extends StatelessWidget {
  const ComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ComplaintStudentControllerImp());
    return GetBuilder<ComplaintStudentControllerImp>(
      builder: (controller) => Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
              key: controller.formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.05),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: DropdownButton<String>(
                      icon: const Icon(
                        IconBroken.Arrow___Down_2,
                      ),
                      value: controller.selectedCategory,
                      hint: const Text('اختار فئة الشكوى'),
                      isExpanded: true,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      underline: Container(
                        width: Get.width,
                        height: 1,
                        decoration: const BoxDecoration(
                          color: AppColor.primaryColor,
                        ),
                      ),
                      dropdownColor:
                          ThemeService().getThemeMode() == ThemeMode.dark
                              ? AppColor.black
                              : AppColor.white,
                      items: controller.complaintTypes.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry
                              .key, // القيمة هي الإنجليزية، للتحقق من مطابقة القيمة
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 20),
                            child: Text(entry.value), // العرض باللغة العربية
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // التحقق إذا كانت القيمة المختارة موجودة بالفعل وتحديثها
                        if (newValue != null &&
                            newValue != controller.selectedCategory) {
                          controller.selectedCategory =
                              newValue; // سيتم تخزين القيمة الإنجليزية
                          log(controller.selectedCategory
                              .toString()); // يتم تسجيل القيمة الإنجليزية
                          controller.update();
                        }
                      },
                    ),
                  ),

                  // Dropdown

                  const SizedBox(height: 16.0),

                  CustomComplaintAdd(
                    color: ThemeService().getThemeMode() == ThemeMode.dark
                        ? AppColor.black
                        : AppColor.white,
                    hinttext: 'عنوان الشكوى',
                    label: 'عنوان الشكوى',
                    iconData: IconBroken.Info_Square,
                    mycontroller: controller.addressController,
                    onChanged: (val) {
                      controller.formState.currentState!.validate();
                      return null;

                      // return  EmailValidator.validate(controller.email.text);
                    },
                    valid: (val) {
                      if (val?.isEmpty == true) {
                        return 'برجاء ادخال عنوان الشكوى';
                      }
                      return null;
                    },
                  ),
                  // TextFormField for Address
                  const SizedBox(height: 16.0),

                  // TextFormField for Details

                  CustomComplaintAdd(
                    color: ThemeService().getThemeMode() == ThemeMode.dark
                        ? AppColor.black
                        : AppColor.white,
                    minLines: 5,
                    hinttext: 'أدخل تفاصيل شكواك هنا...',
                    label: 'تفاصيل الشكوى',
                    iconData: IconBroken.Message,
                    mycontroller: controller.detailsController,
                    onChanged: (val) {
                      controller.formState.currentState!.validate();
                      return null;

                      // return  EmailValidator.validate(controller.email.text);
                    },
                    valid: (val) {
                      if (val?.isEmpty == true) {
                        return 'الرجاء إدخال عنوان الشكوى الخاصة بك';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 80.0),

                  // Row with Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColor.white,
                          backgroundColor: AppColor.primaryColor,
                          // text and icon color (foreground)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 0.0,
                          ),
                          elevation: 5.0,
                        ),
                        onPressed: () {
                          controller.addData(context);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('أضف الشكوى'),
                      ),
                      if (controller.isAdmin == true)
                        Visibility(
                          visible: controller.idUserID.toString() == "85"
                              ? true
                              : false,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColor.white,
                              backgroundColor: AppColor.primaryColor,
                              // text and icon color (foreground)
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 0.0,
                              ),
                              elevation: 5.0,
                            ),
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.eye_solid),
                            label: const Text('عرض الشكاوى'),
                          ),
                        ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

import 'dart:developer';
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
          child: Directionality(
              textDirection: TextDirection.ltr,
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
                                topLeft: Radius.circular(30))),
                        child: DropdownButton<String>(
                          // permission
                          // menuWidth: Get.width * 0.5,
                          icon: const Icon(
                            IconBroken.Arrow___Down_2,
                          ),
                          value: controller.selectedCategory,
                          hint: const Text('Select Category'),

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

                          items: [
                            'Education',
                            'Technical',
                            'Students',
                            'Public',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 20),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.selectedCategory = newValue;
                            log(controller.selectedCategory.toString());
                            controller.update();
                          },
                        ),
                      ),

                      // Dropdown

                      const SizedBox(height: 16.0),

                      CustomComplaintAdd(
                        color: ThemeService().getThemeMode() == ThemeMode.dark
                            ? AppColor.black
                            : AppColor.white,
                        hinttext: 'Complaint Address',
                        label: 'Complaint Address',
                        iconData: IconBroken.Info_Square,
                        mycontroller: controller.addressController,
                        onChanged: (val) {
                          controller.formState.currentState!.validate();
                          return null;

                          // return  EmailValidator.validate(controller.email.text);
                        },
                        valid: (val) {
                          if (val?.isEmpty == true) {
                            return 'Please Enter Your Complaint Address';
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
                        hinttext: 'Enter your complaint details here...',
                        label: 'Complaint details',
                        iconData: IconBroken.Message,
                        mycontroller: controller.detailsController,
                        onChanged: (val) {
                          controller.formState.currentState!.validate();
                          return null;

                          // return  EmailValidator.validate(controller.email.text);
                        },
                        valid: (val) {
                          if (val?.isEmpty == true) {
                            return 'Please Enter Your Complaint Address';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 80.0),

                      // Row with Buttons
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
                        label: const Text('Add Complaint'),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}

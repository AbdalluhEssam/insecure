import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insecure/core/constant/color.dart';
import 'font_weight_helper.dart';

class AppFonts {
  static TextStyle font24BlackBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );

  static TextStyle font32BlueBold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColor.primaryColor,
  );

  static TextStyle font19BoldBlackColor = TextStyle(
    fontSize: 19.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColor.black,
  );
  static TextStyle font24BoldBlackColor = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColor.black,
  );
}

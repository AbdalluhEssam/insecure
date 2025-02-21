import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insecure/binding.dart';
import 'package:insecure/core/constant/apptheme.dart';
import 'package:insecure/core/localization/changelocal.dart';
import 'package:insecure/routes.dart';

class InsecureApp extends StatelessWidget {
  const InsecureApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());

    return ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: 'Insecure App',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,

        // theme: controller.appTheme,
        darkTheme: ThemeService().darkTheme,
        themeMode: ThemeService().getThemeMode(),
        // Load saved theme mode
        initialBinding: MyBinding(),
        getPages: routes,
      ),
    );
  }
}

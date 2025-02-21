import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:insecure/Features/auth/screen/widget/auth/link_icon_socail.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/icon_broken.dart';
import '../../../../core/constant/imageassets.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/functions/translatedordatabase.dart';
import '../../controller/settings_controller.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:share_plus/share_plus.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: GetBuilder<SettingsController>(
              builder: (controller) => CircleAvatar(
                radius: 20,
                backgroundColor: controller.isDarkMode
                    ? Colors.grey[800]
                    : AppColor.primaryColor,
                // Dynamic background color
                child: IconButton(
                  onPressed: () {
                    controller.changeTheme(); // Toggle dark mode
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => RotationTransition(
                      turns: child.key == const ValueKey('dark')
                          ? Tween<double>(begin: 1, end: 0).animate(animation)
                          : Tween<double>(begin: 0, end: 1).animate(animation),
                      child: ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                    ),
                    child: Icon(
                      controller.isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Colors.white,
                      key: ValueKey(controller.isDarkMode ? 'dark' : 'light'),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
        title: const Text("الاعدادات"),
      ),
      body: GetBuilder<SettingsController>(
        builder: (controller) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Visibility(
                        replacement: CircleAvatar(
                          radius: 53,
                          child: controller.selectedImageFile != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      FileImage(controller.selectedImageFile!))
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: CachedNetworkImageProvider(
                                      controller.imageUrl,
                                      cacheManager: CachedNetworkImageProvider
                                          .defaultCacheManager,
                                      errorListener: (value) {
                                    controller.imageUrl =
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2yqidmp-gFvaWF5m5GSFl6kf2_4lFQXqEFbvINmabBGVJ7zRkGbm4DZERx2CwmKC-Bxo&usqp=CAU';
                                    controller.update();
                                  })),
                        ),
                        visible:
                            controller.statusRequest == StatusRequest.loading,
                        child: CircleAvatar(
                          radius: 50,
                          child: Center(
                            child: Lottie.asset(AppImageAssets.loading),
                          ),
                        ),
                      ),
                      if (controller.isAdmin == true)
                        PositionedDirectional(
                          start: -3,
                          bottom: -3,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColor.primaryColor,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (controller.selectedImageFile == null) {
                                  controller.pickImage(
                                      context, controller); // اختيار الصورة
                                } else {
                                  controller
                                      .uploadToServerImage(); // رفع الصورة
                                }
                              },
                              icon: Icon(
                                controller.selectedImageFile == null
                                    ? IconBroken
                                        .Edit // الأيقونة قبل اختيار الصورة
                                    : IconBroken.Upload,
                                // الأيقونة بعد اختيار الصورة
                                size: 22,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      PositionedDirectional(
                        end: -3,
                        bottom: -3,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColor.green,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Row(
                                      children: [
                                        Icon(Icons.check_circle_outline,
                                            color: Colors.green, size: 30),
                                        SizedBox(width: 10),
                                        Text("تم الدفع بنجاح"),
                                      ],
                                    ),
                                    content: const Text(
                                        "تم سداد المصروفات الدراسية بنجاح."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 24.0,
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.done_outline_sharp,
                              size: 22,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    controller.nameProfile,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 16),
                  ),
                  if (controller.isAdmin == false)
                    Text(
                      controller.nameCohorts,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  // if (controller.isAdmin == false)
                  Text(
                    controller.emailProfile,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 14),
                  ),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline,
                          color: Colors.green, size: 30),
                      SizedBox(width: 10),
                      Text("تم سداد المصروفات الدراسية بنجاح"),
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Divider(
                    color: AppColor.primaryColor, thickness: 1, height: 40),
              ),
              const SizedBox(
                height: 10,
              ),
              TypeOfSetting(
                nameTypeOfSetting:
                    "${translateDataBase("الاعدادات العامة", "General")}",
              ),
              SettingSwitchButton(
                iconSettingSwitchButton: const Icon(
                  IconBroken.Notification,
                  size: 26,
                ),
                nameSettingSwitchButton: "غلق الاشعارات",
                initialValue: false,
                onChanged: (value) {
                  if (value == true) {
                    FirebaseMessaging.instance.unsubscribeFromTopic("general");
                    FirebaseMessaging.instance
                        .unsubscribeFromTopic(controller.tokenSTD.toString());
                  } else {
                    FirebaseMessaging.instance.subscribeToTopic("general");
                    FirebaseMessaging.instance
                        .subscribeToTopic(controller.tokenSTD.toString());
                  }
                },
              ),
              TypeOfSetting(
                nameTypeOfSetting: "${translateDataBase("عنك", "About")}",
              ),
              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    color: AppColor.primaryColor.withOpacity(0.3),
                    surfaceTintColor: AppColor.primaryColor,
                    borderOnForeground: true,
                    shadowColor: AppColor.primaryColor.withOpacity(0.7),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(
                          height: 1,
                          color: AppColor.black,
                        ),
                        buildMenuItem(
                            icon: "assets/lottie/shere.json",
                            text: translateDataBase(
                                "مشاركة التطبيق", "Share App"),
                            onClicked: () async {
                              // Get the temporary directory to save the logo file
                              final tempDir = await getTemporaryDirectory();
                              final file = File('${tempDir.path}/logoo.png');

                              // Copy logo from assets to the temporary directory
                              final byteData = await rootBundle
                                  .load('assets/images/logoApp.jpg');
                              await file
                                  .writeAsBytes(byteData.buffer.asUint8List());

                              // Share the logo and the Play Store link
                              await Share.shareXFiles([XFile(file.path)],
                                  text: controller.storeUrl,
                                  subject: 'تطبيق OI Tawasol قم بالتنزيل');
                            }),
                        const Divider(
                          height: 1,
                          color: AppColor.black,
                        ),
                        buildMenuItem(
                          text: 'about'.tr,
                          icon: "assets/lottie/aboutus.json",
                          onClicked: () => Get.toNamed(AppRoute.aboutUs),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColor.black,
                        ),
                        buildMenuItem(
                          text: 'logout'.tr,
                          icon: "assets/lottie/logout.json",
                          onClicked: () => controller.logout(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: LinkIconSocial(),
              ),
              const SizedBox(
                height: 12,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('OI TAWASOL | ©2024'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildMenuItem({
  required String text,
  required String icon,
  VoidCallback? onClicked,
}) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1),
    textColor: AppColor.white,
    child: ListTile(
      onTap: onClicked,
      leading: Lottie.asset(icon, width: 30, height: 30),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 14.spMin, // استخدام `ScreenUtil` لضبط حجم الخط حسب الشاشة
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 18,
      ),
    ),
  );
}

class TypeOfSetting extends StatelessWidget {
  final String nameTypeOfSetting;

  const TypeOfSetting({super.key, required this.nameTypeOfSetting});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                nameTypeOfSetting,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingSwitchButton extends StatefulWidget {
  final Icon iconSettingSwitchButton;
  final String nameSettingSwitchButton;
  final bool initialValue;
  final Function(bool value)? onChanged;

  const SettingSwitchButton(
      {super.key,
      required this.iconSettingSwitchButton,
      required this.nameSettingSwitchButton,
      required this.initialValue,
      this.onChanged});

  @override
  State<SettingSwitchButton> createState() => _SettingSwitchButtonState();
}

class _SettingSwitchButtonState extends State<SettingSwitchButton> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: AppColor.primaryColor, width: 2)),
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              widget.iconSettingSwitchButton,
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  width: Get.width * 0.4,
                  child: Text(
                    widget.nameSettingSwitchButton,
                    overflow: TextOverflow.ellipsis,
                  )),
              const Spacer(),
              Switch(
                value: _value,
                onChanged: (newValue) {
                  setState(() {
                    _value = newValue;
                  });

                  if (widget.onChanged != null) {
                    widget.onChanged!(newValue);
                  }
                },
                focusColor: AppColor.primaryColor,
                hoverColor: AppColor.primaryColor,
                activeColor: AppColor.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

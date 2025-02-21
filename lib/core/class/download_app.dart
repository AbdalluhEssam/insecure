import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:insecure/core/constant/icon_broken.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import '../constant/color.dart';
import '../constant/imageassets.dart';
import 'package:permission_handler/permission_handler.dart';
import '../functions/launch_url.dart';

Future<void> checkInstallPermission() async {
  if (!await Permission.requestInstallPackages.isGranted) {
    await Permission.requestInstallPackages.request();
  }
}

// Google Play Store
void showUpdateDialog(String storeUrl) {
  Get.dialog(
    AlertDialog(
      icon: Image.asset(
        AppImageAssets.logoApp,
        height: 120,
        fit: BoxFit.contain,
      ),
      alignment: Alignment.center,
      content:
          const Text('يتوفر إصدار جديد من التطبيق. يرجى التحديث للمتابعة.'),
      actions: <Widget>[
        TextButton.icon(
          label: const Text(
            'حدث الآن',
            style: TextStyle(color: AppColor.primaryColor),
          ),
          icon: const Icon(
            IconBroken.Download,
            color: AppColor.primaryColor,
          ),
          onPressed: () {
            // Just open the website without closing the dialog
            webSite(storeUrl);
            // Prevent the dialog from closing by not calling Get.back() or Navigator.pop()
          },
        ),
      ],
    ),
    barrierDismissible:
        false, // Makes sure the user can't dismiss the dialog by clicking outside
  );
}

// Local Store
// void showUpdateDialog(String downloadUrl) {
//   Get.dialog(
//     AlertDialog(
//       icon: Image.asset(
//         AppImageAssets.logoApp,
//         height: 120,
//         fit: BoxFit.contain,
//       ),
//       alignment: Alignment.center,
//       content: ProgressDialogContent(downloadUrl: downloadUrl),
//       actions: const <Widget>[
//         // TextButton.icon(
//         //   label: const Text(
//         //     'إلغاء',
//         //     style: TextStyle(color: AppColor.primaryColor),
//         //   ),
//         //   icon: const Icon(
//         //     Icons.cancel,
//         //     color: AppColor.primaryColor,
//         //   ),
//         //   onPressed: () {
//         //     Get.back(); // إغلاق مربع الحوار
//         //   },
//         // ),
//       ],
//     ),
//     barrierDismissible: false,
//   );
// }

class ProgressDialogContent extends StatefulWidget {
  final String downloadUrl;

  const ProgressDialogContent({super.key, required this.downloadUrl});

  @override
  State<StatefulWidget> createState() => _ProgressDialogContentState();
}

class _ProgressDialogContentState extends State<ProgressDialogContent> {
  String filePath = '';
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      log('تم منح الإذن');
    } else {
      // طلب الإذن إذا تم رفضه أو لم يكن محددًا
      status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        log('تم منح الإذن بعد الطلب');
      } else if (status.isDenied) {
        log('تم رفض الإذن');
        await openAppSettings();
      } else if (status.isPermanentlyDenied) {
        log('تم رفض الإذن بشكل دائم. يرجى تمكينه من الإعدادات.');
        await openAppSettings();
      }
    }
  }

  Future<void> downloadApp(String url) async {
    // طلب إذن التخزين أولاً
    await requestStoragePermission();

    // الحصول على الامتداد من رابط الـ URL
    String extension = path.extension(Uri.parse(url).path);

    // التحقق من نوع الملف بناءً على الامتداد
    switch (extension.toLowerCase()) {
      case '.pdf':
        log('هذا ملف PDF');
        break;
      case '.png':
      case '.jpg':
      case '.jpeg':
      case '.gif':
        log('هذا ملف صورة');
        break;
      default:
        log('نوع الملف غير معروف: $extension');
    }

    try {
      // تحقق من حالة إذن التخزين مرة أخرى قبل بدء التحميل
      if (await Permission.manageExternalStorage.isGranted) {
        // تحديد مسار مجلد الـ Downloads على الهاتف
        String directory = '/storage/emulated/0/Download/';
        Directory dir = Directory(directory);

        // التحقق مما إذا كان المجلد موجودًا، وإنشاء المجلد إذا لم يكن موجودًا
        if (!(await dir.exists())) {
          await dir.create(recursive: true);
          log('تم إنشاء مجلد Downloads');
        }

        // تحديد المسار الكامل للملف في مجلد Downloads
        filePath = '$directory/OI TAWASOL.apk';
        // تحميل الملف باستخدام Dio
        Dio dio = Dio();
        await dio.download(url, filePath, onReceiveProgress: (received, total) {
          if (total != -1) {
            _progress = received / total; // تحديث نسبة التحميل
            log('Progress: ${(_progress * 100).toStringAsFixed(0)}%');
            setState(() {});
          }
        });

        // بعد اكتمال التحميل
        if (_progress == 1.0) {
          Get.snackbar('نجاح', 'تم تحميل الملف بنجاح إلى $directory');
          setState(() {});
        }
      } else {
        // إذا لم يتم منح الإذن
        Get.snackbar('خطأ', 'لم يتم منح إذن التخزين. لا يمكن تحميل الملف.');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في تحميل الملف: $e');
    }
  }

  void installApp(String filePath) async {
    if (Platform.isAndroid) {
      // تحقق من إذن تثبيت الحزم
      var permissionStatus = await Permission.requestInstallPackages.status;

      // إذا كان الإذن ممنوحًا، افتح ملف الـ APK
      if (permissionStatus.isGranted) {
        await OpenFile.open(filePath);
        Get.snackbar('نجاح', 'تم تحميل التطبيق. بدء التثبيت...');
        Get.back(); // إغلاق مربع الحوار بعد التثبيت
      }
      // إذا لم يكن الإذن ممنوحًا، اطلبه
      else {
        // طلب الإذن
        await Permission.requestInstallPackages.request();

        // تحقق مرة أخرى بعد طلب الإذن
        if (await Permission.requestInstallPackages.isGranted) {
          await OpenFile.open(filePath);
          Get.snackbar('نجاح', 'تم تحميل التطبيق. بدء التثبيت...');
          Get.back(); // إغلاق مربع الحوار بعد التثبيت
        } else {
          Get.snackbar('خطأ', 'الإذن مطلوب لتثبيت التطبيق.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('يتوفر إصدار جديد من التطبيق. يرجى التحديث للمتابعة.'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(value: _progress),
            ),
            // شريط التقدم
            const SizedBox(width: 12),
            Text('${(_progress * 100).toStringAsFixed(0)}%'),
            // عرض النسبة المئوية
          ],
        ),
        const SizedBox(height: 10),
        if (_progress == 0.0)
          TextButton.icon(
            label: const Text(
              'حدث الان',
              style: TextStyle(color: AppColor.primaryColor),
            ),
            icon: const Icon(
              IconBroken.Download,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              setState(() {
                // launchUrlString(widget.downloadUrl);
                downloadApp(widget.downloadUrl);
              });
            },
          ),
        if ((_progress * 100).toStringAsFixed(0) == 100.0.toStringAsFixed(0))
          TextButton.icon(
            label: const Text(
              'التثبيت الان',
              style: TextStyle(color: AppColor.primaryColor),
            ),
            icon: const Icon(
              IconBroken.Arrow___Up,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              setState(() {
                installApp(filePath);
              });
            },
          ),
      ],
    );
  }
}

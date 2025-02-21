import 'package:flutter/material.dart';
import '../../../../core/constant/color.dart';

class ShowAlert extends StatelessWidget {
  const ShowAlert(
      {super.key, this.title, this.text, this.iconData, this.onPressed});

  final String? title;
  final String? text;
  final IconData? iconData;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? 'تم تسجيل مشكلتك'),
      icon: CircleAvatar(
        radius: 30,
        backgroundColor: AppColor.green,
        child: Icon(iconData ?? Icons.done_outline_sharp,
            size: 35, color: AppColor.white),
      ),
      content: Text(
          text ?? 'تم تسجيل مشكلتك بنجاح، سيتم الرد عليك في اقرب وقت ممكن'),
      actionsAlignment:
          title != null ? MainAxisAlignment.end : MainAxisAlignment.center,
      actions: [
        TextButton.icon(
            onPressed: onPressed ??
                () {
                  Navigator.pop(context);
                },
            icon: const Icon(Icons.close),
            label: const Text('اغلاق',
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}

class ShowAlertError extends StatelessWidget {
  const ShowAlertError({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('حدث خطأ'),
      icon: const CircleAvatar(
        radius: 30,
        backgroundColor: AppColor.primaryColor,
        child: Icon(Icons.error_outline, size: 35, color: AppColor.white),
      ),
      content: const Text('حاول مره اخره'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('اغلاق',
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}

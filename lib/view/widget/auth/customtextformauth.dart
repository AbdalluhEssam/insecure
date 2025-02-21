
import 'package:flutter/material.dart';

import '../../../core/constant/apptheme.dart';
import '../../../core/constant/color.dart';

class CustomFormAuth extends StatelessWidget {
  final String hinttext;
  final String label;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final bool isNamber;
  final bool? obscureText;
  final void Function()? onTap;
  final void Function()? onTapFull;
  final String? Function(String)? onChanged;

  final Color? color;

  const CustomFormAuth({
    super.key,
    required this.hinttext,
    required this.label,
    required this.iconData,
    required this.mycontroller,
    required this.valid,
    required this.isNamber,
    this.obscureText,
    this.onTap,
    this.onTapFull,
    this.color, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTapFull,
      style: const TextStyle(color: AppColor.primaryColor),
      keyboardType: isNamber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      onChanged: onChanged,
      validator: valid,
      controller: mycontroller,
      obscureText: obscureText == null || obscureText == false ? false : true,
      decoration: InputDecoration(
        fillColor: color ?? AppColor.backgroundColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        labelStyle: const TextStyle(
            color: AppColor.gray, fontSize: 14, fontWeight: FontWeight.bold),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.backgroundColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.backgroundColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.backgroundColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        label: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(label)),
        prefixIcon: Icon(
          iconData,
          color: AppColor.black.withOpacity(0.5),
        ),
        suffixIcon: obscureText != null
            ? InkWell(onTap: onTap, child: Icon(iconData))
            : null,
      ),
    );
  }
}
class CustomFormAdd extends StatelessWidget {
  final String hinttext;
  final String label;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final bool isNamber;
  final bool? obscureText;
  final void Function()? onTap;
  final void Function()? onTapFull;
  final String? Function(String)? onChanged;

  final Color? color;

  const CustomFormAdd({
    super.key,
    required this.hinttext,
    required this.label,
    required this.iconData,
    required this.mycontroller,
    required this.valid,
    required this.isNamber,
    this.obscureText,
    this.onTap,
    this.onTapFull,
    this.color, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTapFull,
      style: const TextStyle(color: AppColor.primaryColor),
      keyboardType: isNamber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      onChanged: onChanged,
      validator: valid,
      controller: mycontroller,
      obscureText: obscureText == null || obscureText == false ? false : true,
      decoration: InputDecoration(
        fillColor: color ?? AppColor.secondColor.withOpacity(0.3),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        labelStyle: const TextStyle(
            color: AppColor.gray, fontSize: 14, fontWeight: FontWeight.bold),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.backgroundColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.backgroundColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.backgroundColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        label: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(label)),
        prefixIcon: Icon(
          iconData,
          color: AppColor.black.withOpacity(0.5),
        ),
        suffixIcon: obscureText != null
            ? InkWell(onTap: onTap, child: Icon(iconData))
            : null,
      ),
    );
  }
}
class CustomComplaintAdd extends StatelessWidget {
  final String hinttext;
  final String label;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final void Function()? onTap;
  final void Function()? onTapFull;
  final String? Function(String)? onChanged;
  final int minLines;

  final Color? color;

  const CustomComplaintAdd({
    super.key,
    required this.hinttext,
    required this.label,
    required this.iconData,
    required this.mycontroller,
    required this.valid,
    this.onTap,
    this.onTapFull,
    this.color, this.onChanged,this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTapFull,
      style: const TextStyle(color: AppColor.primaryColor),
      minLines: minLines,
      maxLines: null, // Allows the text field to grow
      onChanged: onChanged,
      validator: valid,
      controller: mycontroller,

      decoration: InputDecoration(
        fillColor: color ?? AppColor.backgroundColor ,
        filled: true,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        labelStyle:  TextStyle(
            color:  ThemeService().getThemeMode() ==
                ThemeMode.dark
                ? AppColor.white
                : AppColor.black,  fontSize: 14, fontWeight: FontWeight.bold),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        label: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(label)),
        icon: Icon(
          iconData,
          color: ThemeService().getThemeMode() ==
              ThemeMode.dark
              ? AppColor.white
              : AppColor.black,
        ),

      ),
    );
  }
}

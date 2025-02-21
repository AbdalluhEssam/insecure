import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insecure/core/helper/spacing.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/functions/alertextiapp.dart';
import '../../controller/homescreen_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
      init: HomeScreenControllerImp(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
              child: Column(
                children: [
                  // بطاقة معلومات المستخدم
                  _buildUserCard(controller),
                  const SizedBox(height: 15),
                  // القائمة
                  Expanded(child: _buildMenuList(controller)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ويدجت بطاقة المستخدم
  Widget _buildUserCard(HomeScreenControllerImp controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(controller.profileImage),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.userName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                controller.userRole,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.menu, color: Colors.black),
        ],
      ),
    );
  }

  // ويدجت القائمة
  Widget _buildMenuList(HomeScreenControllerImp controller) {
    return ListView.builder(
      itemCount: controller.menuItems.length,
      itemBuilder: (context, index) {
        final item = controller.menuItems[index];
        return GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(item["image"]!, fit: BoxFit.contain),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.black,
                  height: context.width * 0.4,
                ),
                horizontalSpace(15),
                Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.center,
                    height: context.width * 0.3,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                        title: Text(
                          item["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        contentPadding: EdgeInsetsDirectional.only(end: 10),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: Colors.white)),
                  ),
                ),
                horizontalSpace(15),
              ],
            ),
          ),
        );
      },
    );
  }
}

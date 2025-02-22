import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insecure/core/helper/spacing.dart';
import '../../../../core/constant/color.dart';
import '../../controller/homescreen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
      init: HomeScreenControllerImp(),
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
          ),
          drawer: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // قسم الحساب
                Container(
                  color: AppColor.primaryColor,
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: CachedNetworkImageProvider(
                            controller.userModel.image),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.userModel.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${controller.userModel.bandName == "دكتور" ? "Doctor" : controller.userModel.studentCode} - ${controller.userModel.majorName} ${controller.userModel.bandName == "دكتور" ? "" : "-"} ${controller.userModel.bandName == "دكتور" ? "" : controller.userModel.bandName}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                verticalSpace(16),
                // قسم الإشعارات
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.notifications, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Notification",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        // visualDensity: VisualDensity.comfortable,
                        contentPadding: EdgeInsetsDirectional.only(
                          start: 16,
                          end: 0,
                          top: 0,
                          bottom: 0,
                        ),
                        title: const Text("Notification"),
                        trailing: Transform.scale(
                          scale: 0.7, // يمكنك تغيير القيمة لتحديد الحجم المناسب
                          child: Switch(
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap, // يقلل المساحة المحيطة
                            activeTrackColor: AppColor.primaryColor,
                            activeColor: Colors.white,
                            value: controller.isNotificationEnabled,
                            onChanged: (value) =>
                                controller.toggleNotification(value),
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsetsDirectional.only(
                          start: 16,
                          end: 0,
                          top: 0,
                          bottom: 0,
                        ),
                        title: const Text("Updates"),
                        trailing: Transform.scale(
                            scale:
                                0.7, // يمكنك تغيير القيمة لتحديد الحجم المناسب
                            child: Switch(
                              materialTapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // يقلل المساحة المحيطة
                              activeTrackColor: AppColor.primaryColor,
                              activeColor: Colors.white,
                              value: controller.isUpdatesEnabled,
                              onChanged: (value) =>
                                  controller.toggleUpdates(value),
                            )),
                      ),
                      const Divider(),
                    ],
                  ),
                ),

                // قسم الإعدادات واللغة
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.settings, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Other",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        title: const Text("Language"),
                        trailing: const Text(
                          "English",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // onTap: () => controller.changeLanguage(),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // زر تسجيل الخروج
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: InkWell(
                    onTap: () => controller.logout(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Log Out",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        horizontalSpace(16),
                        const Icon(Icons.logout, color: Colors.red)
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                  const SizedBox(height: 15),
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
            backgroundImage:
                CachedNetworkImageProvider(controller.userModel.image),
          ),
          horizontalSpace(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.userModel.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "${controller.userModel.bandName == "دكتور" ? "Doctor" : controller.userModel.studentCode} - ${controller.userModel.majorName} ${controller.userModel.bandName == "دكتور" ? "" : "-"} ${controller.userModel.bandName == "دكتور" ? "" : controller.userModel.bandName}",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                controller.scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.black)),
        ],
      ),
    );
  }

  // ويدجت القائمة
  Widget _buildMenuList(HomeScreenControllerImp controller) {
    return ListView.builder(
      itemCount: controller.menuItems.length,
      itemBuilder: (context, index) {
        final item = controller.userModel.approveName == "دكتور"
            ? controller.doctorItems[index]
            : controller.menuItems[index];

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

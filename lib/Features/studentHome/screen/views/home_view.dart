import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insecure/Features/studentHome/controller/complaint_controller.dart';
import 'package:insecure/Features/studentHome/data/model/posts_model.dart';
import 'package:insecure/core/constant/icon_broken.dart';
import '../../../../core/constant/apptheme.dart';
import '../../../../core/constant/color.dart';
import '../../controller/home_student_controller.dart';
import '../../../../core/class/handlingdataview.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import '../widget/pdf_viewer.dart';
import '../widget/text_check.dart';
import '../widget/video_viewer.dart';

class HomeStudentView extends StatelessWidget {
  const HomeStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeStudentControllerImp());

    return GetBuilder<HomeStudentControllerImp>(
        builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Center(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getData();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20.w), // استخدام ScreenUtil هنا
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) => CustomPostView(
                        postsModel: controller.posts[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 12.h, // استخدام ScreenUtil هنا
                      ),
                      itemCount: controller.posts.length,
                    ),
                  ),
                ),
              ),
            ));
  }
}

class CustomPostView extends StatelessWidget {
  const CustomPostView({super.key, required this.postsModel});

  final PostsModel postsModel;

  @override
  Widget build(BuildContext context) {
    MediaDownload flutterMediaDownloaderPlugin = MediaDownload();
    HomeStudentControllerImp controller = Get.find();

    return Container(
      decoration: BoxDecoration(
        color: ThemeService().getThemeMode() == ThemeMode.dark
            ? AppColor.black
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ThemeService().getThemeMode() == ThemeMode.dark
                ? AppColor.primaryColor.withOpacity(0.1)
                : AppColor.gray.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 0,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                      child: CircleAvatar(
                          backgroundColor: AppColor.primaryColor,
                          radius: 26,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: CachedNetworkImageProvider(
                                "${postsModel.publisherImage}",
                                cacheManager: CachedNetworkImageProvider
                                    .defaultCacheManager,
                                errorListener: (value) {
                              postsModel.publisherImage =
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2yqidmp-gFvaWF5m5GSFl6kf2_4lFQXqEFbvINmabBGVJ7zRkGbm4DZERx2CwmKC-Bxo&usqp=CAU';
                              controller.update();
                            }),
                          ))),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${postsModel.publisherName != "" ? postsModel.publisherName : "غير محدد"}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      Text(
                        "${postsModel.postDate != "" ? postsModel.postDate : "${DateTime.now().year} عام"}",
                        style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                color: AppColor.primaryColor,
                thickness: 0.5,
              ),
              const SizedBox(
                height: 8,
              ),
              if (postsModel.postType.toString() == "1" ||
                  postsModel.postType.toString() == "4" ||
                  postsModel.postType.toString() == "5")
                LimitedTextWidget(
                  text: postsModel.postText!,
                ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(height: 8),
              if (postsModel.postType.toString() == "3")
                SizedBox(
                  height: Get.width * 0.5,
                  child: Column(
                    children: [
                      Card(
                        child: ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.circular(8),
                          child: VideoPlayerScreenCh(
                              videoUrl: postsModel.postMedia.toString(),
                              title: postsModel.postText.toString()),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: AppColor.primaryColor,
                        radius: 20,
                        child: IconButton(
                            onPressed: () async {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      IconBroken.Download,
                                      color: AppColor.white,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "جارى تنزيل الملف",
                                      style: TextStyle(color: AppColor.white),
                                    ),
                                  ],
                                ),
                                backgroundColor: AppColor.primaryColor,
                              ));

                              await flutterMediaDownloaderPlugin
                                  .downloadMedia(
                                      context, '${postsModel.postMedia}')
                                  .then(
                                (value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.download_done_rounded,
                                          color: AppColor.white,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "تم التنزيل بنجاح",
                                          style:
                                              TextStyle(color: AppColor.white),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: AppColor.green,
                                  ));
                                },
                              );
                            },
                            icon: const Icon(
                              IconBroken.Download,
                              color: AppColor.white,
                            )),
                      )
                    ],
                  ),
                ),
              if (postsModel.postType.toString() == "5")
                SizedBox(
                  height: Get.width * 0.6,
                  child: Column(
                    children: [
                      LimitedTextWidget(
                          text: postsModel.postText ?? "No content available."),
                      const SizedBox(height: 8),
                      Expanded(
                          child: VideoPlayerScreenCh(
                              videoUrl: postsModel.postMedia.toString(),
                              title: postsModel.postText.toString())),
                    ],
                  ),
                ),
              if (postsModel.postType.toString() == "2" ||
                  postsModel.postType.toString() == "4")
                InkWell(
                  onTap: () {
                    showImageViewer(
                      context,
                      Image.network(postsModel.postMedia ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2yqidmp-gFvaWF5m5GSFl6kf2_4lFQXqEFbvINmabBGVJ7zRkGbm4DZERx2CwmKC-Bxo&usqp=CAU')
                          .image,
                      swipeDismissible: true,
                      doubleTapZoomable: true,
                      useSafeArea: true,
                      closeButtonColor: AppColor.primaryColor,
                    );
                  },
                  child: Column(
                    children: [
                      Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: postsModel.postMedia ??
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2yqidmp-gFvaWF5m5GSFl6kf2_4lFQXqEFbvINmabBGVJ7zRkGbm4DZERx2CwmKC-Bxo&usqp=CAU',
                            fit: BoxFit.contain,
                            height: 250,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              label: const Text("اظهار الملف"),
                              icon: const Icon(IconBroken.Show),
                              // Changed to visibility icon
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                // Increase padding
                                backgroundColor: AppColor.green,
                                // Customize button color
                                foregroundColor: AppColor.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded corners
                                ),
                              ),
                              onPressed: () {
                                showImageViewer(
                                  context,
                                  Image.network(postsModel.postMedia ??
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2yqidmp-gFvaWF5m5GSFl6kf2_4lFQXqEFbvINmabBGVJ7zRkGbm4DZERx2CwmKC-Bxo&usqp=CAU')
                                      .image,
                                  swipeDismissible: true,
                                  doubleTapZoomable: true,
                                  useSafeArea: true,
                                  closeButtonColor: AppColor.primaryColor,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Added spacing between buttons
                          Expanded(
                            child: ElevatedButton.icon(
                              label: const Text("تحميل الملف"),
                              icon: const Icon(
                                IconBroken.Download,
                              ),
                              // Changed to download icon
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                // Increase padding
                                backgroundColor: AppColor.primaryColor,
                                // Customize button color
                                foregroundColor: AppColor.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (postsModel.postType.toString() == "6")
                SizedBox(
                  height: Get.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LimitedTextWidget(text: postsModel.postText ?? ""),
                      Expanded(
                        child: PDFViewerPage(
                          pdfUrl: postsModel.postMedia!,
                          title: controller
                              .removeLinks(postsModel.postMedia!)
                              .replaceAll('.', '')
                              .replaceAll("pdf", ""),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              label: const Text("اظهار الملف"),
                              icon: const Icon(IconBroken.Show),
                              // Changed to visibility icon
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                // Increase padding
                                backgroundColor: AppColor.green,
                                // Customize button color
                                foregroundColor: AppColor.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded corners
                                ),
                              ),
                              onPressed: () {
                                Get.to(() => PDFViewerFullPage(
                                      pdfUrl: postsModel.postMedia!,
                                      title: controller
                                          .removeLinks(postsModel.postMedia!)
                                          .replaceAll('.', '')
                                          .replaceAll("pdf", ""),
                                    ));
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Added spacing between buttons
                          Expanded(
                            child: ElevatedButton.icon(
                              label: const Text("تحميل الملف"),
                              icon: const Icon(
                                IconBroken.Download,
                              ),
                              // Changed to download icon
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                // Increase padding
                                backgroundColor: AppColor.primaryColor,
                                // Customize button color
                                foregroundColor: AppColor.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {},
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

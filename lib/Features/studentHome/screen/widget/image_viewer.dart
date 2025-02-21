import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:get/get.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/constant/icon_broken.dart';

class ImageViewerPage extends StatelessWidget {
  final String imageUrls;
  final String title;

  const ImageViewerPage(
      {super.key, required this.imageUrls, required this.title});

  @override
  Widget build(BuildContext context) {
    // Split the image URLs by comma and convert them to a list
    List<String> images = imageUrls.split(',');
    // Show first four images only
    List<String> initialImages = images.take(4).toList();
    return GestureDetector(
      onTap: () {
        if (images.length > 4) {
          // Navigate to the full image list page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullImageViewerPage(
                images: images,
                title: title,
              ),
            ),
          );
        }
      },
      child: SizedBox(
        height: Get.width * 0.55,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.5,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: initialImages.length,
          itemBuilder: (context, index) {
            return index >= 3
                ? Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: images[index],
                  progressIndicatorBuilder: (context, url, progress) =>
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, error, stackTrace) {
                    return const Center(
                      child: Text('Error loading image'),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(0.4)),
                  child: Text(
                    "${images.length - initialImages.length}+",
                    style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
                : CachedNetworkImage(
              imageUrl: initialImages[index],
              progressIndicatorBuilder: (context, url, progress) =>
              const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, error, stackTrace) {
                return const Center(
                  child: Text('Error loading image'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class FullImageViewerPage extends StatelessWidget {
  final List<String> images;
  final String title;

  const FullImageViewerPage(
      {super.key, required this.images, required this.title});

  @override
  Widget build(BuildContext context) {
    MediaDownload flutterMediaDownloaderPlugin = MediaDownload();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.separated(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
                onLongPress: () async {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                      .downloadMedia(context, images[index])
                      .then(
                        (value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                              style: TextStyle(color: AppColor.white),
                            ),
                          ],
                        ),
                        backgroundColor: AppColor.green,
                      ));

                      // Get.snackbar("تم التنزيل بنجاح","تم التنزيل بنجاح", icon: Icon(Icons.download_done_rounded, color: AppColor.primaryColor,),);
                    },
                  ).catchError((onError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppColor.white,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            onError.toString(),
                            style: const TextStyle(color: AppColor.white),
                          ),
                        ],
                      ),
                      backgroundColor: AppColor.primaryColor,
                    ));
                  });
                },
                onTap: () {
                  showImageViewer(
                    context,
                    // Notice that this will cause an "unhandled exception" although an error handler is defined.
                    // This is a known Flutter issue, see https://github.com/flutter/flutter/issues/81931
                    Image.network(images[index]).image,
                    swipeDismissible: true,
                    doubleTapZoomable: true,
                    backgroundColor: AppColor.white,
                    useSafeArea: true,
                    closeButtonColor: AppColor.primaryColor,
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  progressIndicatorBuilder: (context, url, progress) =>
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, error, stackTrace) {
                    return const Center(
                      child: Text('Error loading image'),
                    );
                  },
                )),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 12,
          color: AppColor.primaryColor,
          thickness: 2,
        ),
      ),
    );
  }
}
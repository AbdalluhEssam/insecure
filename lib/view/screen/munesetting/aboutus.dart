import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/imageassets.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("about".tr),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset(
                AppImageAssets.onBoardingImageLogo,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                color: context.isDarkMode ? Colors.white : null,
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: const Text(
                  'تطبيق "OI TAWASOL" يساعد الطلاب و الخرجين واولياء الامور على التوصل مع معاهد العبور من خلال نشر كل ما هو  جديد كما يتيح رفع الشكاوى ويتم الرد عليها فى اسرع وقت',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("OI TAWASOL | ©2024")],
            ),
          ],
        ),
      ),
    );
  }
}

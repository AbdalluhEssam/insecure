import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:insecure/core/constant/imageassets.dart';
import 'package:insecure/core/constant/routes.dart';
import '../../core/functions/checkinterner.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MySplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool isOnline = true;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    // التحقق من الاتصال بالإنترنت
    _checkInternetConnection();

    // الانتقال بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3), () async {
      if (isOnline) {
        Get.offAllNamed(AppRoute.onBoarding); // اسم الروت الصحيح
      }
    });
  }

  Future<void> _checkInternetConnection() async {
    bool connected = await checkInternet(); // استبدلها بدالة الإنترنت الفعلية
    setState(() {
      isOnline = connected;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isOnline)
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImageAssets.logoApp, // استبدل بمسار الصورة الفعلي
                          width: 180,
                          height: 180,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "OI Insecure",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(AppImageAssets.offline,
                        width: 250, height: 250),
                    const SizedBox(height: 20),
                    const Text(
                      "لا يوجد اتصال بالإنترنت.",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    _retryButton(),
                  ],
                ),
              ),
            Image.asset(AppImageAssets.oiLogo, height: 30),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _retryButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: _checkInternetConnection,
      child: const Text(
        "إعادة المحاولة",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

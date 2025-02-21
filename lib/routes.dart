
import 'package:get/get.dart';
import 'package:insecure/Features/auth/screen/views/login.dart';
import 'package:insecure/Features/studentHome/screen/views/home_screen.dart';
import 'package:insecure/Features/studentHome/screen/views/home_view.dart';
import 'package:insecure/view/screen/language.dart';
import 'package:insecure/view/screen/munesetting/aboutus.dart';
import 'package:insecure/view/screen/splash_screen.dart';
import 'Features/onboarding/screen/onboarding.dart';
import 'core/constant/routes.dart';
import 'core/middleware/mymiddleware.dart';

List<GetPage<dynamic>>? routes = [
  //Auth
  GetPage(
      name: "/", page: () => const MySplashScreen(), middlewares: [MyMiddleWare()]),
  // GetPage(name: "/", page: () => const TestView()),
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.language, page: () => const Language()),
  GetPage(name: AppRoute.aboutUs, page: () => const AboutUs()),

  //OnBoarding
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),

  GetPage(name: AppRoute.mySplashScreen, page: () => const MySplashScreen()),
  GetPage(name: AppRoute.homeScreen, page: () => const HomeScreen()),

];

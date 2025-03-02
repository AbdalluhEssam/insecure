import 'package:flutter/material.dart';
import 'package:insecure/core/services/services.dart';
import 'package:insecure/insecure_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();

  await initialServices();

  runApp(InsecureApp());
}
// 521240
// Dr.Magdy  - 01060060023

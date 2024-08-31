import 'package:flutter/material.dart';
import 'package:project_zain2/Admin/App_drawer/app_dawer.dart';
import 'package:project_zain2/All/Login/login.dart';
import 'package:project_zain2/Delivery/TabBarDelivery/tabBarDeliveryPage.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: LoginScreen(),
    );
  }
}


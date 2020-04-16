import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_example_with_cloud_storage/core/services/local_storage_service.dart';
import 'package:test_example_with_cloud_storage/ui/views/home_pages/home_page.dart';
import 'package:test_example_with_cloud_storage/ui/views/login_pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Check if the user logged in before or not
  void pageRotate() {
    Future.delayed(Duration(seconds: 2), () {
      if (LocalStorageService.getLogin) {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  void initState() {
    pageRotate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:test_example_with_cloud_storage/core/services/local_storage_service.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/create_user_wm.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/delete_post_wm.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/save_image_url_wm.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/update_post.wm.dart';
import 'package:test_example_with_cloud_storage/locator.dart';
import 'package:test_example_with_cloud_storage/ui/views/login_pages/splash_screen.dart';
import 'core/services/theme_data_service.dart';
import 'core/viewmodels/add_post_wm.dart';
import 'core/viewmodels/fetch_post_stream_wm.dart';
import 'core/viewmodels/login_with_email_wm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Start locator
  setupLocator();

  //Initialize shared preferences
  await LocalStorageService.initialize();

  runApp(MyApp());

  //Remove status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //get instance of provider to reach its methods
  ThemeService themeService = ThemeService();

  //get value shared prefences and save into provider
  void getThemeValue(){
    themeService.getTheme = LocalStorageService.getThemeValue;
  }

  @override
  void initState() {
    getThemeValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignupViewModel>(create: (context) => SignupViewModel()),
        ChangeNotifierProvider<LoginControlViewModel>(create: (context) => LoginControlViewModel()),
        ChangeNotifierProvider<ThemeService>(create: (context) => ThemeService()),
        ChangeNotifierProvider<SaveImageViewModel>(create: (context) => SaveImageViewModel()),
        ChangeNotifierProvider<AddPostViewModel>(create: (context) => AddPostViewModel(),),
        ChangeNotifierProvider<FetchPostViewModel>(create: (context) => FetchPostViewModel()),
        ChangeNotifierProvider<DeletePostViewModel>(create: (context) => DeletePostViewModel()),
        ChangeNotifierProvider<UpdatePostViewModel>(create: (context) => UpdatePostViewModel()),
      ],
      child: Consumer<ThemeService>(
          builder: (BuildContext context, ThemeService value, Widget child) =>
              MaterialApp(
                theme: value.getTheme == true ? value.darkTheme : value.lightTheme,
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
              )),
    );
  }
}

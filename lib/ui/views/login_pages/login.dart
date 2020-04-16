import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_example_with_cloud_storage/core/services/local_storage_service.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/login_with_email_wm.dart';
import 'package:test_example_with_cloud_storage/ui/shared/global_methods.dart';
import 'package:test_example_with_cloud_storage/ui/shared/regex_control.dart';
import 'package:test_example_with_cloud_storage/ui/shared/responsive.dart';
import 'package:test_example_with_cloud_storage/ui/views/home_pages/home_page.dart';
import 'package:test_example_with_cloud_storage/ui/views/login_pages/sign_up.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/appbar_title.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/label_card.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/text_form_field.dart';
import 'package:test_example_with_cloud_storage/ui/shared/ui_color.dart'
    as color;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = true;
  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppbarTitle(
            label: 'Login',
          ),
          backgroundColor: color.appbarBackgroundColor,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              autovalidate: autoValidate,
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/flutter.png",
                    height: SizeConfig.safeBlockVertical * 25,
                    width: SizeConfig.safeBlockHorizontal * 25,
                  ),
                  //Mail
                  MyTextFormField(
                    validatorFonksiyon: RegexControl.mailKontrol,
                    prefixIcon: Icon(
                      Icons.mail,
                      size: SizeConfig.safeBlockHorizontal * 7,
                      color: Colors.teal,
                    ),
                    label: 'Mail',
                    satirSayisi: 1,
                    textInputType: TextInputType.emailAddress,
                    controller: mailController,
                  ),
                  GlobalMethods()
                      .sizedBox(height: SizeConfig.safeBlockVertical * 3),
                  //Password
                  MyTextFormField(
                    validatorFonksiyon: RegexControl.passwordControl,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.teal,
                      size: SizeConfig.safeBlockHorizontal * 7,
                    ),
                    label: 'Password',
                    controller: passwordController,
                    password: showPassword,
                    satirSayisi: 1,
                    sifreyiGoster: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.teal,
                          size: SizeConfig.safeBlockHorizontal * 6,
                        ),
                        onPressed: () {
                          setState(() => showPassword = !showPassword);
                        }),
                  ),
                  GlobalMethods()
                      .sizedBox(height: SizeConfig.safeBlockVertical * 3),
                  //Sign in button
                  Container(
                    color: Colors.black,
                    height: SizeConfig.safeBlockVertical * 8,
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: color.defaultButtonBackgroundcolor,
                      onPressed: () {
                        autoValidate = true;
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          Provider.of<LoginControlViewModel>(context,
                                  listen: false)
                              .loginControl(
                                  mailController.text, passwordController.text)
                              .then((response) {
                            if (response.id.isNotEmpty) {
                              //if response is okay save user data then rotate to home page
                              LocalStorageService.savePassword(
                                  response.password);
                              LocalStorageService.saveName(response.name);
                              LocalStorageService.saveId(response.id);
                              LocalStorageService.saveMail(response.mail);
                              LocalStorageService.saveImage(response.image);
                              LocalStorageService.saveLogin(true);

                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => HomePage()));
                            } else {
                              print("User did not found");
                            }
                          });
                        }
                      },
                      child: LabelCard(
                        label: 'Sign in',
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 6,
                      ),
                    ),
                  ),
                  //Don't have an account
                  GlobalMethods()
                      .sizedBox(height: SizeConfig.safeBlockVertical * 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LabelCard(
                        label: "Don't have an account?",
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: LabelCard(
                          padding: EdgeInsets.only(bottom: 5),
                          label: '    Sign up',
                          color: Colors.orange,
                          fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

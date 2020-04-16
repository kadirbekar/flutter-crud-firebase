import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_example_with_cloud_storage/core/models/user.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/create_user_wm.dart';
import 'package:test_example_with_cloud_storage/ui/shared/global_methods.dart';
import 'package:test_example_with_cloud_storage/ui/shared/responsive.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/appbar_title.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/label_card.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/text_form_field.dart';
import 'package:test_example_with_cloud_storage/ui/shared/ui_color.dart'
    as color;
import 'package:test_example_with_cloud_storage/ui/shared/ui_text.dart' as text;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var passwordController = TextEditingController();

  var mailController = TextEditingController();

  final Firestore _firestore = Firestore.instance;

  User user = User();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color.appbarBackgroundColor,
        title: AppbarTitle(label: 'Sing Up'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Form(
                child: Column(
              children: <Widget>[
                MyTextFormField(
                  controller: nameController,
                  label: 'Name',
                  satirSayisi: 1,
                ),
                GlobalMethods()
                    .sizedBox(height: SizeConfig.safeBlockVertical * 2),
                MyTextFormField(
                  controller: passwordController,
                  label: 'Password',
                  password: true,
                  satirSayisi: 1,
                ),
                GlobalMethods()
                    .sizedBox(height: SizeConfig.safeBlockVertical * 2),
                MyTextFormField(
                  controller: mailController,
                  label: 'Mail',
                  textInputType: TextInputType.emailAddress,
                  satirSayisi: 1,
                ),
                GlobalMethods()
                    .sizedBox(height: SizeConfig.safeBlockVertical * 2),
                Builder(
                  builder: (context) => Container(
                    height: SizeConfig.safeBlockVertical * 8.3,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        var id = _firestore
                            .collection("users")
                            .document()
                            .documentID;
                        Provider.of<SignupViewModel>(context, listen: false)
                            .createUser(User(
                                id: id,
                                name: nameController.text,
                                password: passwordController.text,
                                mail: mailController.text))
                            .then((u) {
                          print("added successfully");
                          Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Container(
                                child: Row(
                                  children: <Widget>[
                                    LabelCard(
                                      label:
                                          "User added successfully, let's login",
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.5,
                                    ),
                                    GlobalMethods().sizedBox(width: 10),
                                    Icon(
                                      Icons.done_all,
                                      size: SizeConfig.safeBlockHorizontal * 8,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              )));
                        });
                      },
                      child: LabelCard(
                        fontSize: SizeConfig.safeBlockHorizontal * 5.7,
                        label: text.signUp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

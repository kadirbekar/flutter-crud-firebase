import 'dart:io';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:test_example_with_cloud_storage/core/services/local_storage_service.dart';
import 'package:test_example_with_cloud_storage/core/services/theme_data_service.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/login_with_email_wm.dart';
import 'package:test_example_with_cloud_storage/core/viewmodels/save_image_url_wm.dart';
import 'package:test_example_with_cloud_storage/ui/shared/global_methods.dart';
import 'package:test_example_with_cloud_storage/ui/shared/responsive.dart';
import 'package:test_example_with_cloud_storage/ui/views/home_pages/crud_post.dart';

import 'package:test_example_with_cloud_storage/ui/widgets/appbar_title.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/label_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get theme value from shared preferences, at the beginning it's already false
  bool themeNewValue = LocalStorageService.getThemeValue;
  File _pickedUpDocument;
  LoginControlViewModel _loginControlViewModel;
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeService>(context, listen: true);
    _loginControlViewModel =
        Provider.of<LoginControlViewModel>(context, listen: true);

    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'changeTheme',
                //assign new theme value into shared preferences and listen it with provider
                onPressed: () {
                  themeNewValue = !themeNewValue;
                  LocalStorageService.setTheme(themeNewValue);
                  themeData.getTheme = themeNewValue;
                },
                child: Icon(Icons.lightbulb_outline),
              ),
              GlobalMethods().sizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CrudPost()));
                },
                child: Icon(Icons.forward),
              ),
            ],
          ),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: AppbarTitle(label: 'Profile'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //photo
                Container(
                  height: SizeConfig.safeBlockVertical * 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ],
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  //icon buttons
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 18,
                        width: SizeConfig.safeBlockHorizontal * 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(55),
                          child: FadeInImage.assetNetwork(
                                  placeholder: "assets/images/resim-yok.png",
                                  image: "${_loginControlViewModel.user.image}",
                                  fadeInCurve: Curves.easeIn,
                                ),
                        ),
                      ),
                      GlobalMethods().sizedBox(height: SizeConfig.safeBlockVertical * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          iconButton(Icons.settings_applications, () {}),
                          showBarrier(),
                          iconButton(Icons.cloud_upload, () {}),
                          showBarrier(),
                          iconButton(Icons.image, () => _uploadImageFromGallery())
                        ],
                      ),
                    ],
                  ),
                ),
                GlobalMethods()
                    .sizedBox(height: SizeConfig.safeBlockVertical * 5),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(45),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      labelCard(
                        'Hi ${_loginControlViewModel.user.name}',
                      ),
                      GlobalMethods().sizedBox(height: 25),
                      labelCard("Name : ${_loginControlViewModel.user.name}"
                      ),
                      labelCard("Mail : ${_loginControlViewModel.user.mail}"),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget labelCard(String label) {
    return LabelCard(
      label: label,
      textAlign: TextAlign.left,
      fontSize: SizeConfig.safeBlockHorizontal * 5.5,
    );
  }

  Widget showBarrier() {
    return Container(
      color: Colors.black,
      width: SizeConfig.safeBlockVertical * 1,
      height: SizeConfig.blockSizeHorizontal * 8,
    );
  }

  Widget iconButton(IconData icon, Function onPressed,
      {Color color = Colors.black}) {
    return IconButton(
        icon: Icon(
          icon,
          size: SizeConfig.safeBlockHorizontal * 9,
          //color: color,
        ),
        onPressed: onPressed);
  }

  //save profile picture of current user
  _uploadImageFromGallery() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _pickedUpDocument = image;
      });
      StorageReference ref = FirebaseStorage.instance
          .ref()
          .child("${_loginControlViewModel.user.id}")
          .child("${_loginControlViewModel.user.name}.png");
      StorageUploadTask uploadTask = ref.putFile(_pickedUpDocument);

      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      LocalStorageService.saveImage(url);
      Provider.of<SaveImageViewModel>(context, listen: false)
          .saveImageURL(url, _loginControlViewModel.user.id)
          .then((response) {
        if (response == "true") {
          setState(() {});
        } else {
          return false;
        }
      });
    } catch (e) {}
  }
}

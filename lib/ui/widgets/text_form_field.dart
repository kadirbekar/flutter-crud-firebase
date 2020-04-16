import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final String label;
  final TextInputType textInputType;
  final TextStyle textStyle;
  final Function validatorFonksiyon;
  final Function onsavedGelenDeger;
  final TextEditingController controller;
  final int satirSayisi;
  final String kaydedilecekDeger;
  final bool password;
  final int karakterSayisi;
  final FontWeight fontWeight;
  final TextInputAction ileriTusu;
  final IconButton sifreyiGoster;
  final Function onFieldSubmitted;
  final FocusNode focusNode;
  final bool autoFocus;
  final bool autoValidate;
  final Function onTap;
  final String labelText;
  final Icon prefixIcon;
  final TextStyle prefixStyle;
  final TextStyle labelStyle;
  final Function onChange;
  final Color hintStyleColor;

  MyTextFormField(
      {Key key,
      this.label,
      this.focusNode,
      this.onFieldSubmitted,
      this.ileriTusu,
      this.sifreyiGoster,
      this.textStyle,
      this.fontWeight,
      this.textInputType,
      this.kaydedilecekDeger,
      this.password,
      this.controller,
      this.satirSayisi,
      this.validatorFonksiyon,
      this.karakterSayisi,
      this.onsavedGelenDeger,
      this.autoFocus,
      this.autoValidate,
      this.onTap,
      this.labelText,
      this.prefixIcon,
      this.prefixStyle,
      this.labelStyle,
      this.onChange,
      this.hintStyleColor
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: this.onChange,
      onTap: this.onTap,
      autovalidate: this.autoValidate ?? false,
      autofocus: this.autoFocus ?? false,
      focusNode: this.focusNode,
      onFieldSubmitted: this.onFieldSubmitted,
      textInputAction: this.ileriTusu,
      obscureText: this.password ?? false,
      maxLines: this.satirSayisi,
      maxLength: this.karakterSayisi,
      controller: this.controller,
      validator: this.validatorFonksiyon,
      onSaved: this.onsavedGelenDeger,
      style: this.textStyle,
      keyboardType: this.textInputType,
      decoration: InputDecoration(
        labelText: this.labelText,
        labelStyle: this.labelStyle,
        suffixIcon: this.sifreyiGoster,
        hintText: this.label,
        prefixIcon: this.prefixIcon,
        prefixStyle: this.prefixStyle,
        hintStyle: TextStyle(fontWeight: this.fontWeight,color: this.hintStyleColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.001)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.002)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.002)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.002)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.002)),
        ),
      ),
    );
  }
}

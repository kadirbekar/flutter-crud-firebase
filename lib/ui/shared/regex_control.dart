class RegexControl {
  static String passwordControl(String value) {
    if (value.isEmpty) {
      return "Enter your password";
    }
    return null;
  }

  static String mailKontrol(String deger) {
    String tasarim =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(tasarim);
    if (deger.length == 0) {
      return "Enter your e-mail";
    } else if (!regExp.hasMatch(deger)) {
      return "Invalid mail address";
    } else {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:test_example_with_cloud_storage/ui/shared/responsive.dart';

class AppbarTitle extends StatelessWidget {
  final String label;

  AppbarTitle({Key key, @required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      label,
      style: TextStyle(
        fontSize: SizeConfig.safeBlockHorizontal * 5.5,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}

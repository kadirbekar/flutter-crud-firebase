import 'package:flutter/material.dart';
import 'package:test_example_with_cloud_storage/ui/shared/responsive.dart';
import 'package:test_example_with_cloud_storage/ui/widgets/label_card.dart';

Widget circularProgressBar() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget noSavedData() {
  return Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.airline_seat_individual_suite,
          color: Colors.red,
          size: SizeConfig.safeBlockHorizontal * 15,
        ),
        Center(
          child: LabelCard(
            label: "You did not post any thing so far",
            fontSize: SizeConfig.safeBlockHorizontal * 5.5,
          ),
        ),
      ],
    ),
  );
}

Widget dataReturnedNull() {
  return Expanded(
    child: ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: LabelCard(
                label:
                    "We have a problem for a while, please try it another time",
                fontSize: SizeConfig.safeBlockHorizontal * 5.5,
              ),
            ),
            Icon(
              Icons.cached,
              color: Colors.red,
              size: SizeConfig.safeBlockHorizontal * 25,
            )
          ],
        ),
      ],
    ),
  );
}

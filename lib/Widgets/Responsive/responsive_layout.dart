import 'package:checkit/Widgets/Responsive/medium_phone_layout.dart';
import 'package:checkit/Widgets/Responsive/small_phone_layout.dart';
import 'package:flutter/material.dart';

import 'dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final SmallPhoneLayout smallPhoneLayout;
  final MediumPhoneLayout mediumPhoneLayout;

  ResponsiveLayout(
      {@required this.smallPhoneLayout, @required this.mediumPhoneLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidthMedium) {
          return Text('data');
        } else {
          return Text('data2');
        }
      },
    );
  }
}

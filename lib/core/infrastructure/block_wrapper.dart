// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:responsive_framework/responsive_framework.dart';

// Project imports:
import 'package:joyful_noise/constants/spacing.dart';

/// A convenience widget to wrap main blocks with:
///  - ResponsiveContraints for max width.
///  - A Center to allow constraints to work in a List.
class BlockWrapper extends StatelessWidget {
  const BlockWrapper(this.widget, {super.key});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ResponsiveConstraints(
        constraintsWhen: blockWidthConstraints,
        child: widget,
      ),
    );
  }
}

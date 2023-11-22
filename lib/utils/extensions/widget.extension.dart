import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';

extension WidgetExtension on Widget {
  Center get center => Center(child: this);

  Padding get padding => Padding(padding: const EdgeInsets.all(kDefaultPadding), child: this);

  Padding get padding2x => Padding(padding: const EdgeInsets.all(kDefaultPadding * 2), child: this);

  Padding get paddingH =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding), child: this);

  Padding get paddingV =>
      Padding(padding: const EdgeInsets.symmetric(vertical: kDefaultPadding), child: this);
}

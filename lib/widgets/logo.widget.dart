import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';

class ValiqLogoWidget extends StatelessWidget {
  final bool showText;
  const ValiqLogoWidget({super.key, this.showText = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
        ),
        if (showText)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            child: Text(
              "VALIQ",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
      ],
    );
  }
}

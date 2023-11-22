import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/menu.cubit.dart';
import 'package:valiq_editor_demo/menu/valiq_menu.app.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';

class MenuPreviewSection extends StatelessWidget {
  const MenuPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final MenuModel menu = context.watch<MenuCubit>().state!;

    return Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(kDefaultPadding),
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(kDefaultPadding)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(kDefaultPadding / 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.phone_android_outlined,
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Icon(
                    Icons.tablet_mac_outlined,
                  ),
                  Spacer(),
                  // Icon(
                  //   FeatherIcons.sun,
                  // ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Icon(
                    FeatherIcons.moon,
                  )
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: [
                QrImageView(
                  data: 'https://valiq.app/menu/ba8b15f6-14d7-7565-b7ea-5f66038fdbcf',
                  version: QrVersions.auto,
                  backgroundColor: menu.qrCode.backgroundColor,
                  padding: const EdgeInsets.all(kDefaultPadding),
                  errorCorrectionLevel: QrErrorCorrectLevel.L,
                  gapless: false,
                  eyeStyle: QrEyeStyle(
                    eyeShape: menu.qrCode.cornersShape,
                    color: menu.qrCode.cornersColor,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: menu.qrCode.pixelsShape,
                    color: menu.qrCode.pixelsColors,
                  ),
                  size: 400.0,
                ),
                Center(
                  child: AspectRatio(
                    aspectRatio: 390 / 844,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                        border: Border.all(
                            color: Theme.of(context).dividerColor,
                            width: 4,
                            strokeAlign: BorderSide.strokeAlignOutside),
                      ),
                      child: ValiqMenuApplication(
                        menu: menu,
                      ),
                    ),
                  ),
                ).padding,
              ],
            ))
          ],
        ));
  }
}

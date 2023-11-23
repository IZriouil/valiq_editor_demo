import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/constants/properties.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/menu.cubit.dart';
import 'package:valiq_editor_demo/menu/valiq_menu.app.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';

class MenuPreviewSection extends StatefulWidget {
  const MenuPreviewSection({super.key});

  @override
  State<MenuPreviewSection> createState() => _MenuPreviewSectionState();
}

class _MenuPreviewSectionState extends State<MenuPreviewSection> {
  final ValueNotifier<bool> isTablet = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final MenuModel menu = context.watch<MenuCubit>().state!;
    final bool isDark = menu.theme.brightness == Brightness.dark;

    return Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Row(
          children: [
            Expanded(
                child: Stack(
              children: [
                Container(
                  width: 200,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                  ),
                  child: FittedBox(
                    child: QrImageBlendView(
                      data: 'https://valiq-bef3e.web.app/',
                      version: QrVersions.auto,
                      backgroundColor: Colors.black,
                      backgroundImage: const NetworkImage(kDefaultAvatarImage),
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                      foregroundColor: Colors.white54,
                      emptyColor: Colors.black,
                      gapSize: 3,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.circle,
                        color: Colors.white,
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.circle,
                        color: menu.qrCode.pixelsColors,
                      ),
                      size: 300.0,
                    ),
                  ),
                ),
                Center(
                  child: ValueListenableBuilder(
                    valueListenable: isTablet,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return AspectRatio(
                        aspectRatio: value ? 3 / 4 : 390 / 844,
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
                          child: child,
                        ),
                      );
                    },
                    child: ValiqMenuApplication(
                      menu: menu,
                    ),
                  ),
                ).padding,
              ],
            )),
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
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: isTablet,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return InkWell(
                        onTap: !value
                            ? null
                            : () {
                                isTablet.value = !isTablet.value;
                              },
                        child: Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(isTablet.value ? 0 : .5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.phone_android_outlined,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  ValueListenableBuilder(
                    valueListenable: isTablet,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return InkWell(
                        onTap: value
                            ? null
                            : () {
                                isTablet.value = !isTablet.value;
                              },
                        child: Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 4),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primary.withOpacity(!isTablet.value ? 0 : .5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.tablet_mac_outlined,
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      context.read<MenuCubit>().updateThemeConfiguration(
                            menu.theme.copyWith(
                              brightness: isDark ? Brightness.light : Brightness.dark,
                            ),
                          );
                    },
                    child: Icon(
                      !isDark ? FeatherIcons.moon : FeatherIcons.sun,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

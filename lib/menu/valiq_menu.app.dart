import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/config/service_locator.dart';
import 'package:valiq_editor_demo/menu/classique/pages/home/menu_home.page.dart';
import 'package:valiq_editor_demo/menu/whisperwind/pages/home/ww_home.page.dart';
import 'package:valiq_editor_demo/models/menu/extensions.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';
import 'package:valiq_editor_demo/services/menu.service.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';
import 'package:valiq_editor_demo/widgets/error.widget.dart';

class ValiqMenuApplication extends StatelessWidget {
  final MenuModel? menu;
  final String? menuId;
  const ValiqMenuApplication({super.key, this.menu, this.menuId}) : assert(menu != null || menuId != null);

  Widget homePage(MenuModel menu) {
    if (menu.theme.code == "ww") {
      return WhisperWindMenuHomePage(menu: menu);
    }
    return MenuHomePage(menu: menu);
  }

  @override
  Widget build(BuildContext context) {
    if (menu != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: menu!.entity.name,
        restorationScopeId: menu!.id,
        theme: menu!.theme.data,
        home: homePage(menu!),
      );
    }

    return StreamBuilder<MenuModel?>(
        stream: locator<MenuService>().getMenuStream("MENU_ID"),
        builder: (context, menuSnapshot) {
          if (menuSnapshot.hasError) {
            logger.e(menuSnapshot.error);
            return const ApplicationErrorWidget().center;
          }

          if (!menuSnapshot.hasData) {
            logger.t("Waiting for menu data");
            return const CircularProgressIndicator().center;
          }

          logger.i("Menu data received");
          MenuModel menu = menuSnapshot.data!;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: menu.entity.name,
            restorationScopeId: menu.id,
            theme: menu.theme.data,
            home: homePage(menu),
          );
        });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/config/service_locator.dart';
import 'package:valiq_editor_demo/models/menu/entity.model.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';
import 'package:valiq_editor_demo/models/menu/qr_code_configuration.model.dart';
import 'package:valiq_editor_demo/models/menu/theme_configuration.model.dart';
import 'package:valiq_editor_demo/services/menu.service.dart';

class MenuCubit extends Cubit<MenuModel?> {
  final String menuId;
  final bool isAnonymous;

  MenuCubit({required this.menuId, this.isAnonymous = false}) : super(null) {
    fetchMenu();
  }

  bool _hasError = false;
  bool _isLoading = true;
  late MenuModel? _apiMenu;

  bool get modified => _apiMenu != state;
  bool get themeConfigEdited => _apiMenu?.theme != state?.theme;
  bool get qrCodeConfigEdited => _apiMenu?.qrCode != state?.qrCode;
  bool get entityEdited => _apiMenu?.entity != state?.entity;
  bool get ready => !_isLoading;

  void fetchMenu() async {
    _isLoading = true;
    try {
      // await Future.delayed(const Duration(seconds: 2));
      MenuModel? menu = await locator<MenuService>().getMenu(menuId, fake: isAnonymous);
      _apiMenu = menu?.copyWith();
      _isLoading = false;
      emit(menu);
    } catch (e) {
      _hasError = true;
      logger.e("An error has occured while fetching menu as futre $e");
    }
  }

  void updateThemeConfiguration(ThemeConfigurationModel themeConfiguration) {
    logger.i("updateThemeConfiguration ${themeConfiguration.brightness}");
    emit(state!.copyWith(theme: themeConfiguration));
  }

  void updateQRCodeConfiguration(QRCodeConfigurationModel qrCodeConfig) {
    logger.i("updateQRCodeConfiguration ${qrCodeConfig.toJson()}");
    emit(state!.copyWith(qrCode: qrCodeConfig));
  }

  void updateEntity(EntityModel entity) {
    logger.i("updateEntity ${entity.toJson()}");
    emit(state!.copyWith(entity: entity));
  }

  Future<void> saveEntity(EntityModel entityModel) async {
    logger.i("saveEntity ${entityModel.toJson()}");
    await locator<MenuService>().updateMenuEntity(menuId, entityModel);
    MenuModel? menu = await locator<MenuService>().getMenu(menuId);
    _apiMenu = menu?.copyWith();
    emit(menu);
  }
}

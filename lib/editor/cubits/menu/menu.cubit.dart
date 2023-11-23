import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/config/service_locator.dart';
import 'package:valiq_editor_demo/models/menu/entity.model.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';
import 'package:valiq_editor_demo/models/menu/qr_code_configuration.model.dart';
import 'package:valiq_editor_demo/models/menu/theme_configuration.model.dart';
import 'package:valiq_editor_demo/services/menu.service.dart';

/// The [MenuCubit] class is responsible for managing the state of the menu in the Valiq Editor Demo.
/// It extends the [Cubit] class and holds a nullable [MenuModel] as its state.
///
/// The [MenuCubit] requires a [menuId] and an optional [isAnonymous] parameter.
/// The [menuId] is used to fetch the menu from the [MenuService].
/// The [isAnonymous] parameter indicates whether the user is anonymous or not.
///
/// The [MenuCubit] has several getter methods to check if certain parts of the menu have been modified.
/// - [modified] returns true if the menu has been modified.
/// - [themeConfigEdited] returns true if the theme configuration has been edited.
/// - [qrCodeConfigEdited] returns true if the QR code configuration has been edited.
/// - [entityEdited] returns true if the entity has been edited.
/// - [ready] returns true if the menu has finished loading and is ready to be displayed.
///
/// The [MenuCubit] provides several methods to update the menu state:
/// - [fetchMenu] fetches the menu from the [MenuService] and updates the state.
/// - [updateThemeConfiguration] updates the theme configuration of the menu.
/// - [updateQRCodeConfiguration] updates the QR code configuration of the menu.
/// - [updateEntity] updates the entity of the menu.
/// - [saveEntity] saves the entity to the [MenuService] and updates the state.
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

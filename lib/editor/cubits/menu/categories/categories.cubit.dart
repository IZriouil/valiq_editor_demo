import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/config/service_locator.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';
import 'package:valiq_editor_demo/services/authentication.service.dart';
import 'package:valiq_editor_demo/services/category.service.dart';

import 'items/items.cubit.dart';

class MenuCategoriesCubit extends Cubit<List<CategoryModel>> {
  final String menuId;
  final bool handleItems;
  StreamSubscription<List<CategoryModel>>? _categoriesSubscription;
  Map<String, CategoryItemsCubit> itemCubits = {};

  MenuCategoriesCubit(this.menuId, {this.handleItems = true}) : super([]) {
    _subscribeToCategories();
  }

  bool _hasError = false;
  bool _isLoading = true;
  List<CategoryModel> _apiCategories = [];

  bool get hasCategories => state.isNotEmpty;
  bool get categoriesChanged => !listEquals(_apiCategories, state);
  bool get hasError => _hasError;
  bool get isLoading => _isLoading;

  void toggleCategoryVisibility(CategoryModel category) {
    category.visible = !category.visible;
    locator<CategoryService>().updateCategory(menuId, category);
    // logger.t("Toggle category ${category.name} visibility to ${category.visible}");
    // List<CategoryModel> update = [...state];

    // logger.t(
    // "Toggle category ${category.name} visibility to ${category.visible}, index ${state.indexWhere((stateCategory) => stateCategory.id == category.id)}");

    // update[state.indexWhere((stateCategory) => stateCategory.id == category.id)] = category;
    // emit(update);
  }

  void _subscribeToCategories() {
    _categoriesSubscription?.cancel();
    _categoriesSubscription = locator<CategoryService>()
        .getCategories(menuId, fake: !locator<AuthenticationService>().isAuthenticated())
        .listen((categories) {
      if (handleItems) {
        _handleItemsStreams(categories);
      }
      logger.t("Categories triggered from firebase json: ${jsonEncode(categories)}");
      _isLoading = false;
      categories.sort((a, b) => a.position.compareTo(b.position));
      _apiCategories = [...categories.map((category) => category.copyWith())];
      emit(categories);
    })
      ..onError((error, stackTrace) {
        logger.e("API Get Categories got error", error: error);
        _hasError = true;
        emit([]);
      });
  }

  @override
  Future<void> close() {
    logger.t("Closing categories cubit");
    _categoriesSubscription?.cancel();
    for (CategoryItemsCubit itemCubit in itemCubits.values) {
      itemCubit.close();
    }
    return super.close();
  }

  void _handleItemsStreams(List<CategoryModel> categories) {
    // New Categories
    // exists in categories and doesnt exist in state
    categories
        .where((category) => !state.any((stateCategory) => stateCategory.id == category.id))
        .forEach((newCategory) {
      logger.t("New category ${newCategory.name}/${newCategory.id}");
      itemCubits[newCategory.id] = CategoryItemsCubit(menuId, newCategory.id);
    });

    // Updated Categories
    // exists in state and exists in categories but not the same
    state
        .where((stateCategory) =>
            categories.any((category) => category.id == stateCategory.id && category != stateCategory))
        .forEach((updatedCategory) {
      logger.t("Category ${updatedCategory.id}/${updatedCategory.name} updated");
      // itemCubits[updatedCategory.id] = CategoryItemsCubit(menuId, updatedCategory.id);
    });
    // Deleted Categories
    // exists in state and doesnt exist in categories
    state
        .where((stateCategory) => !categories.any((category) => category.id == stateCategory.id))
        .forEach((deletedCategory) {
      logger.t("Category ${deletedCategory.id}/${deletedCategory.name} deleted");
      itemCubits[deletedCategory.id]?.close();
      itemCubits.remove(deletedCategory.id);
    });
  }
}

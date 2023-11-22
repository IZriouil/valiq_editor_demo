import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/config/service_locator.dart';
import 'package:valiq_editor_demo/models/menu/category/item/item.model.dart';
import 'package:valiq_editor_demo/services/authentication.service.dart';
import 'package:valiq_editor_demo/services/item.service.dart';

class CategoryItemsCubit extends Cubit<List<ItemModel>> {
  final String menuId;
  final String categoryId;
  StreamSubscription<List<ItemModel>>? _itemsSubscription;

  CategoryItemsCubit(this.menuId, this.categoryId) : super([]) {
    _subscribeToItems();
  }

  bool _hasError = false;
  bool _isLoading = true;
  List<ItemModel> _apiItems = [];

  bool get hasItem => state.isNotEmpty;
  bool get hasError => _hasError;
  bool get isLoading => _isLoading;
  bool get itemsChanged => !listEquals(_apiItems, state);

  void _subscribeToItems() {
    _itemsSubscription?.cancel();
    _itemsSubscription = locator<ItemService>()
        .getItems(menuId, categoryId, fake: !locator<AuthenticationService>().isAuthenticated())
        .listen((items) {
      _isLoading = false;
      logger.t("Items for category $categoryId triggered from firebase");
      items.sort((a, b) => a.position.compareTo(b.position));
      _apiItems = [...items.map((item) => item.copyWith())];
      emit(items);
    })
      ..onError((error, stackTrace) {
        logger.e("API Get Items $categoryId got error", error: error);
        _hasError = true;
        emit([]);
      });
  }

  void reorderItem(int oldIndex, int newIndex) {
    // state has list of categories each has position 1,2,3,4,5
    // we need to insert old index category to new index
    // and need to update the positions of the categories

    // 1. get the category from old index
    ItemModel category = state[oldIndex];
    // 2. remove the category from old index
    List<ItemModel> update = [...state];
    update.removeAt(oldIndex);
    // 3. insert the category to new index
    update.insert(newIndex, category);
    // 4. update the positions of the categories
    update.asMap().forEach((index, category) {
      category.position = index + 1;
    });

    emit(update);
  }

  Future<void> saveReorder() async {
    if (!itemsChanged) return;
    logger.t("Save reorder");
    // 1. detect the categories that changed positions
    List<ItemModel> changedItems = [];
    state.asMap().forEach((index, item) {
      if (item.position != _apiItems.firstWhere((element) => element.id == item.id).position) {
        changedItems.add(item);
      }
    });
    // 2. update the positions of the categories detected
    if (changedItems.isEmpty) {
      logger.t("No items changed positions");
      return;
    }

    await locator<ItemService>().updateItemPositions(menuId, categoryId, changedItems);
  }

  @override
  Future<void> close() {
    logger.t("Closing items cubit for category $categoryId");
    _itemsSubscription?.cancel();
    return super.close();
  }

  toggleItemVisibility(ItemModel item) {
    item.visible = !item.visible;
    locator<ItemService>().updateItem(menuId, categoryId, item);
  }

  Future<void> deleteItem(ItemModel item) async {
    List<ItemModel> update = [...state];

    update.removeWhere((stateItem) => stateItem.id == item.id);

    // update the positions of the categories
    update.asMap().forEach((index, item) {
      item.position = index + 1;
    });

    List<ItemModel> changedItems = [];
    state.asMap().forEach((index, item) {
      if (item.position != _apiItems.firstWhere((element) => element.id == item.id).position) {
        changedItems.add(item);
      }
    });

    await locator<ItemService>().deleteItem(menuId, categoryId, item);
    if (changedItems.isEmpty) return;
    await locator<ItemService>().updateItemPositions(menuId, categoryId, changedItems);
  }

  void resetItemsOrder() {
    // use api items to reset the order

    List<ItemModel> reset = [..._apiItems.map((item) => item.copyWith())];

    emit(reset);
  }
}

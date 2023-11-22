import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/menu/classique/pages/categories/widgets/categories_tabs.widget.dart';
import 'package:valiq_editor_demo/menu/classique/pages/categories/widgets/category_items.widget.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';

class CategoriesListWidget extends StatefulWidget {
  final List<CategoryModel> categories;
  const CategoriesListWidget({super.key, required this.categories});

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  late AutoScrollController controller;
  final AutoScrollController tabScrollController = AutoScrollController();
  late CategoryModel activeCategory;

  @override
  initState() {
    super.initState();
    controller = AutoScrollController();
    activeCategory = widget.categories.first;
    controller.addListener(onScrollChanged);
  }

  @override
  void dispose() {
    controller.removeListener(onScrollChanged);
    controller.dispose();
    super.dispose();
  }

  void onScrollChanged() {
    if (tabScrollController.isAutoScrolling) return;
    List<double> categoriesHeight = controller.tagMap.values.map((e) => e.context.size!.height).toList();

    int currentIndex = widget.categories.indexOf(activeCategory);
    // int nextIndex = currentIndex + 1;

    late double currentCategoryOffset;
    if (currentIndex == 0) {
      currentCategoryOffset = 0;
    } else {
      currentCategoryOffset =
          categoriesHeight.sublist(0, currentIndex).reduce((value, element) => value + element);
    }

    late double nextCategoryOffset;
    if (currentIndex > widget.categories.length - 1) {
      nextCategoryOffset = categoriesHeight.reduce((value, element) => value + element);
    } else {
      nextCategoryOffset =
          categoriesHeight.sublist(0, currentIndex + 1).reduce((value, element) => value + element);
    }

    // The magic is here
    // if the current offset is greater than the next category offset
    // and there is a next category
    if (controller.offset >= nextCategoryOffset && currentIndex < widget.categories.length) {
      scrollBarToCategorieIndex(widget.categories.indexOf(activeCategory) + 1);
    }
    if (controller.offset < currentCategoryOffset && currentIndex > 0) {
      scrollBarToCategorieIndex(widget.categories.indexOf(activeCategory) - 1);
    }
  }

  void scrollBarToCategorieIndex(int index, {fromTab = false}) {
    setState(() {
      activeCategory = widget.categories[index];
    });
    tabScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    if (fromTab) {
      controller.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.begin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoriesTabsWidget(
            key: const ValueKey("categories_tabs"),
            categories: widget.categories,
            onCategoryTap: (index) => scrollBarToCategorieIndex(index, fromTab: true),
            controller: tabScrollController,
            activeCategory: activeCategory),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kDefaultPadding),
            restorationId: 'categories_list_scroll_view',
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widget.categories
                    .map((category) => AutoScrollTag(
                          key: ValueKey(category.id),
                          controller: controller,
                          index: widget.categories.indexOf(category),
                          // color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.name,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: kDefaultPadding / 2),
                              CategoryItemsWidget(
                                key: ValueKey("category_${category.id}"),
                                category: category,
                              )
                            ],
                          ),
                        ))
                    .toList()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

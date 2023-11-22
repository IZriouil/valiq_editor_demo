import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';

typedef IndexCall = void Function(int index);

class CategoriesTabsWidget extends StatefulWidget {
  final List<CategoryModel> categories;
  final CategoryModel activeCategory;
  final IndexCall onCategoryTap;
  final AutoScrollController? controller;
  const CategoriesTabsWidget(
      {super.key,
      required this.categories,
      required this.activeCategory,
      this.controller,
      required this.onCategoryTap});

  @override
  State<CategoriesTabsWidget> createState() => _CategoriesTabsWidgetState();
}

class _CategoriesTabsWidgetState extends State<CategoriesTabsWidget> {
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        AutoScrollController(
          axis: Axis.horizontal,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      width: double.infinity,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          restorationId: 'categories_tabs_scroll',
          controller: controller,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...widget.categories
                  .map((category) => AutoScrollTag(
                        key: ValueKey("tab_${category.id}"),
                        controller: controller,
                        index: widget.categories.indexOf(category),
                        child: InkWell(
                          onTap: () {
                            widget.onCategoryTap(widget.categories.indexOf(category));
                            // setState(() {
                            //   activeCategory = category;
                            //   isPageScrolling = true;
                            // });
                            // scrollPage
                            //     .scrollToIndex(
                            //   categories.indexOf(category),
                            //   preferPosition: AutoScrollPosition.begin,
                            // )
                            //     .then((value) {
                            //   setState(() {
                            //     isPageScrolling = false;
                            //   });
                            // });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(widget.activeCategory.id == category.id ? 1 : .2),
                                        width: 3))),
                            child: Text(category.name, style: Theme.of(context).textTheme.titleSmall),
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

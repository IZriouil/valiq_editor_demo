import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';

class WhisperWindCategoriesTabs extends StatefulWidget {
  final ValueNotifier<CategoryModel?> selectedCategory;
  final List<CategoryModel> categories;
  const WhisperWindCategoriesTabs({super.key, required this.selectedCategory, required this.categories});

  @override
  State<WhisperWindCategoriesTabs> createState() => _WhisperWindCategoriesTabsState();
}

class _WhisperWindCategoriesTabsState extends State<WhisperWindCategoriesTabs> {
  late CategoryModel activeCategory;

  @override
  void initState() {
    super.initState();
    activeCategory = widget.selectedCategory.value ?? widget.categories.first;
    widget.selectedCategory.addListener(_listenToCategoryChange);
  }

  @override
  void dispose() {
    widget.selectedCategory.removeListener(_listenToCategoryChange);
    super.dispose();
  }

  void _listenToCategoryChange() {
    setState(() {
      activeCategory = widget.selectedCategory.value ?? widget.categories.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      children: [
        for (int i = 0; i < widget.categories.length; i++)
          GestureDetector(
            onTap: () {
              // Handle item tap
              widget.selectedCategory.value = widget.categories[i];
            },
            child: RotatedBox(
              quarterTurns: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Text(
                  widget.categories[i].name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: activeCategory.id == widget.categories[i].id
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

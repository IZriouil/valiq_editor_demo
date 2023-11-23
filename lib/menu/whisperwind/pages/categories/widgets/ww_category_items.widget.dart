import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/categories/categories.cubit.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/categories/items/items.cubit.dart';
import 'package:valiq_editor_demo/menu/whisperwind/pages/categories/widgets/ww_category_item_card.widget.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';
import 'package:valiq_editor_demo/models/menu/category/item/item.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';
import 'package:valiq_editor_demo/widgets/error.widget.dart';
import 'package:valiq_editor_demo/widgets/loading.widget.dart';

class WhisperWindCategoryItems extends StatefulWidget {
  final ValueNotifier<CategoryModel?> selectedCategory;
  const WhisperWindCategoryItems({super.key, required this.selectedCategory});

  @override
  State<WhisperWindCategoryItems> createState() => _WhisperWindCategoryItemsState();
}

class _WhisperWindCategoryItemsState extends State<WhisperWindCategoryItems> {
  late CategoryModel activeCategory;

  @override
  void initState() {
    super.initState();
    activeCategory = widget.selectedCategory.value!;
    widget.selectedCategory.addListener(_listenToCategoryChange);
  }

  @override
  void dispose() {
    widget.selectedCategory.removeListener(_listenToCategoryChange);
    super.dispose();
  }

  void _listenToCategoryChange() {
    setState(() {
      activeCategory = widget.selectedCategory.value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: Text(
              activeCategory.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
      BlocBuilder<CategoryItemsCubit, List<ItemModel>>(
        bloc: context.read<MenuCategoriesCubit>().itemCubits[activeCategory.id],
        buildWhen: (previous, current) => previous != current,
        builder: (context, items) {
          CategoryItemsCubit? itemCubit = context.read<MenuCategoriesCubit>().itemCubits[activeCategory.id];
          if (itemCubit == null) {
            logger.e("Items for category ${activeCategory.name} not found, its cubit is null");
            return const ApplicationErrorWidget().center;
          }
          if (itemCubit.hasError) {
            logger.e("Items Stream for category ${activeCategory.name} got error");
            return const ApplicationErrorWidget().center;
          }
          if (itemCubit.isLoading) {
            logger.i("Waiting for category ${activeCategory.name} items data");
            return const ApplicationLoadingWidget().center;
          }

          logger.i("Category ${activeCategory.name} items data received");

          return Column(
            children: [
              ...items
                  .map((item) => WhisperWindCategoryItemCard(
                        item: item,
                      ).padding)
                  .toList(),
            ],
          );
        },
      ),
    ]).paddingH.paddingH;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/categories/categories.cubit.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/categories/items/items.cubit.dart';
import 'package:valiq_editor_demo/menu/classique/pages/item/item_details.page.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';
import 'package:valiq_editor_demo/models/menu/category/item/item.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';
import 'package:valiq_editor_demo/widgets/error.widget.dart';
import 'package:valiq_editor_demo/widgets/loading.widget.dart';

class CategoryItemsWidget extends StatelessWidget {
  final CategoryModel category;
  const CategoryItemsWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryItemsCubit, List<ItemModel>>(
      bloc: context.read<MenuCategoriesCubit>().itemCubits[category.id],
      buildWhen: (previous, current) => previous != current,
      builder: (context, items) {
        CategoryItemsCubit? itemCubit = context.read<MenuCategoriesCubit>().itemCubits[category.id];
        if (itemCubit == null) {
          logger.e("Items for category ${category.name} not found, its cubit is null");
          return const ApplicationErrorWidget().center;
        }
        if (itemCubit.hasError) {
          logger.e("Items Stream for category ${category.name} got error");
          return const ApplicationErrorWidget().center;
        }
        if (itemCubit.isLoading) {
          logger.i("Waiting for category ${category.name} items data");
          return const ApplicationLoadingWidget().center;
        }

        logger.i("Category ${category.name} items data received");

        return Column(
          children: [
            ...items
                .map((item) => ListTile(
                      visualDensity: const VisualDensity(vertical: 4),
                      minVerticalPadding: 0,

                      contentPadding: EdgeInsets.zero,
                      key: ValueKey(item.id),
                      title: Row(
                        children: [
                          Expanded(child: Text(item.name, style: Theme.of(context).textTheme.titleSmall!)),
                          Text("${(item.price * 100).toStringAsFixed(2)}€", // TODO: Add currency symbol
                              style: Theme.of(context).textTheme.labelLarge)
                        ],
                      ),
                      subtitle: item.description == null
                          ? null
                          : Text(
                              item.description!,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodySmall!,
                              overflow: TextOverflow.ellipsis,
                            ),
                      leading: item.image != null
                          ? Hero(
                              tag: "${item.id}_image",
                              child: Container(
                                width: 80,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(item.image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : null,
                      onTap: () => ItemDetailsPage.navigate(context, item: item, category: category),
                      // subtitle: Text(item.),
                    ))
                .toList(),
          ],
        );
      },
    );
  }
}

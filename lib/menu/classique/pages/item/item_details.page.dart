import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';
import 'package:valiq_editor_demo/models/menu/category/item/item.model.dart';

class ItemDetailsPage extends StatelessWidget {
  final ItemModel item;
  final CategoryModel category;
  const ItemDetailsPage({super.key, required this.item, required this.category});

  static Future<void> navigate(BuildContext context,
      {required ItemModel item, required CategoryModel category}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ItemDetailsPage(item: item, category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // logger.d(context.read<MenuCategoriesCubit>().isLoading);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            if (item.image != null)
              Expanded(
                flex: 1,
                child: Hero(
                  tag: "${item.id}_image",
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(item.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.name,
                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).buttonTheme.colorScheme!.primary,
                                      ),
                                ),
                                const SizedBox(height: kDefaultPadding / 4),
                                Text(item.name, style: Theme.of(context).textTheme.headlineMedium)
                              ],
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.surfaceVariant,
                            ),
                            child:
                                Text("${(item.price * 100).toStringAsFixed(2)}€", // Todo: Add currency symbol
                                    style: Theme.of(context).textTheme.labelLarge),
                          ),
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      // rating
                      if (item.rating != null) ...[
                        Row(children: [
                          ...List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ]),
                        const SizedBox(height: kDefaultPadding),
                      ],

                      // Chip(
                      //     backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      //     avatar: Icon(
                      //       Icons.access_time,
                      //       size: 18,
                      //     ),
                      //     label: Text("Vegan", style: Theme.of(context).textTheme.labelMedium!.copyWith())),
                      const SizedBox(height: kDefaultPadding),

                      Text(item.description!, style: Theme.of(context).textTheme.labelMedium!)
                    ],
                  ),
                )),
          ],
        ));
  }
}

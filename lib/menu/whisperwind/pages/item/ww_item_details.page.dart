import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/models/menu/category/item/item.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';

class WhisperWindItemDetailsPage extends StatelessWidget {
  final ItemModel item;
  const WhisperWindItemDetailsPage({super.key, required this.item});

  static Future<void> navigate(BuildContext context, {required ItemModel item}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WhisperWindItemDetailsPage(
          item: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // logger.d(context.read<MenuCategoriesCubit>().isLoading);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
              const SizedBox(height: kDefaultPadding),
              Text(
                item.name,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ).paddingH,
          const SizedBox(height: kDefaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(kDefaultPadding).copyWith(
                    topLeft: Radius.zero,
                    bottomLeft: Radius.zero,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                      ),
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      child: Text(
                        "\$${(item.price * 100).toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Hero(
                      tag: "${item.id}_image",
                      child: Container(
                        width: 300,
                        height: 300,
                        transform: Matrix4.translationValues(50, 0.0, 0.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.surfaceVariant,
                              width: 5,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          image: DecorationImage(
                            image: NetworkImage(item.image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Container(
                        padding: const EdgeInsets.all(kDefaultPadding / 2),
                        margin: const EdgeInsets.only(left: kDefaultPadding * 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(kDefaultPadding).copyWith(
                            topRight: Radius.zero,
                            bottomRight: Radius.zero,
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: kDefaultPadding / 2),
                            IconButton(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                style: IconButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.arrow_back)),
                            const Spacer(),
                            IconButton(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                style: IconButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.arrow_forward)),
                            const SizedBox(width: kDefaultPadding / 2),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Text(
                item.description ?? "No description available",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ).padding)
        ]));
  }
}

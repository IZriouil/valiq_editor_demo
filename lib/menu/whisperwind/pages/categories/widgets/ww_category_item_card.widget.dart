import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/menu/whisperwind/pages/item/ww_item_details.page.dart';
import 'package:valiq_editor_demo/models/menu/category/item/item.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';

class WhisperWindCategoryItemCard extends StatelessWidget {
  final ItemModel item;
  const WhisperWindCategoryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 230,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.only(top: 50 + kDefaultPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(kDefaultPadding * 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ).paddingH,
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(
                    item.description!,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ).paddingH,
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        "\$${(item.price * 100).toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ).paddingH,
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          // Handle item tap
                          WhisperWindItemDetailsPage.navigate(context, item: item);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(kDefaultPadding * 0.5).copyWith(
                                topRight: Radius.zero,
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.circular(kDefaultPadding * 1.5)),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
          if (item.image != null)
            Hero(
              tag: "${item.id}_image",
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.background,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    width: 7,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(item.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

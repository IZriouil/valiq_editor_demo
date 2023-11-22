import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/categories/categories.cubit.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/menu.cubit.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';
import 'package:valiq_editor_demo/widgets/error.widget.dart';
import 'package:valiq_editor_demo/widgets/loading.widget.dart';

import 'widgets/ww_categories_tabs.widget.dart';
import 'widgets/ww_category_items.widget.dart';

class WhisperWindMenuCategoriesPage extends StatelessWidget {
  const WhisperWindMenuCategoriesPage({super.key});

  static Future<void> navigate(BuildContext context) {
    MenuModel menu = context.read<MenuCubit>().state!;
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => MenuCategoriesCubit(menu.id),
          child: const WhisperWindMenuCategoriesPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<CategoryModel?> selectedCategory = ValueNotifier(null);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<MenuCategoriesCubit, List<CategoryModel>>(
          bloc: context.read<MenuCategoriesCubit>(),
          builder: (context, categories) {
            if (context.read<MenuCategoriesCubit>().hasError) {
              logger.e("Categories Stream got error");
              return const ApplicationErrorWidget().center;
            }
            if (context.read<MenuCategoriesCubit>().isLoading) {
              logger.i("Waiting for categories data");
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Column(children: [
                      const SizedBox(height: kDefaultPadding),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 7,
                          ),
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding),
                    ]),
                  ),
                  Expanded(child: const ApplicationLoadingWidget().center),
                ],
              );
            }

            logger.i("Categories data received");

            selectedCategory.value ??= categories.first;

            return MultiBlocProvider(
              providers: context
                  .read<MenuCategoriesCubit>()
                  .itemCubits
                  .entries
                  .map((entry) => BlocProvider.value(value: entry.value))
                  .toList(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 65,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Column(children: [
                      const SizedBox(height: kDefaultPadding),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 7,
                          ),
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding),
                      Expanded(
                          child: WhisperWindCategoriesTabs(
                        selectedCategory: selectedCategory,
                        categories: categories,
                      ))
                    ]),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      const SizedBox(height: kDefaultPadding),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              WhisperWindCategoryItems(
                                selectedCategory: selectedCategory,
                              ),
                              const SizedBox(height: kDefaultPadding),
                              Row(
                                // navigation buttons
                                children: [
                                  if (categories.length > 1 &&
                                      categories.indexOf(selectedCategory.value!) != 0)
                                    IconButton(
                                      color: Theme.of(context).colorScheme.primary,
                                      onPressed: () {
                                        selectedCategory.value = categories[
                                            (categories.indexOf(selectedCategory.value!) - 1) %
                                                categories.length];
                                      },
                                      icon: const Icon(Icons.arrow_back_ios),
                                    ),
                                  const Spacer(),
                                  if (categories.length > 1 &&
                                      categories.indexOf(selectedCategory.value!) != categories.length - 1)
                                    IconButton(
                                      color: Theme.of(context).colorScheme.primary,
                                      onPressed: () {
                                        selectedCategory.value = categories[
                                            (categories.indexOf(selectedCategory.value!) + 1) %
                                                categories.length];
                                      },
                                      icon: const Icon(Icons.arrow_forward_ios),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            );
          },
        ));
  }
}

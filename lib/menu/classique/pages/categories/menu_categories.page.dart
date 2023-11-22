import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/categories/categories.cubit.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/menu.cubit.dart';
import 'package:valiq_editor_demo/menu/classique/pages/categories/widgets/categories_list.widget.dart';
import 'package:valiq_editor_demo/models/menu/category/category.model.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';
import 'package:valiq_editor_demo/widgets/error.widget.dart';

class MenuCategoriesPage extends StatelessWidget {
  const MenuCategoriesPage({super.key});

  static Future<void> navigate(BuildContext context) {
    MenuModel menu = context.read<MenuCubit>().state!;
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => MenuCategoriesCubit(menu.id),
          child: const MenuCategoriesPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            color: Theme.of(context).colorScheme.background,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.chevron_left),
          ),
          title: Text(
            "Menu",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
          actions: [
            IconButton(
              color: Theme.of(context).colorScheme.background,
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: BlocBuilder<MenuCategoriesCubit, List<CategoryModel>>(
          bloc: context.read<MenuCategoriesCubit>(),
          builder: (context, categories) {
            if (context.read<MenuCategoriesCubit>().hasError) {
              logger.e("Categories Stream got error");
              return const ApplicationErrorWidget().center;
            }
            if (context.read<MenuCategoriesCubit>().isLoading) {
              logger.i("Waiting for categories data");
              return const CircularProgressIndicator().center;
            }

            logger.i("Categories data received");

            return MultiBlocProvider(
              providers: context
                  .read<MenuCategoriesCubit>()
                  .itemCubits
                  .entries
                  .map((entry) => BlocProvider.value(value: entry.value))
                  .toList(),
              child: CategoriesListWidget(
                key: const ValueKey("categories_list"),
                categories: categories,
              ),
            );
          },
        ));
  }
}

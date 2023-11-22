import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/menu/classique/pages/categories/menu_categories.page.dart';
import 'package:valiq_editor_demo/models/menu/extensions.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';

class MenuHomePage extends StatelessWidget {
  final MenuModel menu;
  const MenuHomePage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildCoverWidget(size)),
          Expanded(flex: 2, child: SingleChildScrollView(child: _buildEntityWidget(context, size))),
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildEntityWidget(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            menu.entity.logo,
            width: 80,
            height: 80,
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        Text(
          menu.entity.name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: kDefaultPadding / 2),
        Opacity(
          opacity: .5,
          child: Text(
            menu.entity.slogan,
            // faker.lorem.sentences(10).join(" "),
            style: Theme.of(context).textTheme.bodyLarge,
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ).padding2x;
  }

  Widget _buildActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Check our menu",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            MenuCategoriesPage.navigate(context);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.background,
            fixedSize: const Size(50, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Icon(Icons.arrow_forward),
        ),
      ],
    ).padding;
  }

  Widget _buildCoverWidget(Size size) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: menu.entity.imgCoverProvider,
              fit: BoxFit.cover,
              onError: (exception, stackTrace) {
                logger.e(exception);
              },
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(
                constraints.maxWidth * .5,
              ),
            )),
      );
    });
  }
}

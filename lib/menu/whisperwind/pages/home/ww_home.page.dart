import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/models/menu/extensions.dart';
import 'package:valiq_editor_demo/models/menu/menu.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';

import '../categories/ww_menu_categories.page.dart';

class WhisperWindMenuHomePage extends StatelessWidget {
  final MenuModel menu;
  const WhisperWindMenuHomePage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            WhisperWindMenuCategoriesPage.navigate(context);
          }
        },
        child: Stack(
          children: [
            _buildCoverWidget(context),
            Container(
              color: Theme.of(context).colorScheme.background.withOpacity(.9),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: SingleChildScrollView(child: _buildEntityWidget(context, size)),
                      )),
                  _buildActionButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntityWidget(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: kDefaultPadding / 2),
        Opacity(
          opacity: .5,
          child: Text(
            menu.entity.slogan,
            // faker.lorem.sentences(10).join(" "),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ).padding2x;
  }

  Widget _buildActionButton(BuildContext context) {
    return Column(
      children: [
        Text(
          "Swipe to check our menu",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(height: kDefaultPadding / 2),
        Container(
          width: 100,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0),
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withOpacity(0),
              ],
            ),
          ),
        ),
      ],
    ).padding;
  }

  Widget _buildCoverWidget(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: menu.entity.imgCoverProvider,
        fit: BoxFit.cover,
        onError: (exception, stackTrace) {
          logger.e(exception);
        },
      ),
    ));
  }
}

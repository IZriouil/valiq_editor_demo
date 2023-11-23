import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/menu.cubit.dart';
import 'package:valiq_editor_demo/models/menu/theme_configuration.model.dart';
import 'package:valiq_editor_demo/widgets/color_picker.widget.dart';

class EditorCustomizationSection extends StatelessWidget {
  const EditorCustomizationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeConfigurationModel theme = context.watch<MenuCubit>().state!.theme;

    logger.i(
        "EditorCustomizationSection build, some changes in only theme ? ${context.read<MenuCubit>().modified}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Theme colors",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        ColorPicketWidget(
            label: "Brand Color",
            initialColor: theme.brandColor,
            onColorChanged: (color) {
              if (theme.brandColor == color) return;
              context.read<MenuCubit>().updateThemeConfiguration(theme.copyWith(brandColor: color));
            },
            description: "This is the brand color"),
        const SizedBox(height: kDefaultPadding),
        Text("Theme Fonts",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: kDefaultPadding / 2),
        Text("Titles/Headlines Fonts",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: kDefaultPadding / 2),
        SegmentedButton<String>(
          multiSelectionEnabled: false,
          onSelectionChanged: (fonts) {
            ThemeConfigurationModel newTheme = theme.copyWith(titlesFont: fonts.single);
            context.read<MenuCubit>().updateThemeConfiguration(newTheme);
          },
          segments: const [
            ButtonSegment<String>(value: "Roboto", label: Text("Roboto")),
            ButtonSegment<String>(value: "Montserrat", label: Text("Montserrat")),
            ButtonSegment<String>(value: "Bebas Neue", label: Text("Bebas Neue")),
          ],
          selected: {theme.titlesFont!},
        ),
        const SizedBox(height: kDefaultPadding / 2),
        Text("Body/Text Fonts",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: kDefaultPadding / 2),
        SegmentedButton<String>(
          multiSelectionEnabled: false,
          onSelectionChanged: (fonts) {
            ThemeConfigurationModel newTheme = theme.copyWith(bodyFont: fonts.single);
            context.read<MenuCubit>().updateThemeConfiguration(newTheme);
          },
          segments: const [
            ButtonSegment<String>(value: "Roboto", label: Text("Roboto")),
            ButtonSegment<String>(value: "Mulish", label: Text("Mulish")),
            ButtonSegment<String>(value: "Questrial", label: Text("Questrial")),
          ],
          selected: {theme.bodyFont!},
        ),
        const SizedBox(height: kDefaultPadding),
        Text("Theme brightness",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: kDefaultPadding / 2),
        SegmentedButton<Brightness?>(
          multiSelectionEnabled: false,
          onSelectionChanged: (brightness) {
            if (theme.brightness == brightness.single) return;
            ThemeConfigurationModel newTheme = brightness.single == null
                ? theme.resetBrightness()
                : theme.copyWith(brightness: brightness.single);
            context.read<MenuCubit>().updateThemeConfiguration(newTheme);
          },
          segments: const [
            ButtonSegment<Brightness?>(value: null, label: Text("Auto")),
            ButtonSegment<Brightness?>(value: Brightness.light, label: Text("Always light")),
            ButtonSegment<Brightness?>(value: Brightness.dark, label: Text("Always Dark")),
          ],
          selected: {theme.brightness},
        ),
      ],
    );
  }
}

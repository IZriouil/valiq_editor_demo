import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/menu.cubit.dart';
import 'package:valiq_editor_demo/models/menu/theme_configuration.model.dart';
import 'package:valiq_editor_demo/models/themes/theme.model.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';

class EditorThemeSection extends StatelessWidget {
  const EditorThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeConfigurationModel theme = context.watch<MenuCubit>().state!.theme;

    final themes = [
      ValiqThemeModel(
        id: '',
        name: "Classique",
        description: "A classic theme",
        image: "https://picsum.photos/seed/1/200/300",
      ),
      ValiqThemeModel(
        id: 'ww',
        name: "Whisperwind",
        description: "A modern theme",
        image: "https://picsum.photos/seed/2/200/300",
      ),
    ];
    return Column(
      children: [
        ...themes.map(
          (t) => ThemeCard(
            theme: t,
            active: (t.id == theme.code) || (t.id == '' && theme.code == null),
            onApply: () {
              if (t.id == '') {
                context.read<MenuCubit>().updateThemeConfiguration(theme.resetCode());
                return;
              }
              context.read<MenuCubit>().updateThemeConfiguration(theme.copyWith(code: t.id));
            },
          ),
        ),
      ],
    );
  }
}

class ThemeCard extends StatelessWidget {
  final ValiqThemeModel theme;
  final bool active;
  final VoidCallback? onApply;
  const ThemeCard({
    super.key,
    required this.theme,
    this.active = false,
    this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding / 4),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
          width: .5,
        ),
      ),
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      elevation: active ? null : 0,
      borderOnForeground: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: active,
            child: Chip(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              side: BorderSide(
                color: Theme.of(context).dividerColor,
                width: .2,
              ),
              avatar: const Icon(Icons.check, size: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultPadding / 4),
              ),
              label: Text(
                "Active",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ),
          ),
          const SizedBox(
            height: kDefaultPadding / 2,
          ),
          Text(
            theme.name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Text(
            theme.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(.7),
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultPadding / 4),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: .5,
              ),
              image: DecorationImage(
                image: NetworkImage(theme.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Visibility(
            visible: !active,
            child: Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        onApply?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kDefaultPadding / 4),
                        ),
                        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding / 2,
                        ),
                      ),
                      child: Text("Apply")),
                  const SizedBox(width: kDefaultPadding / 2),
                  TextButton(
                      onPressed: () {},
                      child: Text("Learn More", style: Theme.of(context).textTheme.bodySmall))
                ],
              ),
            ),
          ),
        ],
      ).padding,
    );
  }
}

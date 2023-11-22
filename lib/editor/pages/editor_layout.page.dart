import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:valiq_editor_demo/config/logger_config.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/editor/cubits/layout/extensions.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/menu.cubit.dart';
import 'package:valiq_editor_demo/editor/pages/sections/editor_customization.section.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';
import 'package:valiq_editor_demo/widgets/loading.widget.dart';

import '../cubits/layout/editor_layout.cubit.dart';
import 'sections/editor_theme.section.dart';
import 'sections/menu_preview.section.dart';
import 'widgets/editor_header.widget.dart';

class EditorLayoutPage extends StatelessWidget {
  const EditorLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool ready = context.watch<MenuCubit>().ready;

    return Scaffold(
        body: Column(
      children: [
        const EditorHeaderWidget(),
        Expanded(
          child: ready
              ? Row(
                  children: [
                    BlocSelector<EditorLayoutCubit, EditorLayoutState, bool>(
                      selector: (state) {
                        return state == EditorLayoutState.none;
                      },
                      builder: (context, fullScreenPreview) {
                        logger.d("fullScreenPreview triggered: $fullScreenPreview");
                        return Visibility(
                          visible: !fullScreenPreview,
                          child: Expanded(
                            flex: 1,
                            child: BlocBuilder<EditorLayoutCubit, EditorLayoutState>(
                              buildWhen: (previous, current) => current != EditorLayoutState.none,
                              builder: (context, state) {
                                late Widget child;
                                switch (state) {
                                  case EditorLayoutState.theme:
                                    child = const EditorThemeSection();
                                    break;
                                  case EditorLayoutState.customization:
                                    child = const EditorCustomizationSection();
                                    break;
                                  // case EditorLayoutState.pages:
                                  //   child = const EditorThemePagesSection();
                                  //   break;
                                  default:
                                    return const ApplicationLoadingWidget();
                                }

                                return Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surface,
                                      border: Border(
                                        right: BorderSide(
                                          color: Theme.of(context).dividerColor,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.all(kDefaultPadding),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  state.label,
                                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: Theme.of(context).colorScheme.primary,
                                                      ),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<EditorLayoutCubit>()
                                                        .changeState(EditorLayoutState.none);
                                                  },
                                                  style: IconButton.styleFrom(
                                                      backgroundColor:
                                                          Theme.of(context).colorScheme.primaryContainer,
                                                      padding: EdgeInsets.zero,
                                                      minimumSize: const Size(30, 30),
                                                      iconSize: 15),
                                                  icon: const Icon(
                                                    Icons.close,
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: kDefaultPadding),
                                          child,
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const Expanded(
                      flex: 2,
                      child: MenuPreviewSection(),
                    ),
                  ],
                )
              : const ApplicationLoadingWidget().center,
        )
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';
import 'package:valiq_editor_demo/constants/properties.dart';
import 'package:valiq_editor_demo/editor/cubits/layout/editor_layout.cubit.dart';
import 'package:valiq_editor_demo/utils/extensions/widget.extension.dart';

class EditorHeaderWidget extends StatelessWidget {
  const EditorHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // AccountModel? account = context.read<AuthCubit>().state;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              "assets/images/logo.png",
              width: 50,
              height: 40,
              filterQuality: FilterQuality.high,
            ),
          ),
          BlocBuilder<EditorLayoutCubit, EditorLayoutState>(
            builder: (context, selectedTab) {
              return _buildHeaderTabsButtons(context, selectedTab);
            },
          ),
          const Spacer(),
          const CircleAvatar(backgroundImage: NetworkImage(kDefaultAvatarImage)),
          const SizedBox(width: kDefaultPadding),
        ],
      ),
    );
  }

  Widget _buildHeaderTabsButtons(BuildContext context, EditorLayoutState selectedTab) {
    return ToggleButtons(
        // constraints: const BoxConstraints(minWidth: 0, minHeight: 58),
        isSelected: EditorLayoutState.values.skip(1).map((tab) => tab == selectedTab).toList(),
        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
            ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: (index) {
          context.read<EditorLayoutCubit>().changeState(EditorLayoutState.values.skip(1).elementAt(index));
        },
        children: EditorLayoutState.values
            .skip(1)
            .map((tab) => Text(
                  tab.name.toUpperCase(),
                ).paddingH)
            .toList());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valiq_editor_demo/editor/cubits/menu/menu.cubit.dart';

import 'cubits/layout/editor_layout.cubit.dart';
import 'pages/editor_layout.page.dart';

class ValiqEditorApplication extends StatelessWidget {
  const ValiqEditorApplication({super.key});

  @override
  Widget build(BuildContext context) {
    // String menuId = account?.menus.first ?? "fake";
    String menuId = "fake";

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditorLayoutCubit(),
        ),
        BlocProvider(
          create: (context) => MenuCubit(menuId: menuId, isAnonymous: true),
        ),
      ],
      child: const EditorLayoutPage(),
    );
  }
}

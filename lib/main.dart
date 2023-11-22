import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/config/firebase_config.dart';
import 'package:valiq_editor_demo/config/service_locator.dart';
import 'package:valiq_editor_demo/editor/valiq-editor.app.dart';

void main() {
  initFirebase().then((_) {
    // Services Singletons loading
    setupLocator();
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ValiqEditorApplication(),
    );
  }
}

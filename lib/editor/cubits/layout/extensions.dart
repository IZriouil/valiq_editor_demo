import 'editor_layout.cubit.dart';

extension EditorLayoutStateExtension on EditorLayoutState {
  String get label {
    switch (this) {
      case EditorLayoutState.theme:
        return "Theme";
      case EditorLayoutState.customization:
        return "Theme Customization";
      default:
        return "";
    }
  }
}

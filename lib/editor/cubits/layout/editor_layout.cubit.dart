// a cubit that will handle header button in order to show the section page.

import 'package:flutter_bloc/flutter_bloc.dart';

enum EditorLayoutState { none, theme, customization }

class EditorLayoutCubit extends Cubit<EditorLayoutState> {
  EditorLayoutCubit() : super(EditorLayoutState.customization);

  void changeState(EditorLayoutState newState) {
    if (newState == state) {
      reset();
      return;
    }
    emit(newState);
  }

  void reset() {
    emit(EditorLayoutState.none);
  }
}

// a cubit that will handle header button in order to show the section page.

import 'package:flutter_bloc/flutter_bloc.dart';

enum EditorLayoutState { none, theme, customization }

/// Cubit responsible for managing the layout state of the editor (editor header and tabs).
///
/// It emits [EditorLayoutState] objects to represent different layout states of the editor.
/// The initial state is set to [EditorLayoutState.none].
class EditorLayoutCubit extends Cubit<EditorLayoutState> {
  EditorLayoutCubit() : super(EditorLayoutState.none);

  /// Changes the state of the editor layout.
  ///
  /// If the [newState] is the same as the current state, the layout is reset to the initial state.
  /// Otherwise, the [newState] is emitted.
  void changeState(EditorLayoutState newState) {
    if (newState == state) {
      reset();
      return;
    }
    emit(newState);
  }

  /// Resets the layout state to [EditorLayoutState.none].
  void reset() {
    emit(EditorLayoutState.none);
  }
}

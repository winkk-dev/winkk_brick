// Generated by mason - winkk_brick
import 'package:flutter/material.dart';
import 'logger.dart';

// Just a funny name for managing SnackBars
class Snacks {
  /// ScaffoldMessengerKey for the main scaffold to be used in the outermost widget, acts as a fallback if context ScaffoldMessenger is not available.
  static final GlobalKey<ScaffoldMessengerState> mainScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Shows a SnackBar with the given text.
  static void showTextSnack(BuildContext context, String text) {
    _tryShowingSnackBar(ScaffoldMessenger.of(context), Text(text, maxLines: 3));
  }

  /// Shows a SnackBar with the given child.
  static void showSnackBar(BuildContext context, Widget child) {
    _tryShowingSnackBar(ScaffoldMessenger.of(context), child);
  }

  static void _tryShowingSnackBar(ScaffoldMessengerState? scaffoldMessengerState, Widget child) {
    scaffoldMessengerState ??= mainScaffoldMessengerKey.currentState;
    if (scaffoldMessengerState == null) {
      logger.e('No ScaffoldMessengerState found. Cannot display SnackBar.');
      return;
    }

    scaffoldMessengerState.showSnackBar(SnackBar(content: child));
  }
}
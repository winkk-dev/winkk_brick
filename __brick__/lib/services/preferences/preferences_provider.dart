// Generated by mason - winkk_brick
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'preferences_model.dart';

part 'preferences_provider.g.dart';

/// Provider wrapper for SharedPreferences containing persisted app information and preferences.
@Riverpod(keepAlive: true)
class Preferences extends _$Preferences {
  // Constants for the shared preferences keys
  static const temp = 'temp';

  late SharedPreferences _prefs;

  @override
  FutureOr<PreferencesModel> build() async {
    _prefs = await SharedPreferences.getInstance();
    return PreferencesModel(
      temp: _prefs.getBool(temp) ?? true,
    );
  }

  Future<void> clear() async {
    await _prefs.clear();
    ref.invalidateSelf(); 
    await future; // Only return when rebuilt
  }

  Future<void> setTemp() async {
    await _prefs.setBool(temp, false);
    state = AsyncValue.data(state.requireValue.copyWith(temp: false));
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_colors.dart';

class ThemeState {
  final AppThemeType themeType;
  final AppPalette palette;

  const ThemeState({
    required this.themeType,
    required this.palette,
  });

  factory ThemeState.initial() {
    return ThemeState(
      themeType: AppThemeType.obsidianGold,
      palette: AppPalette.obsidianGold,
    );
  }

  ThemeState copyWith({
    AppThemeType? themeType,
    AppPalette? palette,
  }) {
    return ThemeState(
      themeType: themeType ?? this.themeType,
      palette: palette ?? this.palette,
    );
  }
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void updateTheme(AppThemeType type) {
    emit(ThemeState(
      themeType: type,
      palette: AppPalette.fromType(type),
    ));
  }
}

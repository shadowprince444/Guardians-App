import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/secure_storage.dart';
import '../../utils/app_themes.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  final SecureStorageService _storageService;
  bool isDark = false;

  ThemeBloc(this._storageService) : super(AppTheme.lightTheme) {
    on<CurrentThemeSetEvent>((event, emit) async {
      isDark = await _storageService.isDarkTheme;
      if (isDark) {
        emit(AppTheme.darkTheme);
      } else {
        emit(AppTheme.lightTheme);
      }
    });

    on<ToggleThemeEvent>((event, emit) async {
      isDark = !isDark;
      await _storageService.setIsDarkTheme(isDark);
      add(CurrentThemeSetEvent());
    });
  }
}

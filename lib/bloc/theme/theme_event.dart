part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class CurrentThemeSetEvent extends ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_controller.dart';

final NotifierProvider<ThemeController, ThemeMode> themeProvider =
    NotifierProvider<ThemeController, ThemeMode>(ThemeController.new);

import 'package:flutter/material.dart';
import 'package:yollet_web/UI/template/base/theme_color.dart';

class ThemeShadows {
  static List<BoxShadow> shadowSm = [
    BoxShadow(
        offset: const Offset(0, 1),
        blurRadius: 2,
        spreadRadius: 0,
        color: ThemeColors.black.withOpacity(0.07))
  ];

  static List<BoxShadow> shadow = [
    BoxShadow(
        offset: const Offset(0, 1),
        blurRadius: 2,
        spreadRadius: 0,
        color: ThemeColors.black.withOpacity(0.06)),
    BoxShadow(
        offset: const Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 0,
        color: ThemeColors.black.withOpacity(0.1))
  ];

  static List<BoxShadow> shadowMd = [
    BoxShadow(
        offset: const Offset(0, 4),
        blurRadius: 6,
        spreadRadius: -1,
        color: ThemeColors.black.withOpacity(0.1)),
    BoxShadow(
        offset: const Offset(0, 2),
        blurRadius: 5,
        spreadRadius: 0,
        color: ThemeColors.black.withOpacity(0.06))
  ];

  static List<BoxShadow> shadowLg = [
    BoxShadow(
        offset: const Offset(0, 10),
        blurRadius: 15,
        spreadRadius: -3,
        color: ThemeColors.black.withOpacity(0.1)),
    BoxShadow(
        offset: const Offset(0, 4),
        blurRadius: 6,
        spreadRadius: -2,
        color: ThemeColors.black.withOpacity(0.06))
  ];

  static List<BoxShadow> shadowXl = [
    BoxShadow(
        offset: const Offset(0, 20),
        blurRadius: 25,
        spreadRadius: -5,
        color: ThemeColors.black.withOpacity(0.1)),
    BoxShadow(
        offset: const Offset(0, 10),
        blurRadius: 10,
        spreadRadius: -5,
        color: ThemeColors.black.withOpacity(0.06))
  ];

  static List<BoxShadow> shadow2Xl = [
    BoxShadow(
        offset: const Offset(0, 25),
        blurRadius: 50,
        spreadRadius: -12,
        color: ThemeColors.black.withOpacity(0.25)),
    BoxShadow(
        offset: const Offset(0, 4),
        blurRadius: 6,
        spreadRadius: -2,
        color: ThemeColors.black.withOpacity(0.06))
  ];

  static List<BoxShadow> tableDivider = [
    const BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 0,
        spreadRadius: 0,
        color: ThemeColors.coolgray200),
  ];
}

class ThemeBorder {
  static Border borderXs = Border.all(
    width: 1,
    color: ThemeColors.black,
  );
}

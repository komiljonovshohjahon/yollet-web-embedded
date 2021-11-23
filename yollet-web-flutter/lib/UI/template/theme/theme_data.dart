import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/UI/template/base/theme_color.dart';

class MainTheme {
  static ThemeData get mainThemeOrange {
    return ThemeData(
        backgroundColor: ThemeColors.coolgray50,
        primaryColor: ThemeColors.orange600,
        colorScheme: _colorScheme(),
        buttonTheme: _buttonTheme(),
        dataTableTheme: _dataTableTheme(),
        checkboxTheme: _checkboxTheme(),
        iconTheme: _iconTheme(),
        textSelectionTheme: _textSelectionTheme(),
        toggleableActiveColor: ThemeColors.orange500,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        progressIndicatorTheme: _progressIndicatorTheme());
  }
}

ColorScheme _colorScheme() {
  return ColorScheme.fromSwatch(
    accentColor: ThemeColors.coolgray100,
    backgroundColor: ThemeColors.coolgray50,
    cardColor: ThemeColors.orange50,
    errorColor: ThemeColors.red200,
  );
}

ButtonThemeData _buttonTheme() {
  return ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
    highlightColor: ThemeColors.orange400,
    padding: EdgeInsets.zero,
  );
}

DataTableThemeData _dataTableTheme() {
  return DataTableThemeData(
      horizontalMargin: 0,
      dataRowHeight: 56,
      headingRowHeight: 40,
      columnSpacing: 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ThemeColors.white,
        border: Border.all(width: 1, color: ThemeColors.coolgray300),
      ),
      dividerThickness: 1,
      headingRowColor: MaterialStateProperty.resolveWith((states) {
        return ThemeColors.coolgray50;
      }));
}

CheckboxThemeData _checkboxTheme() {
  return CheckboxThemeData(
      side: const BorderSide(width: 1, color: ThemeColors.coolgray300),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ));
}

IconThemeData _iconTheme() {
  return const IconThemeData(
    color: ThemeColors.coolgray400,
  );
}

TextSelectionThemeData _textSelectionTheme() {
  return const TextSelectionThemeData(
    selectionColor: ThemeColors.coolgray200,
  );
}

ProgressIndicatorThemeData _progressIndicatorTheme() {
  return ProgressIndicatorThemeData(
    color: ThemeColors.orange500,
  );
}

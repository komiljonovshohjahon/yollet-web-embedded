import '../../template/base/template.dart';
import 'package:yollet_web/Utils/localization/localizations.dart';

class SizedText extends StatelessWidget {
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;
  final String? text;
  final TextStyle? textStyle;
  final bool useLocaleText;
  final TextOverflow overflow;
  final TextAlign textAlign;

  const SizedText({
    this.width,
    this.height,
    this.alignment = Alignment.centerLeft,
    this.text,
    this.textStyle,
    this.useLocaleText = true,
    this.overflow = TextOverflow.visible,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Align(
        alignment: alignment,
        child: Text(
          useLocaleText
              ? AppLocalizations.of(context)!.getString(text)!
              : text!,
          style: textStyle,
          // overflow: overflow,
          textAlign: textAlign,
        ),
      ),
    );
  }
}

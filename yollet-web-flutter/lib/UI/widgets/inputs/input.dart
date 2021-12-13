import 'package:yollet_web/UI/template/base/theme_additional.dart';
import 'package:yollet_web/Utils/localization/localizations.dart';

import '../../template/base/template.dart';

class InputForm extends StatefulWidget {
  bool readOnly;
  HeroIcons? icon;
  String? label;
  String? rightLabel;
  String? note;
  Widget? suffix;
  String? suffixText;
  String? prefix;
  Widget? prefixIcon;
  String? hint;
  TextStyle? hintStyle;
  bool? isObscured;
  void Function()? onTap;
  TextStyle? prefStyle;
  double? height;
  String? initValue;
  List<Widget>? subButtons;

  TextStyle? sufStyle;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  double borderRadius;
  Color? bgColor;
  bool? isDense;
  double? inputHeight;
  int? maxlines;

  InputForm({
    Key? key,
    this.hintStyle,
    this.suffixText,
    this.hint,
    this.controller,
    this.height = 88,
    this.validator,
    this.readOnly = false,
    this.isObscured = false,
    this.rightLabel,
    this.prefStyle,
    this.sufStyle,
    this.label = '',
    this.note,
    this.prefix,
    this.suffix,
    this.onTap,
    this.borderRadius = 6.0,
    this.prefixIcon,
    this.subButtons,
    this.bgColor = ThemeColors.white,
    this.initValue,
    this.isDense = false,
    this.inputHeight = 40,
    this.maxlines = 1,
  }) : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  @override
  void initState() {
    if (widget.prefixIcon != null && widget.prefix != null) {
      widget.prefix = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      AppLocalizations.of(context)!
                          .getString(widget.label)
                          .toString(),
                      // widget.label!,
                      style: ThemeTextSemiBold.base
                          .apply(color: ThemeColors.coolgray600)),
                  if (widget.rightLabel != null)
                    Text(
                        AppLocalizations.of(context)!
                            .getString(widget.rightLabel)
                            .toString(),
                        // widget.rightLabel!,
                        style: ThemeTextRegular.base
                            .apply(color: ThemeColors.red500)),
                ],
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(boxShadow: ThemeShadows.shadowSm),
                  child: TextFormField(
                    maxLines: widget.maxlines!,
                    initialValue: widget.initValue,
                    onTap: widget.onTap,
                    validator: widget.validator,
                    readOnly: widget.readOnly,
                    obscureText: widget.isObscured as bool,
                    decoration: InputDecoration(
                      isDense: true,
                      hintStyle: widget.hintStyle ??
                          ThemeTextRegular.base
                              .apply(color: ThemeColors.coolgray400),
                      hintText: AppLocalizations.of(context)!
                          .getString(widget.hint)
                          .toString(),
                      // hintText: widget.hint,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      fillColor: !widget.readOnly
                          ? widget.bgColor
                          : ThemeColors.gray100,
                      prefixStyle: widget.prefStyle ??
                          ThemeTextRegular.base
                              .apply(color: ThemeColors.coolgray600),
                      suffixStyle: widget.sufStyle ??
                          ThemeTextRegular.base
                              .apply(color: ThemeColors.coolgray600),

                      prefixIcon: widget.prefixIcon,
                      prefixIconConstraints:
                          const BoxConstraints(maxWidth: 20, maxHeight: 20),
                      // suffixIconConstraints:
                      //     const BoxConstraints(maxWidth: 20, maxHeight: 20),
                      prefixText: widget.prefix,

                      /// If suffix is added, wrap it with Padding!
                      suffixIcon: widget.suffix ?? const SizedBox(),
                      suffixText: widget.suffixText ?? '',
                      disabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: const BorderSide(
                              color: ThemeColors.gray100, width: 1)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: const BorderSide(
                              color: ThemeColors.red500, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: const BorderSide(
                              color: ThemeColors.red500, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: ThemeColors.gray200, width: 1),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: const BorderSide(
                              color: ThemeColors.blue500, width: 1)),
                    ),
                    controller: widget.controller,
                    style: ThemeTextRegular.base
                        .apply(color: ThemeColors.coolgray800),
                  ),
                ),
              ),
              if (widget.subButtons != null)
                Container(
                  color: ThemeColors.white,
                  child: Row(
                    children: widget.subButtons!,
                  ),
                )
            ],
          ),
          if (widget.note != null)
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: SizedText(
                text: widget.note,
                textStyle:
                    ThemeTextRegular.sm.apply(color: ThemeColors.coolgray400),
              ),
            ),
        ],
      ),
    );
  }
}

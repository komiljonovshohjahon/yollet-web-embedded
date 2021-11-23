import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/utils/localization/localizations.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? initText;
  final bool isPassword;
  final bool isTransparent;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final int? maxLines;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;

  CustomTextFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.initText = "",
    this.isPassword = false,
    this.isTransparent = false,
    this.onChanged,
    this.validator,
    this.readOnly = false,
    this.maxLines,
    this.autofocus = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.keyboardType = TextInputType.text,
    this.controller,
  }) : super(key: key);

  @override
  CustomTextFieldWidgetState createState() => CustomTextFieldWidgetState();
}

class CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputController.text = widget.initText!;
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void _hideKeyboard() {
    Future.microtask(() => FocusScope.of(context).requestFocus(FocusNode()));
  }

  void clear(controller) async {
    _hideKeyboard();
    // Fix for ripple effect throwing exception
    // and the field staying gray.
    // https://github.com/flutter/flutter/issues/36324
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        controller.clear();
        inputController.text = widget.initText!;
        widget.onChanged!(inputController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller ?? inputController,
      obscureText: widget.isPassword,

      style: ThemeTextRegular.base.apply(
          color:
              widget.readOnly ? ThemeColors.gray400 : ThemeColors.coolgray800),
      readOnly: widget.readOnly,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          isDense: true,
          // labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: ThemeTextRegular.base,
          border: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                  width: 1,
                  color: widget.isTransparent
                      ? ThemeColors.transparent
                      : ThemeColors.gray200)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(
                width: 1,
                color: widget.isTransparent
                    ? ThemeColors.transparent
                    : ThemeColors.gray200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(
                width: 1,
                color: widget.isTransparent
                    ? ThemeColors.transparent
                    : ThemeColors.indigo600),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(
                width: 1,
                color: widget.isTransparent
                    ? ThemeColors.transparent
                    : ThemeColors.red600),
          ),
          suffixIcon: widget.readOnly
              ? null
              : IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: ThemeColors.gray300,
                  ),
                  onPressed: () => clear(inputController),
                )),
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,

      // onSaved: (String val) {
      //   widget.value = val;
      // }
    );
  }
}

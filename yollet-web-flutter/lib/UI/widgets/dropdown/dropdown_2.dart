import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:yollet_web/UI/template/base/template.dart';

class DefaultDropdown extends StatefulWidget {
  String? hintText;
  String? label;
  ButtonSize? size;
  List<String> listValues;
  dynamic value;
  String? note;
  String? errorText;
  bool? readOnly;

  ValueChanged onChanged;
  DefaultDropdown({
    this.label,
    this.hintText = "",
    required this.onChanged,
    required this.listValues,
    this.value,
    this.size,
    this.errorText,
    this.readOnly,
    this.note,
  });

  @override
  _DefaultDropdownState createState() => _DefaultDropdownState();
}

class _DefaultDropdownState extends State<DefaultDropdown> {
  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  @override
  Widget build(BuildContext context) {
    double width = double.infinity;
    switch (widget.size) {
      case ButtonSize.XS:
        break;
      case ButtonSize.S:
        width = 116;
        // TODO: Handle this case.
        break;
      case ButtonSize.M:
        // TODO: Handle this case.
        break;
      case ButtonSize.L:
        // TODO: Handle this case.
        break;
      default:
      // TODO: Handle this case.
    }
    return DropdownButtonHideUnderline(
      child: Column(
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SizedText(
                text: widget.label!,
                textStyle: ThemeTextSemiBold.base
                    .apply(color: ThemeColors.coolgray600),
              ),
            ),
          Container(
            decoration: BoxDecoration(
                color: ThemeColors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: ThemeShadows.shadowSm,
                border: Border.all(width: 1, color: ThemeColors.gray200)),
            child: DropdownButton2(
              style: ThemeTextMedium.sm.apply(color: ThemeColors.coolgray800),
              icon: const HeroIcon(HeroIcons.chevronDown,
                  size: 20, color: ThemeColors.coolgray600),
              focusColor: Colors.transparent,
              buttonPadding: const EdgeInsets.all(10),
              hint: widget.hintText != null
                  ? Text(
                      widget.hintText!,
                      style: ThemeTextRegular.base
                          .apply(color: ThemeColors.coolgray400),
                    )
                  : Container(),
              buttonHeight: 40,
              buttonWidth: width,
              items: widget.listValues
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: widget.value,
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

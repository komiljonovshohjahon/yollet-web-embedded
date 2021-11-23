import '../../template/base/template.dart';

class InputWrapper extends StatelessWidget {
  Widget? input;
  String? label;
  String? labelRight;
  InputWrapper(
      {Key? key, required this.input, this.label = '', this.labelRight = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedText(
                text: label,
                textStyle: ThemeTextSemiBold.base
                    .apply(color: ThemeColors.coolgray600)),
            SizedText(
                text: labelRight,
                textStyle:
                    ThemeTextRegular.base.apply(color: ThemeColors.red500)),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        input!,
      ],
    );
  }
}

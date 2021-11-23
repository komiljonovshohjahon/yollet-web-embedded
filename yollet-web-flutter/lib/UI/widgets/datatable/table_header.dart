import 'package:yollet_web/utils/localization/localizations.dart';

import '../../template/base/template.dart';

class TableHeader extends StatelessWidget {
  String? text;
  double? height;
  bool? hasFilter;

  TableHeader({
    Key? key,
    this.text = 'Header',
    this.height = 40,
    this.hasFilter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedText(
        text: text!,
        textStyle: ThemeTextSemiBold.xxs.apply(color: ThemeColors.coolgray500),
      ),
    );
  }
}

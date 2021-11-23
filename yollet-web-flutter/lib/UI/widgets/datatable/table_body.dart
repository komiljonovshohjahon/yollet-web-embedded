import 'package:yollet_web/UI/template/base/template.dart';

class TableBody extends StatelessWidget {
  final String text;
  const TableBody({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: ThemeTextRegular.sm.apply(color: ThemeColors.coolgray900),
      ),
    );
  }
}

import 'package:yollet_web/Utils/format/table_builder.dart';

import '../../template/base/template.dart';

class InputTable extends StatelessWidget {
  double? verticalSpacing;

  List<Widget> listOfInput;
  int? columnCount;

  InputTable({
    Key? key,
    required this.listOfInput,
    this.verticalSpacing = 32,
    this.columnCount = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: TableBuilder(
        verticalSpacing: verticalSpacing,
        columnCnt: columnCount!,
        children: listOfInput,
      ).build(),
    );
  }
}

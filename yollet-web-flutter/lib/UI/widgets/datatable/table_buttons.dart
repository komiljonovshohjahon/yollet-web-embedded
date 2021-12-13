import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/utils/common/constants.dart';

class TableButtons extends StatefulWidget {
  dynamic stateData;
  int page;
  int pageTotal;
  int pageSize;
  VoidCallback previousButtonPressed;
  VoidCallback nextButtonPressed;
  ValueChanged onChanged;

  TableButtons({
    Key? key,
    required this.stateData,
    required this.pageTotal,
    required this.previousButtonPressed,
    required this.nextButtonPressed,
    required this.onChanged,
    required this.page,
    required this.pageSize,
  }) : super(key: key);

  @override
  _TableButtonsState createState() => _TableButtonsState();
}

class _TableButtonsState extends State<TableButtons> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: _buildNavigationButtons(),
        ),
        Row(
          children: _buildPageCount(),
        ),
        Row(
          children: _buildItemLength(),
        )
      ],
    );
  }

  List<Widget> _buildNavigationButtons() {
    List<Widget> list = [];
    list.add(DefaultButton(
      text: 'previous',
      onPressed: widget.previousButtonPressed,
      variant: ButtonVariant.GHOST,
      sizeOfButton: ButtonSize.M,
    ));
    list.add(const SizedBox(width: 8));
    list.add(DefaultButton(
      text: 'next',
      onPressed: widget.nextButtonPressed,
      variant: ButtonVariant.GHOST,
      sizeOfButton: ButtonSize.M,
    ));
    return list;
  }

  List<Widget> _buildPageCount() {
    List<Widget> list = [];
    list.add(RichText(
      text: TextSpan(
          text: 'Page',
          style: ThemeTextRegular.sm,
          children: <TextSpan>[
            TextSpan(text: ' ${widget.page}', style: ThemeTextSemiBold.sm),
            const TextSpan(text: ' of ', style: ThemeTextRegular.sm),
            TextSpan(
                text: widget.pageTotal.toString(), style: ThemeTextSemiBold.sm),
          ]),
      // 'Page ${widget.page} of ${widget.pageTotal}'
    ));
    return list;
  }

  List<Widget> _buildItemLength() {
    List<Widget> list = [];
    list.add(DefaultDropdown(
      hintText: "Show ${widget.pageSize.toString()}",
      value: widget.pageSize.toString(),
      onChanged: widget.onChanged,
      size: ButtonSize.S,
      listValues: [...Constants.pageSizes.map((e) => e.toString())],
    ));
    return list;
  }
}

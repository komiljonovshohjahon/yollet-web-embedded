import 'package:yollet_web/UI/template/base/template.dart';

class TableScroller extends StatelessWidget {
  final Widget child;
  double width;

  TableScroller({Key? key, required this.child, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _sc =
        ScrollController(debugLabel: 'Horizontal Scroll from Table scroller!');

    return Scrollbar(
        isAlwaysShown: true,
        interactive: true,
        controller: _sc,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
              controller: _sc,
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: width), child: child)),
        ));
  }
}

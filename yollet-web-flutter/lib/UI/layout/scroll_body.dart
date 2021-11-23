import 'package:yollet_web/UI/template/base/template.dart';

@immutable
class DefaultScrollBodyOrangeTabletSinglePage extends StatelessWidget {
  final Widget bodyWidget;
  final double paddingTop;
  final double paddingLR;
  Widget? bottomWidget;

  DefaultScrollBodyOrangeTabletSinglePage(this.bodyWidget,
      {this.paddingTop = 16, this.paddingLR = 16, this.bottomWidget});

  @override
  Widget build(BuildContext context) {
    return Container(color: ThemeColors.white, child: getBody());
  }

  Widget getBody() {
    if (bottomWidget == null) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(
            left: paddingLR, right: paddingLR, top: paddingTop, bottom: 0),
        child: bodyWidget,
      );
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: ThemeColors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: paddingLR,
                    right: paddingLR,
                    top: paddingTop,
                    bottom: 0),
                child: bodyWidget,
              ),
            ),
            bottomWidget!
          ]);
    }
  }
}

class HScrollContainer extends StatelessWidget {
  double _height;
  double _width;
  var _children = <Widget>[];

  HScrollContainer({
    required double height,
    double width = double.infinity,
    required List<Widget> children,
  })  : _height = height,
        _width = width,
        _children = children;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _height,
        width: _width,
        child: ListView(scrollDirection: Axis.horizontal, children: _children));
  }
}

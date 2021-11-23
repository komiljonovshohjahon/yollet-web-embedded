import 'package:yollet_web/Utils/localization/localizations.dart';

import '../../template/base/template.dart';

class Breadcrumb extends StatelessWidget {
  List<String> routes;
  Breadcrumb({Key? key, required this.routes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildRoutes(context),
    );
  }

  List<Widget> _buildRoutes(BuildContext context) {
    List<Widget> list = [];
    // list.add(Icon(
    //   Icons.home,
    //   color: ThemeColors.coolgray400,
    // ));
    // list.add(SizedBox(
    //   width: 16,
    // ));
    for (var element in routes) {
      list.add(Text(
          // element,
          AppLocalizations.of(context)!
              .getString(element.contains('/')
                  ? element.substring(0, element.indexOf('/'))
                  : element)
              .toString(),
          style: ThemeTextRegular.xs.apply(
            color: ThemeColors.coolgray500,
          )));
      list.add(const SizedBox(
        width: 8,
      ));
      if (routes.last != element) {
        list.add(const HeroIcon(
          HeroIcons.chevronRight,
          color: ThemeColors.coolgray400,
          size: 20,
          solid: true,
        ));
        list.add(const SizedBox(
          width: 8,
        ));
      }
    }
    return list;
  }
}

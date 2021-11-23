import 'package:flutter_redux/flutter_redux.dart';
import 'package:routemaster/routemaster.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'dart:developer' as developer;
import '../../template/base/template.dart';

class Navigationbar extends StatelessWidget {
  int tabsLength;
  int active;
  List<String> names;
  List<HeroIcons> icons;
  String? id;

  Navigationbar({
    Key? key,
    required this.tabsLength,
    required this.active,
    required this.names,
    required this.icons,
    this.id,
  }) : super(key: key);

  List<DefaultTab> tabList = [];

  @override
  Widget build(BuildContext context) {
    int activeElement = active;
    return Container(
      decoration: const BoxDecoration(
        color: ThemeColors.white,
      ),
      height: 52.0,
      child: Row(
        children: _builtWidgetsDefaultTab(activeElement),
      ),
    );
  }

  List<Widget> _builtWidgetsDefaultTab(int activeElement) {
    List<Widget> list = [];

    for (int index = 0; index < tabsLength; index++) {
      if (activeElement == index) {
        list.add(DefaultTab(
          text: names[index],
          icon: icons[index],
          isActive: true,
          onTap: () {
            developer.log('tap on navigate');
          },
        ));
      } else {
        list.add(DefaultTab(
          text: names[index],
          icon: icons[index],
          onTap: () {
            switch (index) {
              case 0:
                if (id == null) {
                  appStore.dispatch(NavigateToAction(
                    to: AppRoutes.RouteToStoreBasic,
                  ));
                } else {
                  appStore.dispatch(NavigateToAction(
                    to: AppRoutes.RouteToStoreBasic,
                    arguments: {'id': id},
                  ));
                }
                break;
              case 1:
                if (id == null) {
                  appStore.dispatch(NavigateToAction(
                    to: AppRoutes.RouteToStorePayment,
                  ));
                } else {
                  appStore.dispatch(NavigateToAction(
                    to: AppRoutes.RouteToStorePayment,
                    arguments: {'id': id},
                  ));
                }
                break;
              case 2:
                if (id == null) {
                  appStore.dispatch(NavigateToAction(
                    to: AppRoutes.RouteToStoreAccount,
                  ));
                } else {
                  appStore.dispatch(NavigateToAction(
                    to: AppRoutes.RouteToStoreAccount,
                    arguments: {'id': id},
                  ));
                }
                break;
              default:
                appStore.dispatch(NavigateToAction(to: '/notfound'));
            }
          },
        ));
      }
    }
    return list;
  }
}

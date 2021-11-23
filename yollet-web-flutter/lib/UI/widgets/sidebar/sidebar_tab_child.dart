import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/models/sidebar_tab_model.dart';
import 'package:yollet_web/Utils/localization/localizations.dart';

import '../../template/base/template.dart';

class SidebarTabChild extends StatelessWidget {
  HeroIcons? icon;
  int? badgeCount;
  double? height;
  SidebarModel? menuItem;
  AppState state;

  void get navigate {
    appStore.dispatch(NavigateToAction(to: menuItem!.route));
    appStore.dispatch(
        UpdateUIAction(sideBarCollapsedNumber: menuItem!.parentNumber));
    appStore
        .dispatch(UpdateUIAction(sideBarChildNumber: menuItem!.selectedNumber));
  }

  SidebarTabChild({
    Key? key,
    this.icon,
    this.height = 36,
    this.badgeCount,
    required this.state,
    required this.menuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = ThemeColors.coolgray500;

    Color bgColor = state.uiState.sideBarChildNumber == menuItem!.selectedNumber
        ? ThemeColors.blue50
        : ThemeColors.white;
    return InkWell(
      onTap: () => navigate,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: bgColor,
        ),
        height: height,
        child: Row(
          children: [
            if (icon != null)
              HeroIcon(
                icon!,
                size: 24,
                color: textColor,
              ),
            if (icon != null)
              const SizedBox(
                width: 8,
              ),
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!
                    .getString(menuItem!.name)
                    .toString(),
                style: ThemeTextRegular.base.apply(color: textColor),
              ),
            ),
            if (badgeCount != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeColors.coolgray100,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  badgeCount!.toString(),
                  style: ThemeTextRegular.sm.apply(color: textColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

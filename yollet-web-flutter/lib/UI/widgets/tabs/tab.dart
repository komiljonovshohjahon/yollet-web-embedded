import 'package:yollet_web/Utils/localization/localizations.dart';

import '../../template/base/template.dart';

class DefaultTab extends StatelessWidget {
  String text;
  ButtonSize? sizeOfTab;
  HeroIcons? icon;
  double iconSize = 16.0;
  double? tabHeight;
  bool? isActive = false;
  VoidCallback? onTap;

  DefaultTab({
    Key? key,
    this.text = 'tab',
    this.sizeOfTab = ButtonSize.M,
    this.icon,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getSize();

    return InkWell(
      onTap: onTap ?? null,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: tabHeight,
        decoration: BoxDecoration(
          color: isActive! ? ThemeColors.white : ThemeColors.transparent,
          border: isActive!
              ? const Border(
                  bottom: BorderSide(
                    color: ThemeColors.orange500,
                    width: 2.0,
                  ),
                )
              : const Border(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              HeroIcon(
                icon!,
                color:
                    isActive! ? ThemeColors.orange500 : ThemeColors.coolgray400,
                size: iconSize,
              ),
            if (icon != null) const SizedBox(width: 12.0),
            Text(
              AppLocalizations.of(context)!.getString(text).toString(),
              style: ThemeTextRegular.sm.apply(
                color:
                    isActive! ? ThemeColors.orange500 : ThemeColors.coolgray400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getSize() {
    switch (sizeOfTab) {
      case ButtonSize.M:
        tabHeight = 52.0;
        break;
      default:
        tabHeight = 52.0;
        break;
    }
  }
}

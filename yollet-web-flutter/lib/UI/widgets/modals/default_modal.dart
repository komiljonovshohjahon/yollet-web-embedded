import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/Utils/localization/localizations.dart';

class DefaultModal extends StatelessWidget {
  VoidCallback? onConfirm;
  VoidCallback? onCancel;
  String? title;
  String? subTitle;
  List<Widget>? buttons;
  HeroIcons? icon;
  Widget? childWidget;

  DefaultModal(
      {Key? key,
      this.onConfirm,
      this.onCancel,
      this.buttons,
      this.title,
      this.subTitle,
      this.icon,
      this.childWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388.0,
      decoration: BoxDecoration(
        boxShadow: ThemeShadows.shadowLg,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
              color: ThemeColors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 19.0,
                  backgroundColor: ThemeColors.orange100,
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 20.0, maxHeight: 20.0),
                    child: HeroIcon(
                      icon ?? HeroIcons.exclamation,
                      color: ThemeColors.orange500,
                    ),
                  ),
                ),
                const SizedBox(width: 11.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        AppLocalizations.of(context)!
                            .getString(title ?? 'remove_store')
                            .toString(),
                        style: ThemeTextRegular.lg
                            .apply(color: ThemeColors.coolgray900)),
                    const SizedBox(height: 8.0),
                    childWidget ??
                        Text(
                            AppLocalizations.of(context)!
                                .getString(subTitle ??
                                    'Are you sure to remove this store? This\naction cannot be undone')
                                .toString(),
                            style: ThemeTextRegular.sm
                                .apply(color: ThemeColors.coolgray500)),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: ThemeColors.coolgray50,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: buttons ??
                  [
                    DefaultButton(
                      text: 'cancel',
                      onPressed: onCancel,
                      sizeOfButton: ButtonSize.S,
                      variant: ButtonVariant.GHOST,
                    ),
                    const SizedBox(width: 16.0),
                    DefaultButton(
                      text: 'remove',
                      onPressed: onConfirm,
                      sizeOfButton: ButtonSize.S,
                      variant: ButtonVariant.PRIMARY,
                    ),
                  ],
            ),
          ),
        ],
      ),
    );
  }
}

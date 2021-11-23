import 'package:yollet_web/UI/template/base/template.dart';

class DefaultTopbar extends StatelessWidget {
  String? image;

  DefaultTopbar({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0,
      padding: const EdgeInsets.only(left: 20.0, right: 16.0),
      color: ThemeColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 418,
            child: SearchField(),
          ),
          Row(
            children: [
              DefaultButton(
                text: '',
                onPressed: () {},
                variant: ButtonVariant.LINK,
                iconButton: const HeroIcon(
                  HeroIcons.bell,
                  size: 24,
                ),
              ),
              InkWell(
                onTap: () {},
                child: ImagePlaceholder(
                  height: 32,
                  width: 32,
                ),
              ),
              DefaultButton(
                text: '',
                onPressed: () {},
                variant: ButtonVariant.LINK,
                iconButton: const HeroIcon(
                  HeroIcons.chevronDown,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

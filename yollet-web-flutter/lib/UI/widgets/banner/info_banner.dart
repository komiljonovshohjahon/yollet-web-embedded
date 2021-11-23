import '../../template/base/template.dart';

class InfoBanner extends StatelessWidget {
  String? image;
  String? mainText;
  String? secondaryText;
  Color? upperTextColor;
  Color? lowerTextColor;
  Color? backgroundColor;
  double? height;

  InfoBanner({
    Key? key,
    this.image,
    this.mainText,
    this.secondaryText = 'text',
    this.upperTextColor = ThemeColors.coolgray800,
    this.lowerTextColor = ThemeColors.coolgray900,
    this.backgroundColor = ThemeColors.white,
    this.height = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          if (image != null)
            ImagePlaceholder(
              width: 40,
              height: 40,
              url: image,
            ),
          if (image != null)
            const SizedBox(
              width: 10,
            ),
          SizedBox(
            height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (mainText != null)
                  SizedText(
                    text: mainText,
                    textStyle: ThemeTextRegular.sm.apply(color: upperTextColor),
                  ),
                SizedText(
                  text: secondaryText,
                  textStyle: ThemeTextRegular.sm.apply(color: lowerTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

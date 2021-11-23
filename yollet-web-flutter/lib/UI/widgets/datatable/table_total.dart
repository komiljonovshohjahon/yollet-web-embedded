import 'package:yollet_web/Utils/format/number_format_util.dart';

import '../../template/base/template.dart';

class TableTotal extends StatelessWidget {
  dynamic totalCount;
  dynamic totalAmount;
  TableTotal({Key? key, this.totalAmount, this.totalCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle =
        ThemeTextSemiBold.sm.apply(color: ThemeColors.coolgray500);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        boxShadow: ThemeShadows.shadowSm,
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 1, color: ThemeColors.bluegray100),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 256 / 2,
            child: Row(
              children: [
                SizedText(
                  text: 'Total Count',
                  textStyle: textStyle,
                ),
                const SizedBox(
                  width: 64,
                ),
                SizedText(
                  text: totalCount.toString(),
                  textStyle: textStyle,
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedText(
                text: 'Total Approved Amount',
                textStyle: textStyle,
              ),
              const SizedBox(
                width: 64,
              ),
              SizedText(
                text: CurrencyFormatter.simpleCurrency
                    .format(totalAmount)
                    .toString(),
                textStyle: textStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

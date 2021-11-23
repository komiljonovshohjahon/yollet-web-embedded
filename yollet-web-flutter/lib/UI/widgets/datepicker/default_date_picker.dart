import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:yollet_web/UI/template/base/template.dart';

class DefaultDatePicker extends StatelessWidget {
  ButtonSize sizeOfPicker;
  double? widthPicker;
  double? heightPicker;

  DefaultDatePicker({Key? key, this.sizeOfPicker = ButtonSize.M})
      : super(key: key);
  Map<int, String> mapOfDay = {
    1: 'Mo',
    2: 'Tu',
    3: 'We',
    4: 'Th',
    5: 'Fr',
    6: 'Sa',
    7: 'Su'
  };
  List<int> dayData = [];
  String get currentTime =>
      DateFormat('EEEE').format(DateTime.now()).toString().substring(0, 2);
  List<int> listDays = [];
  bool isPast = true;
  @override
  Widget build(BuildContext context) {
    dayData.add(DateTime.now().subtract(Duration(days: 2)).weekday);
    dayData.add(DateTime.now().subtract(Duration(days: 1)).weekday);
    dayData.add(DateTime.now().subtract(Duration(days: 0)).weekday);
    dayData.add(DateTime.now().subtract(Duration(days: -1)).weekday);
    dayData.add(DateTime.now().subtract(Duration(days: -2)).weekday);
    dayData.add(DateTime.now().subtract(Duration(days: -3)).weekday);
    dayData.add(DateTime.now().subtract(Duration(days: -4)).weekday);

    _getSize();
    listDays.add(DateTime.now().subtract(Duration(days: 2)).day);
    listDays.add(DateTime.now().subtract(Duration(days: 1)).day);
    listDays.add(DateTime.now().subtract(Duration(days: 0)).day);
    listDays.add(DateTime.now().subtract(Duration(days: -1)).day);
    listDays.add(DateTime.now().subtract(Duration(days: -2)).day);
    listDays.add(DateTime.now().subtract(Duration(days: -3)).day);
    listDays.add(DateTime.now().subtract(Duration(days: -4)).day);

    return Container(
      width: widthPicker,
      height: heightPicker,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4), topRight: Radius.circular(4))),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ThemeColors.white,
              boxShadow: ThemeShadows.tableDivider,
              // border:
              //     Border(bottom: BorderSide(color: ThemeColors.transparent))
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    HeroIcon(
                      HeroIcons.chevronDoubleLeft,
                      size: 16,
                      color: ThemeColors.coolgray700,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    HeroIcon(
                      HeroIcons.chevronLeft,
                      size: 16,
                      color: ThemeColors.coolgray700,
                    ),
                  ],
                ),
                SizedText(
                  text: 'Dec 2020',
                  textStyle:
                      ThemeTextMedium.sm.apply(color: ThemeColors.coolgray900),
                ),
                Row(
                  children: const [
                    HeroIcon(
                      HeroIcons.chevronDoubleRight,
                      size: 16,
                      color: ThemeColors.coolgray700,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    HeroIcon(
                      HeroIcons.chevronRight,
                      size: 16,
                      color: ThemeColors.coolgray700,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: ThemeColors.white,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
            child: Row(
              children: _weekDaysBuild(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ThemeColors.white,
              boxShadow: ThemeShadows.tableDivider,
              // border:
              //     Border(bottom: BorderSide(color: ThemeColors.transparent))
            ),
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
            child: Row(
              children: _daysBuild(),
            ),
          ),
          Container(
            color: ThemeColors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedText(
              alignment: Alignment.center,
              text: 'Today',
              textStyle: ThemeTextRegular.sm.apply(
                color: ThemeColors.indigo600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getSize() {
    switch (sizeOfPicker) {
      case ButtonSize.M:
        widthPicker = 292;
        heightPicker = 148;
        break;
      default:
        widthPicker = 276;
        heightPicker = 148;
        break;
    }
  }

  List<Widget> _weekDaysBuild() {
    List<Widget> list = [];
    for (int index = 0; index < 7; index++) {
      list.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        child: SizedText(
          text: mapOfDay[dayData[index]],
          textStyle: ThemeTextRegular.sm.apply(color: ThemeColors.coolgray900),
        ),
      ));
    }
    return list;
  }

  List<Widget> _daysBuild() {
    List<Widget> list = [];
    for (int index = 0; index < 7; index++) {
      if (currentTime == mapOfDay[dayData[index]]) {
        isPast = false;

        list.add(Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: ThemeColors.blue300)),
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          child: SizedText(
            text: listDays[index].toString(),
            textStyle: isPast == false
                ? ThemeTextRegular.sm.apply(color: ThemeColors.coolgray900)
                : ThemeTextRegular.sm.apply(color: ThemeColors.coolgray500),
          ),
        ));
      } else {
        list.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          child: SizedText(
            text: listDays[index].toString(),
            textStyle: isPast == false
                ? ThemeTextRegular.sm.apply(color: ThemeColors.coolgray900)
                : ThemeTextRegular.sm.apply(color: ThemeColors.coolgray500),
          ),
        ));
      }
    }
    return list;
  }
}

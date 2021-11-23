import 'package:yollet_web/UI/template/base/template.dart';

class SearchField extends StatelessWidget {
  SearchField({Key? key}) : super(key: key);

  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
      hintText: 'search',
      hintStyle: ThemeTextRegular.base.copyWith(
        color: ThemeColors.coolgray400,
      ),
      fillColor: ThemeColors.coolgray100,
      enabledBorder: OutlineInputBorder(
          gapPadding: 30,
          borderSide:
              const BorderSide(color: ThemeColors.transparent, width: 0),
          borderRadius: BorderRadius.circular(24)),
      filled: true,
      border: OutlineInputBorder(
          borderSide:
              const BorderSide(color: ThemeColors.transparent, width: 0),
          borderRadius: BorderRadius.circular(24)),
      isDense: true,
      prefixIconConstraints: BoxConstraints(maxHeight: 20),
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 10, right: 8),
        child: HeroIcon(
          HeroIcons.search,
          color: ThemeColors.coolgray400,
        ),
      ),
    ));
  }
}

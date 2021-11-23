import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/mgr/navigation/navigation_menu_list.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';
import 'package:yollet_web/Utils/localization/localizations.dart';

import '../../template/base/template.dart';

class SideBarVertical extends StatelessWidget {
  String? mainText;
  String? secondaryText;
  String? imageUrl;

  SideBarVertical({
    Key? key,
    this.mainText = 'good_morning',
    this.secondaryText = 'username@mail.com',
    this.imageUrl = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        // int selectedNumber = state.uiState.sideBarCollapsedNumber;
        return Container(
          decoration: BoxDecoration(
            color: ThemeColors.white,
            boxShadow: ThemeShadows.shadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LogoBanner(),
                  Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 20),
                    child: InfoBanner(
                      image: imageUrl!,
                      mainText: mainText!,
                      secondaryText: secondaryText!,
                      lowerTextColor: ThemeColors.coolgray500,
                    ),
                  ),
                  SizedBox(
                    height: _height - 427,
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Column(
                          children: _buildNavList(state),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Divider(
                      height: 1,
                      color: ThemeColors.coolgray300,
                    ),
                  ),
                  SizedBox(
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Column(
                          children: [
                            SidebarTabParent(
                              state: state,
                              index: 4,
                              icon: HeroIcons.documentText,
                              name: 'Documentation',
                            ),
                            SidebarTabParent(
                              state: state,
                              index: 5,
                              icon: HeroIcons.dotsHorizontal,
                              name: 'More',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 86),
                  Container(
                    height: 72,
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      AppLocalizations.of(context)!
                          .getString('copyright')
                          .toString(),
                      style: ThemeTextRegular.xxs
                          .apply(color: ThemeColors.warmgray500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildNavList(AppState state) {
    // List<Widget> list = NavigationMenus().sidebarParents();

    List<Widget> list = NavigationMenus(state: state).sidebarParents(state);

    return list;
  }
}

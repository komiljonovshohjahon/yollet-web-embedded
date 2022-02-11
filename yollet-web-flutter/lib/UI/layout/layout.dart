import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/UI/layout/large_screen.dart';
import 'package:yollet_web/UI/layout/medium_screen.dart';
import 'package:yollet_web/UI/layout/responsiveness.dart';
import 'package:yollet_web/UI/template/base/template.dart';

class SiteLayout extends StatelessWidget {
  final Widget body;

  const SiteLayout(this.body);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) => Scaffold(
        drawer: Drawer(
          child: SideBarVertical(),
        ),
        drawerEnableOpenDragGesture: ResponsiveWidget.isMediumScreen(context) ||
            ResponsiveWidget.isSmallScreen(context),
        body: ResponsiveWidget(
            largeScreen: GestureDetector(
              onTap: () {
                appStore.dispatch(OverlayAction());
              },
              child: LargeScreen(
                body,
                history: state.navigationState.history,
                userId: state.apiState.authInfoRes.id!,
              ),
            ),
            mediumScreen: MediumScreen(body),
            smallScreen: Text('Test Small screen')),
      ),
    );
  }
}

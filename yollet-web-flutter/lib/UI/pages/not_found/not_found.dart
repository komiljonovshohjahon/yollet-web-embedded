import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LogoBanner(),
        leadingWidth: 256,
        title: DefaultTopbar(),
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0,
      ),
      backgroundColor: ThemeColors.truegray200,
      body: Container(
        padding:
            const EdgeInsets.only(left: 102, right: 172, top: 184, bottom: 184),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/not_found.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Ooops!\n Page not found',
                  textAlign: TextAlign.center,
                  style: ThemeTextRegular.xl4
                      .apply(color: ThemeColors.coolgray800),
                ),
                Text(
                  'Sorry, something went wrong\nWe can’t find the page you’re looking for',
                  textAlign: TextAlign.center,
                  style: ThemeTextRegular.xl2
                      .apply(color: ThemeColors.coolgray500),
                ),
                DefaultButton(
                  text: 'Go back',
                  onPressed: () {
                    appStore.dispatch(NavigateToAction(
                        to: AppRoutes.RouteToRoot, replace: true));
                  },
                  sizeOfButton: ButtonSize.M,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

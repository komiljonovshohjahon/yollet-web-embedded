import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';

import '../../template/base/template.dart';

class LogoBanner extends StatelessWidget {
  double? height;
  bool? noLink;
  LogoBanner({Key? key, this.height = 64, this.noLink = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !noLink!
          ? () {
              appStore.dispatch(NavigateToAction(to: AppRoutes.RouteToRoot));
            }
          : null,
      child: Container(
        height: height,
        color: ThemeColors.orange500,
        child: Center(
          child: Image.asset(
            'assets/icons/1.5x/yollet_logo.png',
            width: 112,
            height: 31,
          ),
        ),
      ),
    );
  }
}

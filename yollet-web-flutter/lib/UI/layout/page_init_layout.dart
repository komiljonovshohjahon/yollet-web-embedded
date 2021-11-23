import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/UI/widgets/popups/show_popup.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';
// //import 'dart:html' as html;

class PageInitLayout extends StatelessWidget {
  Widget? child;
  AppState state;
  PageInitLayout({Key? key, this.child, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingStatus = state.uiState.loadingStatus;
    final message = state.apiState.errorMessage;

    switch (loadingStatus) {
      case LoadingStatus.fetching:
        return const Center(
          child: CircularProgressIndicator(
            color: ThemeColors.orange500,
          ),
        );
      case LoadingStatus.error:
        return Center(
          child: Text('Error Message: ${message}'),
        );
      case LoadingStatus.done:
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: child,
        );
      default:
        return Center(
          child: DefaultButton(
            onPressed: () {
              // html.window.location.reload();
            },
            text: 'refresh_page',
          ),
        );
    }
  }
}

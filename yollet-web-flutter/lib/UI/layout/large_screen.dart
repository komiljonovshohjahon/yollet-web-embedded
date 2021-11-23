import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/utils/common/global_widgets.dart';

class LargeScreen extends StatelessWidget {
  final Widget body;
  final List<String> history;
  final String? userId;

  const LargeScreen(this.body, {required this.history, this.userId});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SideBarVertical(
            secondaryText: userId,
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              DefaultTopbar(),
              Container(
                height: MediaQuery.of(context).size.height - 80,
                margin: const EdgeInsets.only(left: 16, top: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Breadcrumb(
                        routes: history,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedText(
                        text: history.last.contains('/')
                            ? history.last
                                .substring(0, history.last.indexOf('/'))
                            : history.last,
                        textStyle: ThemeTextSemiBold.xl2,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      body,
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

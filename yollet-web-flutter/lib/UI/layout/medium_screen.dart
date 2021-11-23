import 'package:yollet_web/UI/template/base/template.dart';

class MediumScreen extends StatelessWidget {
  final Widget body;

  const MediumScreen(this.body);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              DefaultTopbar(),
              Container(
                height: MediaQuery.of(context).size.height - 96 - 24,

                margin: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Breadcrumb(
                        routes: ['Home', 'StoreList'],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedText(
                        text: 'Ibexlab Store',
                        textStyle: ThemeTextSemiBold.xl2,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      body
                    ],
                  ),
                ),
                // child: Navigator(
                //   key: locator<NavigationService>().navigatorKey,
                //   initialRoute: AppRoutes.rootRoute,
                //   onGenerateRoute: RouteGenerator.generateRoute,
                //   // observers: [AppRouterObserver()],
                // ),
                // child: SingleChildScrollView(
                //   controller: ScrollController(),
                //   child: Column(
                //     children: [
                //       Breadcrumb(routes: [
                //         'Home',
                //         state.navigationState.currentBody.toString()
                //       ]),
                //       const SizedBox(
                //         height: 12,
                //       ),
                //       const SizedText(
                //         text: "Store List",
                //         textStyle: ThemeTextSemiBold.xl2,
                //       ),
                //       const SizedBox(
                //         height: 24,
                //       ),
                //       Navigator(
                //         key: Global.navKey,
                //         initialRoute: AppRoutes.rootRoute,
                //         onGenerateRoute: RouteGenerator.generateRoute,
                //         observers: [AppRouterObserver()],
                //
                //         // navigatorObservers: [AppRouterObserver()],
                //       ),
                //     ],
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

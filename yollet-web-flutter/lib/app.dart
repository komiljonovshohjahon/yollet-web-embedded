import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:routemaster/routemaster.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/mgr/navigation/router.dart';
import 'package:yollet_web/UI/template/theme/theme_data.dart';
import 'package:yollet_web/Utils/common/constants.dart';
import 'package:yollet_web/Utils/localization/localizations.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'mgr/redux/action.dart';
import 'mgr/redux/app_state.dart';
import 'dart:developer' as developer;

RoutemasterDelegate RouteNavigator = RoutemasterDelegate(
    observers: [AppRouterObserver()],
    routesBuilder: (context) {
      return RouteNavigatorLoggedOutDestinations;
    });

class YolletWeb extends StatefulWidget {
  const YolletWeb({Key? key}) : super(key: key);

  @override
  _YolletWebState createState() => _YolletWebState();
}

class _YolletWebState extends State<YolletWeb> {
  Locale? locale;
  bool initActionsLoaded = false;

  @override
  void initState() {
    super.initState();
    developer.log('initState STARTED');

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final res = await _fetchInitActions();
      if (res) {
        setState(() {
          initActionsLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initActionsLoaded) {
      return Container();
    } else {
      return StoreProvider(
        store: appStore,
        child: StoreConnector<AppState, InitState>(
            converter: (store) => store.state.initState,
            onDidChange: (previousViewModel, viewModel) async {
              if (viewModel.loggedIn) {
                setState(() {
                  RouteNavigator = RoutemasterDelegate(
                      observers: [AppRouterObserver()],
                      routesBuilder: (context) {
                        return RouteNavigatorLoggedInDestinations;
                      });
                });
              } else {
                setState(() {
                  RouteNavigator = RoutemasterDelegate(
                      observers: [AppRouterObserver()],
                      routesBuilder: (context) {
                        return RouteNavigatorLoggedOutDestinations;
                      });
                });
              }
            },
            builder: (context, state) {
              return MaterialApp.router(
                routerDelegate: RouteNavigator,
                routeInformationParser: const RoutemasterParser(),
                title: Constants.appTitle,
                debugShowCheckedModeBanner: false,
                theme: MainTheme.mainThemeOrange,
                localizationsDelegates: const [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('ko'), // Korean
                ],
                locale: locale,
              );
            }),
      );
    }
  }

  _fetchInitActions() async {
    await appStore.dispatch(GetDomainListAction());
    setState(() {
      locale = Locale(AppLocalizations.languageCode.toString());
    });

    developer.log('initState FINISHED');
    return true;
  }
}

class AppRouterObserver extends RoutemasterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    developer.log('-----------PUSHED---A---ROUTE-----------');
    developer.log("----- ${route.settings.name} ------");
    developer.log('-----------PUSHED---A---ROUTE-----------');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (RouteNavigator.currentConfiguration!.path ==
        AppRoutes.RouteToStoreList) {}
    developer.log('-----------POPPED--A--ROUTE-----------');
    developer.log('-----------${previousRoute!.settings.name}-----------');
    developer.log('-----------POPPED--A--ROUTE-----------');
  }

  @override
  void didChangeRoute(RouteData routeData, Page page) async {
    super.didChangeRoute(routeData, page);
    if (routeData.path == AppRoutes.RouteToStoreList) {
      await appStore.dispatch(GetStoreListAction());
    } else if (routeData.path == AppRoutes.RouteToApprovedList) {
      await appStore.dispatch(GetApprovalListAction());
    } else if (routeData.path == AppRoutes.RouteToAcquiredList) {
      await appStore.dispatch(GetAcquirementListAction());
    } else if (routeData.path == AppRoutes.RouteToSettlementList) {
      await appStore.dispatch(GetSettlementListAction());
    } else if (routeData.path == AppRoutes.RouteToSettlementDetailsList) {
      await appStore.dispatch(GetSettlementDetailListAction());
    } else if (routeData.path == AppRoutes.RouteToTransferList) {
      await appStore.dispatch(GetTransferListAction());
    }
    appStore.dispatch(UpdateNavigationAction(
      name: routeData.path,
    ));
    developer.log('-----------NEW--ROUTE-----------');
    developer.log("----- ${routeData.path} ------");
    developer.log('-----------NEW--ROUTE-----------');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    developer.log('-----------REPLACED---A---ROUTE-----------');
    developer.log("----- ${newRoute!.settings.name} ------");
    developer.log('-----------REPLACED---A---ROUTE-----------');
  }
}

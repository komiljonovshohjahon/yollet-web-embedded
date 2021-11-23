import 'package:routemaster/routemaster.dart';
import 'package:yollet_web/UI/layout/layout.dart';
import 'package:yollet_web/UI/pages/settlement/transfer_details.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';

final RouteNavigatorLoggedOutDestinations = RouteMap(
  onUnknownRoute: (path) => const Redirect(AppRoutes.RouteToRoot),
  routes: {
    AppRoutes.RouteToRoot: (_) => const MaterialPage(child: LoginPage()),
  },
);

final RouteNavigatorLoggedInDestinations = RouteMap(
    onUnknownRoute: (path) => const MaterialPage(child: NotFoundPage()),
    routes: {
      AppRoutes.RouteToRoot: (route) =>
          const Redirect(AppRoutes.RouteToStoreList),
      AppRoutes.RouteToStoreList: (_) => appStore
                  .state.apiState.authInfoRes.role !=
              ROLE.ROLE_STORE.parseString()
          ? const MaterialPage(child: SiteLayout(StoreListPage()))
          : Redirect(
              "${AppRoutes.RouteToStoreBasic}/${appStore.state.apiState.authInfoRes.storeId}"),
      AppRoutes.RouteToStoreBasic: (route) => MaterialPage(
            child: SiteLayout(
              StoreDetailBasicPage(
                isNewStore: true,
              ),
            ),
          ),
      AppRoutes.RouteToStoreBasic + '/:id': (route) => MaterialPage(
              child: SiteLayout(StoreDetailBasicPage(
            storeId: route.pathParameters['id'],
          ))),
      AppRoutes.RouteToStorePayment: (route) =>
          MaterialPage(child: SiteLayout(StoreDetailPaymentPage())),
      AppRoutes.RouteToStorePayment + "/:id": (route) => MaterialPage(
          child: SiteLayout(
              StoreDetailPaymentPage(storeId: route.pathParameters['id']))),
      AppRoutes.RouteToStoreAccount: (route) =>
          MaterialPage(child: SiteLayout(StoreDetailAccountPage())),
      AppRoutes.RouteToStoreAccount + "/:id": (route) => MaterialPage(
          child: SiteLayout(
              StoreDetailAccountPage(storeId: route.pathParameters['id']))),
      AppRoutes.RouteToApprovedList: (route) =>
          const MaterialPage(child: SiteLayout(ApprovedListPage())),
      AppRoutes.RouteToAcquiredList: (route) =>
          const MaterialPage(child: SiteLayout(AcquiredListPage())),
      AppRoutes.RouteToSettlementList: (route) =>
          const MaterialPage(child: SiteLayout(SettlementListPage())),
      AppRoutes.RouteToSettlementDetailsList: (route) =>
          const MaterialPage(child: SiteLayout(SettlementDetailListPage())),
      AppRoutes.RouteToTransferList: (route) =>
          const MaterialPage(child: SiteLayout(TransferListPage())),
      AppRoutes.RouteToApprovedDetail + '/:id': (route) =>
          MaterialPage(child: SiteLayout(AprrovedDetailPage())),
      AppRoutes.RouteToTransferDetail + '/:id': (route) =>
          MaterialPage(child: SiteLayout(TransferDetailPage())),
    });

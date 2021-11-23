import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/models/sidebar_tab_model.dart';

import '../../UI/template/base/template.dart';

///TODO: ADD ROUTES
class NavigationMenus {
  AppState state;
  bool? homeEnabled = false;
  bool? businessEnabled = false;
  bool? txEnabled = false;
  bool? settlementEnabled = false;

  NavigationMenus({required this.state});

  void enabledIndex() {
    // print('COLLAPSE');
    // print(index);
    // print('COLLAPSE');
    // if (state.uiState.sideBarCollapsedNumber == 0) {
    //   homeEnabled = true;
    // }
    if (state.uiState.sideBarCollapsedNumber == 0) {
      homeEnabled = true;
    }
    if (state.uiState.sideBarCollapsedNumber == 1) {
      businessEnabled = true;
      txEnabled = false;
      settlementEnabled = false;
    }
    if (state.uiState.sideBarCollapsedNumber == 2) {
      txEnabled = true;
      settlementEnabled = false;
      businessEnabled = false;
    }
    if (state.uiState.sideBarCollapsedNumber == 3) {
      settlementEnabled = true;
      txEnabled = false;
      businessEnabled = false;
    }
  }

  List<Widget> sidebarParents(AppState state) {
    enabledIndex();

    Widget stores = SidebarTabParent(
      state: state,
      index: 1,
      icon: HeroIcons.cash,
      name: 'business',
      collapsed: businessEnabled,
      collapseActions: [
        SidebarModel(
            parentNumber: 1,
            name: 'stores',
            route: AppRoutes.RouteToStoreList,
            selectedNumber: 1),
      ],
    );

    Widget txs = SidebarTabParent(
      state: state,
      index: 2,
      icon: HeroIcons.switchHorizontal,
      name: 'transactions',
      collapsed: txEnabled,
      collapseActions: [
        SidebarModel(
            parentNumber: 2,
            name: 'approved_list',
            route: AppRoutes.RouteToApprovedList,
            selectedNumber: 2),
        SidebarModel(
            parentNumber: 2,
            name: 'acquired_list',
            route: AppRoutes.RouteToAcquiredList,
            selectedNumber: 3),
      ],
    );

    Widget settlements = SidebarTabParent(
      state: state,
      index: 3,
      icon: HeroIcons.cubeTransparent,
      name: 'settlement',
      collapsed: settlementEnabled,
      collapseActions: [
        SidebarModel(
            parentNumber: 3,
            name: 'settlement_list',
            route: AppRoutes.RouteToSettlementList,
            selectedNumber: 4),
        SidebarModel(
            parentNumber: 3,
            name: 'settlement_detail_list',
            route: AppRoutes.RouteToSettlementDetailsList,
            selectedNumber: 5),
        SidebarModel(
            parentNumber: 3,
            name: 'transfer_list',
            route: AppRoutes.RouteToTransferList,
            selectedNumber: 6),
      ],
    );

    List<Widget> list = [];
    // list.add(home);
    list.add(stores);
    list.add(txs);
    list.add(settlements);
    return list;
  }
}

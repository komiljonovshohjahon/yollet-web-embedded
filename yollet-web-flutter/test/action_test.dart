import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/mgr/redux/middleware/api_middleware.dart';
import 'package:yollet_web/mgr/redux/middleware/init_middleware.dart';
import 'package:yollet_web/mgr/redux/middleware/navigation_middleware.dart';
import 'package:yollet_web/mgr/redux/middleware/ui_middleware.dart';
import 'package:yollet_web/mgr/redux/reducer.dart';
import 'package:yollet_web/models/serialized_models/approval_list/approval_list_model_res.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';

void main() {
  final appStore = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      NavigationMiddleware(),
      ApiMiddleware(),
      InitMiddleware(),
      UiMiddleware(),
    ],
  );
  test('Test Approve List with Action', () async {
    await appStore.dispatch(
        GetApprovalListAction(approvalListReq: ApprovalListReq(pageSize: 20)));
    if (appStore.state.apiState.approvalListRes is ApprovalListRes) {
      expect(appStore.state.apiState.approvalListRes.approvalList!.isNotEmpty,
          appStore.state.apiState.approvalListRes.approvalList!.isNotEmpty);
    }
  });
  test('Test Store List with Action', () async {
    await appStore
        .dispatch(GetStoreListAction(storeListReq: StoreListReq(pageSize: 20)));
    if (appStore.state.apiState.storeListRes is StoreListRes) {
      expect(appStore.state.apiState.storeListRes.storeList!.length == 20,
          appStore.state.apiState.storeListRes.storeList!.length == 20);
    }
  });
}

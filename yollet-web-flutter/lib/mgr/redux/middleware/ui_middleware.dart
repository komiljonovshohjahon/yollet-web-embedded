import 'package:redux/redux.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';

import '../action.dart';

class UiMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    if (action is InitUIAction) {
      return _initUiAction(store.state.uiState, action, next);
    } else {
      return next(action);
    }
  }

  void _initUiAction(UIState state, InitUIAction action, NextDispatcher next) {
    appStore.dispatch(UpdateUIAction(
      loadingStatus: LoadingStatus.init,
      sideBarCollapsedNumber: 1,
      sideBarChildNumber: 1,
      overlayEntry: false,
      approvedHeadNames: [
        'businessRegistrationNo',
        'paymentMethodCode',
        'approvalDatetime',
        'transactionType',
        'acquirerName',
        'cardNo',
        'approvalNo',
        'approvalAmount',
        'resultCode',
      ],
      acquiredHeadNames: [
        'businessRegistrationNo',
        'paymentMethodCode',
        'approvalDatetime',
        'transactionType',
        'acquirerName',
        'cardNo',
        'approvalAmount',
        'approvalNo',
        'acquirementState',
        'requestDatetime',
        'completeDatetime',
      ],
      storeHeadNames: [
        'businessRegistrationNo',
        'storeName',
        'loginId',
        'creationTime',
        'primaryAddress',
      ],
    ));
  }
}

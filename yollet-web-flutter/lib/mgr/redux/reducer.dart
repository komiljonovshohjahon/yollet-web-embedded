import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/states/api_state.dart';
import 'package:yollet_web/mgr/redux/states/init_state.dart';
import 'package:yollet_web/mgr/redux/states/nav_state.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';
import './app_state.dart';
import 'dart:developer' as developer;

AppState appReducer(AppState state, dynamic action) {
  var newState = state.copyWith(
    navigationState: _navReducer(state.navigationState, action),
    apiState: _apiReducer(state.apiState, action),
    uiState: _uiReducer(state.uiState, action),
    initState: _initReducer(state.initState, action),
  );

  return newState;
}

///
/// Navigation Reducer
///
final _navReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, UpdateNavigationAction>(_updateNavigationState),
]);

NavigationState _updateNavigationState(
    NavigationState state, UpdateNavigationAction action) {
  List<String> history = [];

  final index = appStore.state.uiState.sideBarChildNumber;
  if (index < 2) {
    history.add('business');
  } else if (index > 1 && index < 4) {
    history.add('transactions');
  } else if (index > 3) {
    history.add('settlement');
  }
  if (action.name != '/') {
    final route = action.name!.substring(1);
    history.add(route);
  }
  developer.log('------------HISTORY-------------');

  for (var i = history.length - 1; i >= 0; i--) {
    var name = history[i];
    developer.log('$name');
  }

  developer.log('--------------------------------');

  return state.copyWith(history: history);
}

///
/// Api Reducer
///
final _apiReducer = combineReducers<ApiState>(
    [TypedReducer<ApiState, UpdateApiAction>(_updateApiState)]);

ApiState _updateApiState(ApiState state, UpdateApiAction action) {
  return state.copyWith(
    errorMessage: action.errorMessage,
    approvalListRes: action.approvalListRes ?? state.approvalListRes,
    settlementListRes: action.settlementListRes ?? state.settlementListRes,
    storeListRes: action.storeListRes ?? state.storeListRes,
    acquirementListRes: action.acquirementListRes ?? state.acquirementListRes,
    transferListRes: action.transferList ?? state.transferListRes,
    storePaymentMethodListRes:
        action.storePaymentMethodListRes ?? state.storePaymentMethodListRes,
    settlementDetailListRes:
        action.settlementDetailListRes ?? state.settlementDetailListRes,
    storeAccountListRes:
        action.storeAccountListRes ?? state.storeAccountListRes,
    approvalDetailsRes: action.approvalDetailsRes ?? state.approvalDetailsRes,
    authRes: action.authRes ?? state.authRes,
    paymentMethodGlobalListRes:
        action.paymentMethodGlobalListRes ?? state.paymentMethodGlobalListRes,
    transferDetailsRes: action.transferDetailsRes ?? state.transferDetailsRes,
    domainListRes: action.domainListRes ?? state.domainListRes,
    messageRes: action.messageRes ?? state.messageRes,
    transferMethodGlobalList:
        action.transferMethodGlobalList ?? state.transferMethodGlobalList,
    storeDetailsRes: action.storeDetailsRes ?? state.storeDetailsRes,
    transferSettlementListRes:
        action.transferSettlementListRes ?? state.transferSettlementListRes,
    transferStateListRes:
        action.transferStateListRes ?? state.transferStateListRes,
    authInfoRes: action.authInfoRes ?? state.authInfoRes,
    bankListRes: action.bankListRes ?? state.bankListRes,
    distributorListRes: action.distributorListRes ?? state.distributorListRes,
    agencyListRes: action.agencyListRes ?? state.agencyListRes,
  );
}

///
/// UI Reducer
///
final _uiReducer = combineReducers<UIState>(
    [TypedReducer<UIState, UpdateUIAction>(_updateUIState)]);

UIState _updateUIState(UIState state, UpdateUIAction action) {
  return state.copyWith(
    loadingStatus: action.loadingStatus ?? state.loadingStatus,
    sideBarCollapsedNumber:
        action.sideBarCollapsedNumber ?? state.sideBarCollapsedNumber,
    sideBarChildNumber: action.sideBarChildNumber ?? state.sideBarChildNumber,
    overlayEntry: action.overlayEntry,
    approvedHeadNames: action.approvedHeadNames ?? state.approvedHeadNames,
    acquiredHeadNames: action.acquiredHeadNames ?? state.acquiredHeadNames,
    settlementHeadNames:
        action.settlementHeadNames ?? state.settlementHeadNames,
    settlementDetailHeadNames:
        action.settlementDetailHeadNames ?? state.settlementDetailHeadNames,
    transferHeadNames: action.transferHeadNames ?? state.transferHeadNames,
    storeHeadNames: action.storeHeadNames ?? state.storeHeadNames,
    storeIdList: action.storeIdList ?? state.storeIdList,
  );
}

///
/// Init Reducer
///
final _initReducer = combineReducers<InitState>(
    [TypedReducer<InitState, UpdateInitAction>(_updateInitState)]);

InitState _updateInitState(InitState state, UpdateInitAction action) {
  return state.copyWith(
    loggedIn: action.loggedIn ?? state.loggedIn,
    token: action.token ?? state.token,
    domain: action.domain ?? state.domain,
    sub: action.sub ?? state.sub,
    role: action.role ?? state.role,
    exp: action.exp ?? state.exp,
    iab: action.iab ?? state.iab,
    id: action.id ?? state.id,
    pw: action.pw ?? state.pw,
  );
}

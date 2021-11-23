import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:redux/redux.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/mgr/redux/states/api_state.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';
import 'package:yollet_web/mgr/rest/api_service_client.dart';
import 'package:yollet_web/mgr/rest/endpoint.dart';
import 'package:yollet_web/models/serialized_models/approval_details/approval_details_model_res.dart';
import 'package:yollet_web/models/serialized_models/bank_list/bank_list_model_res.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/models/serialized_models/transfer_state_list/transfer_state_list_model_res.dart';
import 'package:yollet_web/models/serialized_models/user_exists/user_exists_model_req.dart';
import 'package:yollet_web/utils/common/constants.dart';
import 'package:yollet_web/utils/format/get_timestamp.dart';
import 'package:yollet_web/utils/format/jwt_parser.dart';
import 'package:yollet_web/utils/localization/en.dart';
import '../action.dart';

/// Middleware
///   UI => Action1 => Middleware => Action2 => Reducer => Store => UI
///
/// 1. middleware 로 동작하기 위해서는 MiddlewareClass<AppState> 상속 받음
/// 2. call()에서 action 별 분기
/// 3. next(Action2()) 식으로 다음 action 을 호출

class ApiMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    ApiClient _client = ApiClient(
        head: store.state.apiState.authRes.token, jwt_uri: Constants.mainUrl);
    EndpointProvider _endpointProvider = EndpointProvider(_client.init());

    if (action is GetApprovalListAction) {
      return _getApprovalListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetJwtTokenAction) {
      return _getJwtTokenAction(store.state, action, next);
    } else if (action is GetAuthInfoAction) {
      return _getAuthInfoAction(_endpointProvider, store.state, action, next);
    } else if (action is GetStoreListAction) {
      return _getStoreListAction(_endpointProvider, store.state, action, next);
    } else if (action is GetSettlementListAction) {
      return _getSettlementListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetAcquirementListAction) {
      return _getAcquirementListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetTransferListAction) {
      return _getTransferListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStorePaymentMethodListAction) {
      return _getStorePaymentMethodListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetSettlementDetailListAction) {
      return _getSettlementDetailListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStoreAccountListAction) {
      return _getStoreAccountListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetApprovalDeatilsAction) {
      return _getApprovalDetailsAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetHelloTestAction) {
    } else if (action is GetDownloadExcelAction) {
      return _getDownloadExcelAction(
          _endpointProvider, store.state.apiState, action, next);
    } else if (action is GetPaymentMethodGlobalListAction) {
      return _getPaymentMethodGlobalListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetTransferStateListAction) {
      return _getTransferStateListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetTransferMethodGlobalListAction) {
      return _getTransferMethodGlobalListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetTransferDetailAction) {
      return _getTransferDetailsAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetDomainListAction) {
      return _getDomainListAction(_endpointProvider, store.state, action, next);
    } else if (action is GetStoreDetailAction) {
      return _getStoreDetailAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetTransferSettlementListAction) {
      return _getTransferSettlementListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStoreUpdateDetailAction) {
      return _getStoreUpdateDetailAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStoreDeleteAction) {
      return _getStoreDeleteDetailAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetUploadLicenseAction) {
      return _getUploadLicenceAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetDistributorListAction) {
      return _getDistributorListAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetAgencyListAction) {
      return _getAgencyListAction(_endpointProvider, store.state, action, next);
    } else if (action is GetUserExistsAction) {
      return _getUserExistsAction(_endpointProvider, store.state, action, next);
    } else if (action is GetStorePaymentMethodAddAction) {
      return _getStorePaymentMethodAddAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStorePaymentMethodUpdateAction) {
      return _getStorePaymentMethodUpdateAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStorePaymentMethodRemoveAction) {
      return _getStorePaymentMethodRemoveAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStoreAccountMethodAddAction) {
      return _getStoreAccountMethodAddAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStoreAccountMethodUpdateAction) {
      return _getStoreAccountMethodUpdateAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStoreAccountMethodRemoveAction) {
      return _getStoreAccountMethodRemoveAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetStoreCreateAction) {
      return _getStoreCreateAction(
          _endpointProvider, store.state, action, next);
    } else if (action is GetBankListAction) {
      return _getBankListAction(_endpointProvider, store.state, action, next);
    } else {
      return next(action);
    }
  }

  Dio _getClient(
    AppState state, {
    String? token,
    bool isAuth = false,
  }) {
    return ApiClient(
            head:
                state.initState.token.isNotEmpty ? state.initState.token : null,
            jwt_uri: isAuth ? Constants.baseUrlAuth : null)
        .init();
  }

  //Get JWT Token
  Future<AuthRes?> _getJwtTokenAction(
      AppState state, GetJwtTokenAction action, NextDispatcher next) async {
    try {
      final commonMessage = CommonMessageReq(
        targetApi: ApiQueries.queryAuth,
        reqTimestamp: TimeStamp.getTimeStamp,
      );
      final common_content =
          createMessageMap(com: commonMessage, con: action.authReq);

      final res = await _getClient(state, isAuth: true)
          .post(ApiQueries.queryAuth, data: common_content);
      final decoded = json.decode(res.toString());
      final object = AuthRes.fromJson(decoded['content']);

      next(UpdateApiAction(authRes: object));
      final parsedJwt = parseJwt(object.token!);
      next(UpdateInitAction(
        token: object.token,
        sub: parsedJwt['sub'].toString(),
        role: parsedJwt['role'].toString(),
        iab: parsedJwt['iab'].toString(),
        exp: parsedJwt['exp'].toString(),
      ));
      return object;
    } catch (e) {
      return null;
    }
  }

  //Get Auth Info
  Future<AuthInfoRes?> _getAuthInfoAction(EndpointProvider endpointProvider,
      AppState state, GetAuthInfoAction action, NextDispatcher next) async {
    try {
      final response = await _getClient(state).post(
        ApiQueries.queryAuthInfo,
      );

      final decoded = json.decode(response.toString());
      final object = AuthInfoRes.fromJson(decoded['content']);
      next(UpdateApiAction(authInfoRes: object));
      PaymentMethodGlobalListRes? payGlobalRes =
          await appStore.dispatch(GetPaymentMethodGlobalListAction());
      TransferMethodGlobalListRes? trGlobalRes =
          await appStore.dispatch(GetTransferMethodGlobalListAction());
      BankListRes? bankRes = await appStore.dispatch(GetBankListAction());
      if (bankRes != null && payGlobalRes != null && trGlobalRes != null) {
        next(UpdateInitAction(
          role: object.role,
          id: object.id,
          domain: object.domain,
          loggedIn: true,
        ));
        return object;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  //Get Approval list
  Future<ApprovalListRes?> _getApprovalListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetApprovalListAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      dynamic response;
      if (action.approvalListReq == null) {
        response = await _getClient(state).post(ApiQueries.queryApprovalList);
      } else {
        final content = createContentMap(action.approvalListReq);
        response = await _getClient(state)
            .post(ApiQueries.queryApprovalList, data: content);
      }
      final decoded = json.decode(response.toString());
      final object = ApprovalListRes.fromJson(decoded['content']);
      next(UpdateApiAction(approvalListRes: object));
      toggleLoading(LoadingStatus.done);
      return object;
    } catch (e) {
      toggleLoading(LoadingStatus.error);

      return null;
    }
  }

  //Get Approval detail list
  Future<StoreDetailsRes?> _getStoreDetailAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStoreDetailAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      final content = createContentMap(action.storeDetailsReq);

      final response = await _getClient(state)
          .post(ApiQueries.queryStoreDetails, data: content);
      final decoded = json.decode(response.toString());
      final object = StoreDetailsRes.fromJson(decoded['content']);
      next(UpdateApiAction(storeDetailsRes: object));
      toggleLoading(LoadingStatus.done);
      return object;
    } catch (e) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  //Get Store list
  Future<StoreListRes?> _getStoreListAction(EndpointProvider endpointProvider,
      AppState state, GetStoreListAction action, NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      dynamic response;
      if (action.storeListReq == null) {
        response = await _getClient(state).post(
          ApiQueries.queryStoreList,
        );
      } else {
        final content = createContentMap(action.storeListReq);
        response = await _getClient(state)
            .post(ApiQueries.queryStoreList, data: content);
      }
      final decoded = json.decode(response.toString());
      final object = StoreListRes.fromJson(decoded['content']);
      toggleLoading(LoadingStatus.done);
      next(UpdateApiAction(storeListRes: object));
      return object;
    } catch (ex) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  //Get Settlement list
  Future<SettlementListRes?> _getSettlementListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetSettlementListAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      dynamic response;
      if (action.settlementListReq == null) {
        response = await _getClient(state).post(ApiQueries.querySettlementList);
      } else {
        final content = createContentMap(action.settlementListReq);
        response = await _getClient(state).post(
          ApiQueries.querySettlementList,
          data: content.toString(),
        );
      }
      final decoded = json.decode(response.toString());
      final object = SettlementListRes.fromJson(decoded['content']);
      next(UpdateApiAction(settlementListRes: object));
      toggleLoading(LoadingStatus.done);

      return object;
    } catch (ex) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  //Get Acquirement list
  Future<AcquirementListRes?> _getAcquirementListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetAcquirementListAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      dynamic response;
      if (action.acquirementListReq == null) {
        response =
            await _getClient(state).post(ApiQueries.queryAcquirementList);
      } else {
        final content = createContentMap(action.acquirementListReq);
        response = await _getClient(state)
            .post(ApiQueries.queryAcquirementList, data: content);
      }
      final decoded = json.decode(response.toString());
      final object = AcquirementListRes.fromJson(decoded['content']);
      next(UpdateApiAction(acquirementListRes: object));
      toggleLoading(LoadingStatus.done);
      return object;
    } catch (ex) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  Future<TransferListRes?> _getTransferListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetTransferListAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      dynamic response;
      if (action.transferListReq == null) {
        response = await _getClient(state).post(ApiQueries.queryTransferList);
      } else {
        final content = createContentMap(action.transferListReq);
        response = await _getClient(state)
            .post(ApiQueries.queryTransferList, data: content);
      }
      final decoded = json.decode(response.toString());
      final object = TransferListRes.fromJson(decoded['content']);
      next(UpdateApiAction(transferList: object));
      toggleLoading(LoadingStatus.done);
      return object;
    } catch (ex) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  Future<StorePaymentMethodListRes?> _getStorePaymentMethodListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStorePaymentMethodListAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      final content = createContentMap(action.storePaymentMethodListReq);
      final response = await _getClient(state).post(
        ApiQueries.queryStorePaymentMethodList,
        data: content,
      );
      final decoded = json.decode(response.toString());
      final object = StorePaymentMethodListRes(methodList: decoded['content']);
      next(UpdateApiAction(storePaymentMethodListRes: object));
      toggleLoading(LoadingStatus.done);
      return object;
    } catch (ex) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  Future<SettlementDetailListRes?> _getSettlementDetailListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetSettlementDetailListAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      dynamic response;
      if (action.settlementDetailListReq == null) {
        response =
            await _getClient(state).post(ApiQueries.querySettlementDetailList);
      } else {
        final content = createContentMap(action.settlementDetailListReq);
        response = await _getClient(state)
            .post(ApiQueries.querySettlementDetailList, data: content);
      }
      final decoded = json.decode(response.toString());
      final object = SettlementDetailListRes.fromJson(decoded['content']);
      next(UpdateApiAction(settlementDetailListRes: object));
      toggleLoading(LoadingStatus.done);
      return object;
    } catch (ex) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  Future<StoreAccountListRes?> _getStoreAccountListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStoreAccountListAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      final content = createContentMap(action.storeAccountListReq);
      final response = await _getClient(state).post(
        ApiQueries.queryStoreAccountList,
        data: content,
      );
      final decoded = json.decode(response.toString());
      final object = StoreAccountListRes(accountList: decoded['content']);
      toggleLoading(LoadingStatus.done);

      return object;
    } catch (ex) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  Future _getDownloadExcelAction(
      EndpointProvider endpointProvider,
      ApiState state,
      GetDownloadExcelAction action,
      NextDispatcher next) async {
    String routeName = DownloadState.APPROVED.parseString();
    // Create an excel format object
    Excel excel = Excel.createExcel();
    // Hold an object from the excel object
    Sheet sheetObject = excel['Sheet1'];
    final keys = [];

    //Save the file
    switch (action.downloadState) {
      case DownloadState.APPROVED:
        ApprovalListRes? approvalList =
            await endpointProvider.epGetApprovalList(

                /// Pass -1 for pageSize in order to get all Items in the list.
                req: ApprovalListReq(pageSize: -1));

        // Add keys to the excel object to the first row
        if (approvalList != null) {
          for (var i in approvalList.approvalList![0].keys) {
            if (EnglishLocale.EN.keys.contains(i)) {
              keys.add(EnglishLocale.EN[i]);
            }
          }

          sheetObject.insertRowIterables(keys, 0);

          // Add values to the excel object
          for (var i = 0; i < approvalList.approvalList!.length; i++) {
            List<String> data = [];
            for (var j in approvalList.approvalList![i].values) {
              data.add(j.toString());
            }
            sheetObject.insertRowIterables(data, i + 1);
          }
          excel.save(fileName: '$routeName.xlsx');

          return approvalList;
        }
        return approvalList;
      case DownloadState.ACQUIRED:
        AcquirementListRes? acquiredList = await endpointProvider
            .epGetAcquirementList(req: AcquirementListReq(pageSize: -1));

        routeName = DownloadState.ACQUIRED.parseString();

        if (acquiredList != null) {
          // Add keys to the excel object to the first row
          for (var i in acquiredList.acquirementList![0].keys) {
            if (EnglishLocale.EN.keys.contains(i)) {
              keys.add(EnglishLocale.EN[i]);
            }
          }
          sheetObject.insertRowIterables(keys, 0);

          // Add values to the excel object
          for (var i = 0; i < acquiredList.acquirementList!.length; i++) {
            List<String> data = [];
            for (var j in acquiredList.acquirementList![i].values) {
              data.add(j.toString());
            }
            sheetObject.insertRowIterables(data, i + 1);
          }
          excel.save(fileName: '$routeName.xlsx');
          return acquiredList;
        }
        return acquiredList;
      case DownloadState.SETTLEMENT:
        SettlementListRes? settlementList =
            await endpointProvider.epGetSettlementList(

                /// Pass -1 for pageSize in order to get all Items in the list.
                req: SettlementListReq(pageSize: -1));

        routeName = DownloadState.SETTLEMENT.parseString();

        if (settlementList != null) {
          // Add keys to the excel object to the first row
          for (var i in settlementList.settlementList![0].keys) {
            if (EnglishLocale.EN.keys.contains(i)) {
              keys.add(EnglishLocale.EN[i]);
            }
          }
          sheetObject.insertRowIterables(keys, 0);

          // Add values to the excel object
          for (var i = 0; i < settlementList.settlementList!.length; i++) {
            List<String> data = [];
            for (var j in settlementList.settlementList![i].values) {
              data.add(j.toString());
            }
            sheetObject.insertRowIterables(data, i + 1);
          }
          excel.save(fileName: '$routeName.xlsx');
          return settlementList;
        }
        return settlementList;
      case DownloadState.SETTLEMENTDETAIL:
        SettlementDetailListRes? settlementDetailList =
            await endpointProvider.epGetSettlementDetailList(

                /// Pass -1 for pageSize in order to get all Items in the list.
                req: SettlementDetailListReq(pageSize: -1));
        routeName = DownloadState.SETTLEMENTDETAIL.parseString();
        if (settlementDetailList != null) {
          // Add keys to the excel object to the first row
          for (var i in settlementDetailList.transactionList![0].keys) {
            if (EnglishLocale.EN.keys.contains(i)) {
              keys.add(EnglishLocale.EN[i]);
            }
          }
          sheetObject.insertRowIterables(keys, 0);

          // Add values to the excel object
          for (var i = 0;
              i < settlementDetailList.transactionList!.length;
              i++) {
            List<String> data = [];
            for (var j in settlementDetailList.transactionList![i].values) {
              data.add(j.toString());
            }
            sheetObject.insertRowIterables(data, i + 1);
          }
          excel.save(fileName: '$routeName.xlsx');
          return settlementDetailList;
        }
        return settlementDetailList;
      case DownloadState.TRANSFER:
        TransferListRes? transferList =
            await endpointProvider.epGetTransferList(

                /// Pass -1 for pageSize in order to get all Items in the list.
                req: TransferListReq(pageSize: -1));

        routeName = DownloadState.TRANSFER.parseString();
        if (transferList != null) {
          // Add keys to the excel object to the first row
          for (var i in transferList.transferList![0].keys) {
            if (EnglishLocale.EN.keys.contains(i)) {
              keys.add(EnglishLocale.EN[i]);
            }
          }
          sheetObject.insertRowIterables(keys, 0);

          // Add values to the excel object
          for (var i = 0; i < transferList.transferList!.length; i++) {
            List<String> data = [];
            for (var j in transferList.transferList![i].values) {
              data.add(j.toString());
            }
            sheetObject.insertRowIterables(data, i + 1);
          }
          excel.save(fileName: '$routeName.xlsx');
          return transferList;
        }
        return transferList;
      case DownloadState.STORE:
        break;
    }
  }

  //Get payment method global detail list
  Future<PaymentMethodGlobalListRes?> _getPaymentMethodGlobalListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetPaymentMethodGlobalListAction action,
      NextDispatcher next) async {
    try {
      final response = await _getClient(state).post(
        ApiQueries.queryPaymentMethodGlobal,
      );
      final decoded = json.decode(response.toString());
      final object =
          PaymentMethodGlobalListRes(paymentMethodList: decoded['content']);
      next(UpdateApiAction(paymentMethodGlobalListRes: object));
      return object;
    } catch (e) {
      return null;
    }
  }

  //Get Transfer method global list
  Future<TransferMethodGlobalListRes?> _getTransferMethodGlobalListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetTransferMethodGlobalListAction action,
      NextDispatcher next) async {
    try {
      final response = await _getClient(state).get(
        ApiQueries.queryTransferMethodGlobal,
      );
      final decoded = json.decode(response.toString());

      final object =
          TransferMethodGlobalListRes(transferMethodList: decoded['content']);
      next(UpdateApiAction(transferMethodGlobalList: object));
      return object;
    } catch (e) {
      return null;
    }
  }

  //Get Transfer state list
  Future<TransferStateListRes?> _getTransferStateListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetTransferStateListAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      final content = createContentMap(action.transferStateListReq);

      final response = await _getClient(state).post(
        ApiQueries.queryTransferStateList,
        data: content.toString(),
      );
      final decoded = json.decode(response.toString());
      final object = TransferStateListRes(stateList: decoded['content']);
      toggleLoading(LoadingStatus.done);
      next(UpdateApiAction(transferStateListRes: object));
      return object;
    } catch (ex) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  //Get approval detail action
  Future<ApprovalDetailsRes?> _getApprovalDetailsAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetApprovalDeatilsAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    try {
      final content = createContentMap(action.approvalDetailsReq);
      final response = await _getClient(state)
          .post(ApiQueries.queryApprovalDetails, data: content);
      final decoded = json.decode(response.toString());
      final object = ApprovalDetailsRes.fromJson(decoded['content']);
      next(UpdateApiAction(approvalDetailsRes: object));
      toggleLoading(LoadingStatus.done);
      return object;
    } catch (ex) {
      toggleLoading(LoadingStatus.error);
      return null;
    }
  }

  void _getTransferDetailsAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetTransferDetailAction action,
      NextDispatcher next) async {
    UIState uiState = state.uiState;
    toggleLoading(LoadingStatus.fetching);

    final transferDetails =
        await endpointProvider.epGetTransferDetails(action.transferDetailsReq!);

    if (transferDetails is TransferDetailsRes) {
      toggleLoading(LoadingStatus.done);
      next(UpdateApiAction(transferDetailsRes: transferDetails));
    } else {
      toggleLoading(LoadingStatus.error);
      next(UpdateApiAction(messageRes: transferDetails));
      return transferDetails;
    }
  }

  Future<DomainListRes?> _getDomainListAction(EndpointProvider endpointProvider,
      AppState state, GetDomainListAction action, NextDispatcher next) async {
    try {
      final response = await _getClient(state).post(
        ApiQueries.queryDomainList,
      );
      final decoded = json.decode(response.toString());
      final object = DomainListRes(domainList: decoded['content']);
      next(UpdateApiAction(domainListRes: object));
      return object;
    } catch (e) {
      return null;
    }
  }

  toggleLoading(LoadingStatus status) {
    appStore.dispatch(UpdateUIAction(loadingStatus: status));
  }

  //Get Transfer settlement list
  void _getTransferSettlementListAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetTransferSettlementListAction action,
      NextDispatcher next) async {
    UIState uiState = state.uiState;
    toggleLoading(LoadingStatus.fetching);

    final transferSettlementList = await endpointProvider
        .epGetTransferSettlementList(action.transferSettlementListReq!);
    if (transferSettlementList is TransferSettlementListRes) {
      toggleLoading(LoadingStatus.done);

      next(UpdateApiAction(transferSettlementListRes: transferSettlementList));
    } else {
      toggleLoading(LoadingStatus.error);
      next(UpdateApiAction(messageRes: transferSettlementList));
      return transferSettlementList;
    }
  }

  //Get Store Update detail
  Future<CommonMessageRes> _getStoreUpdateDetailAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStoreUpdateDetailAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    final updateRes =
        await endpointProvider.epGetUpdateStoreDetail(action.storeUpdateReq!);
    toggleLoading(LoadingStatus.done);
    return updateRes;
  }

  //Get Store Delete detail
  Future<CommonMessageRes> _getStoreDeleteDetailAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStoreDeleteAction action,
      NextDispatcher next) async {
    CommonMessageRes updateRes =
        await endpointProvider.epGetDeleteStore(action.storeDeleteReq!);
    return updateRes;
  }

  //Get Upload License detail
  _getUploadLicenceAction(EndpointProvider endpointProvider, AppState state,
      GetUploadLicenseAction action, NextDispatcher next) async {
    ///Check result file
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
          action.result!.files.first.bytes!.toList(),
          filename:
              '${state.apiState.storeDetailsRes.storeName!.replaceAll(" ", '')}_license.${action.result!.files.first.extension}'),
    });

    ///Add store request
    MapEntry<String, String> requestEntry = MapEntry(
        "request", "{\"content\": {\"storeId\": \"${action.storeId}\"}}");

    formData.fields.add(requestEntry);

    ///Call API
    final updateRes = await endpointProvider.epGetUploadLicence(formData);
    return updateRes;
  }

  //Get Distributor List Middleware
  _getDistributorListAction(EndpointProvider endpointProvider, AppState state,
      GetDistributorListAction action, NextDispatcher next) async {
    UIState uiState = state.uiState;
    toggleLoading(LoadingStatus.fetching);

    final distributorList = await endpointProvider.epGetDistributorList();
    if (distributorList is DistributorListRes) {
      toggleLoading(LoadingStatus.done);

      next(UpdateApiAction(distributorListRes: distributorList));
    } else {
      toggleLoading(LoadingStatus.error);
      next(UpdateApiAction(messageRes: distributorList));
      return distributorList;
    }
  }

  //Get Agency List Middleware
  void _getAgencyListAction(EndpointProvider endpointProvider, AppState state,
      GetAgencyListAction action, NextDispatcher next) async {
    UIState uiState = state.uiState;
    toggleLoading(LoadingStatus.fetching);

    final agencyList =
        await endpointProvider.epGetAgencyList(action.agencyListReq!);
    if (agencyList is AgencyListRes) {
      toggleLoading(LoadingStatus.done);

      next(UpdateApiAction(agencyListRes: agencyList));
    } else {
      toggleLoading(LoadingStatus.error);
      next(UpdateApiAction(messageRes: agencyList));
    }
  }

  //Get Bank List Middleware
  Future<BankListRes?> _getBankListAction(EndpointProvider endpointProvider,
      AppState state, GetBankListAction action, NextDispatcher next) async {
    try {
      final response = await _getClient(state).post(
        ApiQueries.queryBankList,
      );

      final decoded = json.decode(response.toString());
      final object = BankListRes(bankList: decoded['content']);
      next(UpdateApiAction(bankListRes: object));

      return object;
    } catch (e) {
      return null;
    }
  }

  //Get User exists middleware
  Future _getUserExistsAction(EndpointProvider endpointProvider, AppState state,
      GetUserExistsAction action, NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    final userExists =
        await endpointProvider.epGetUserExists(action.userExistsReq!);

    toggleLoading(LoadingStatus.done);
    return userExists.resCode == "200";
  }

  //Get Store Payment Method Add Middleware
  Future _getStorePaymentMethodAddAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStorePaymentMethodAddAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);

    final storePaymentMethodAdd = await endpointProvider
        .epGetStorePaymentMethodAdd(action.storePaymentMethodAddReq!);
    toggleLoading(LoadingStatus.done);
    return storePaymentMethodAdd.resCode == "200";
  }

  //Get Store Payment Method Update Middleware
  Future _getStorePaymentMethodUpdateAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStorePaymentMethodUpdateAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);

    final storePaymentMethodUpdate = await endpointProvider
        .epGetStorePaymentMethodUpdate(action.storePaymentMethodUpdateReq!);
    toggleLoading(LoadingStatus.done);
    return storePaymentMethodUpdate.resCode == "200";
  }

  //Get Store Payment Method Remove Middleware
  Future _getStorePaymentMethodRemoveAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStorePaymentMethodRemoveAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);

    final storePaymentMethodUpdate = await endpointProvider
        .epGetStorePaymentMethodRemove(action.storePaymentMethodRemoveReq!);
    toggleLoading(LoadingStatus.done);
    return storePaymentMethodUpdate.resCode == "200";
  }

  //Get Store Account Add Middleware
  Future _getStoreAccountMethodAddAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStoreAccountMethodAddAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);

    final storeAccountMethodAdd = await endpointProvider
        .epGetStoreAccountAdd(action.storeAccountMethodAddReq!);
    toggleLoading(LoadingStatus.done);
    return storeAccountMethodAdd.resCode == "200";
  }

  //Get Store Account Update Middleware
  Future _getStoreAccountMethodUpdateAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStoreAccountMethodUpdateAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);

    final storeAccountMethodUpdate = await endpointProvider
        .epGetStoreAccountUpdate(action.storeAccountMethodUpdateReq!);
    toggleLoading(LoadingStatus.done);
    return storeAccountMethodUpdate.resCode == "200";
  }

  //Get Store Account Remove Middleware
  Future _getStoreAccountMethodRemoveAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStoreAccountMethodRemoveAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);

    final storeAccountMethodUpdate = await endpointProvider
        .epGetStoreAccountRemove(action.storeAccountMethodRemoveReq!);
    toggleLoading(LoadingStatus.done);
    return storeAccountMethodUpdate.resCode == "200";
  }

  //Get Store Create Middleware
  Future<CommonMessageRes> _getStoreCreateAction(
      EndpointProvider endpointProvider,
      AppState state,
      GetStoreCreateAction action,
      NextDispatcher next) async {
    toggleLoading(LoadingStatus.fetching);
    CommonMessageRes userExists = await endpointProvider
        .epGetUserExists(UserExistsReq(id: action.storeCreateReq.id));
    if (userExists.resCode != '200') {
      CommonMessageRes storeAccountMethodUpdate =
          await endpointProvider.epGetStoreCreate(action.storeCreateReq);
      toggleLoading(LoadingStatus.done);
      return storeAccountMethodUpdate;
    } else {
      toggleLoading(LoadingStatus.done);
      return CommonMessageRes(
          resCode: '400', resMessage: userExists.resMessage);
    }
  }
}

//Converters
createContentMap(content) {
  Map<String, dynamic> object = content.toJson();
  final keys = object.keys.toList();
  for (var key in keys) {
    if (object[key] == null) {
      object.remove(key);
    }
    if (object[key] is String && object[key].isEmpty) {
      object.remove(key);
    }
  }
  return '{"content": ${jsonEncode(object)}}'.toString();
}

createCommonMap(common) {
  final object = common.toJson();
  return '{"common": ${jsonEncode(object)}}'.toString();
}

createMessageMap({com, con}) {
  final common = com.toJson();
  final content = con.toJson();

  return '{"common": ${jsonEncode(common)}, "content":  ${jsonEncode(content)}}'
      .toString();
}

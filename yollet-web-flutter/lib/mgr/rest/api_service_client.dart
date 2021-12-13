import "package:dio/dio.dart";
import 'package:flutter/foundation.dart';

import 'package:yollet_web/mgr/rest/interceptors/api_interceptor.dart';
import 'package:yollet_web/mgr/rest/interceptors/logging_interceptor.dart';
import 'package:yollet_web/Utils/common/constants.dart';

class ApiQueries {
  static const String queryHello = "/admin/hello";
  static const String queryUploadLicense = "/admin/store/license/upload";
  static const String queryDomainList = "/admin/domain/list";
  static const String queryAuth = "/auth";
  static const String queryAuthInfo = "/admin/auth_info";
  static const String queryStoreList = "/admin/store/list";
  static const String queryStoreDetails = "/admin/store/details";
  static const String queryStorePaymentMethodList =
      "/admin/store/payment_method/list";
  static const String queryStoreAccountList = "/admin/store/account/list";
  static const String queryApprovalList = "/admin/approval/list";
  static const String queryApprovalDetails = "/admin/approval/details";
  static const String querySettlementList = "/admin/settlement/list";
  static const String querySettlementDetailList = "/admin/settlement/details";
  static const String queryAcquirementList = "/admin/acquirement/list";
  static const String queryTransferList = "/admin/transfer/list";
  static const String queryTransferDetail = "/admin/transfer/details";
  static const String queryTransferStateList = "/admin/transfer/state/list";
  static const String queryTransferSettlementList =
      "/admin/transfer/settlement/list";
  static const String queryPaymentMethodGlobal = "/admin/payment_method/list";
  static const String queryTransferMethodGlobal = "/admin/transfer_method/list";
  static const String queryStoreUpdate = "/admin/store/update";
  static const String queryStoreDelete = "/admin/store/delete";
  static const String queryDistributorList = "/admin/distributor/list";
  static const String queryAgencyList = "/admin/agency/list";
  static const String queryUserExists = "/admin/user/exists";
  static const String queryStorePaymentMethodAdd =
      "/admin/store/payment_method/add";
  static const String queryStorePaymentMethodUpdate =
      "/admin/store/payment_method/update";
  static const String queryStorePaymentMethodRemove =
      "/admin/store/payment_method/remove";
  static const String queryStoreAccountAdd = "/admin/store/account/add";
  static const String queryStoreAccountUpdate = "/admin/store/account/update";
  static const String queryStoreAccountRemove = "/admin/store/account/remove";
  static const String queryStoreCreate = "/admin/store/create";
  static const String queryBankList = "/admin/bank/list";
}

class ApiResponseResult {
  static const Map resOk = {
    'code': 200,
    "message": 'Ok response!'
  }; //Message: Ok response!
  static const Map resBadRequest = {
    'code': 400,
    "message": 'Bad request!'
  }; //Message: Bad request!
  static const Map resNotFound = {
    'code': 404,
    "message": 'Not Found!'
  }; //Message: Not Found!
  static const Map resInternalServerError = {
    'code': 500,
    "message": 'Internal server error!'
  }; //Message: Internal server error!
  static const Map resServiceUnavailable = {
    'code': 503,
    "message": 'Service unavailable!'
  }; //Message: Service unavailable!

  static const List resList = [
    resOk,
    resNotFound,
    resBadRequest,
    resInternalServerError,
    resServiceUnavailable
  ];
}

class ApiClient {
  String? jwt_uri;
  String? head;

  ApiClient({this.jwt_uri, this.head});

  String get uri {
    return jwt_uri ?? Constants.mainUrl;
  }

  Map<String, dynamic>? get headers {
    if (head != null) {
      return {
        "Authorization": "Bearer $head",
        "Content-Type": "application/json"
      };
    }
    return {"Content-Type": "application/json"};
  }

  Dio init() {
    Dio _dio = Dio();
    _dio.interceptors.add(ApiInterceptor());
    if (!kReleaseMode) _dio.interceptors.add(LoggingInterceptor());
    BaseOptions options = BaseOptions(
      baseUrl: uri,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      setRequestContentTypeWhenNoPayload: true,
      headers: headers,
    );
    _dio.options = options;
    return _dio;
  }
}

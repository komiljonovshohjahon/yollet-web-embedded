import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yollet_web/mgr/rest/api_service_client.dart';
import 'package:yollet_web/models/serialized_models/approval_details/approval_details_model_req.dart';
import 'package:yollet_web/models/serialized_models/approval_details/approval_details_model_res.dart';
import 'package:yollet_web/models/serialized_models/auth/auth_model_req.dart';
import 'package:yollet_web/models/serialized_models/auth_info/auth_info_model_res.dart';
import 'package:yollet_web/models/serialized_models/bank_list/bank_list_model_res.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/models/serialized_models/transfer_state_list/transfer_state_list_model_req.dart';
import 'package:yollet_web/models/serialized_models/transfer_state_list/transfer_state_list_model_res.dart';
import 'package:yollet_web/models/serialized_models/user_exists/user_exists_model_req.dart';
import 'package:yollet_web/utils/format/get_timestamp.dart';
import 'dart:html' as html;

class EndpointProvider {
  Dio _client;

  EndpointProvider(this._client);

  //Get Hello Test
  Future helloTest() async {
    try {
      final response = await _client.post(
        ApiQueries.queryHello,
      );

      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      // return ApiResponseResult.resNotFound;
    }
  }

  //Get Upload licence
  Future<CommonMessageRes> epGetUploadLicence(FormData formData) async {
    try {
      final response = await _client.post(
        ApiQueries.queryUploadLicense,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Auth
  Future epGetJwtToken(AuthReq req) async {
    try {
      final commonMessage = CommonMessageReq(
        targetApi: ApiQueries.queryAuth,
        reqTimestamp: TimeStamp.getTimeStamp,
      );

      final common_content = createMessageMap(com: commonMessage, con: req);

      final response = await _client.post(
        ApiQueries.queryAuth,
        data: common_content,
      );
      final decoded = json.decode(response.toString());
      final object = AuthRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Auth info
  Future epGetAuthInfo() async {
    try {
      final response = await _client.post(
        ApiQueries.queryAuthInfo,
      );
      final decoded = json.decode(response.toString());
      final object = AuthInfoRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

//Get payment method global list
  Future epGetPaymentMethodGlobalList() async {
    try {
      final response = await _client.post(
        ApiQueries.queryPaymentMethodGlobal,
      );
      final decoded = json.decode(response.toString());
      final object =
          PaymentMethodGlobalListRes(paymentMethodList: decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Domain List
  Future epGetDomainList() async {
    try {
      final response = await _client.post(
        ApiQueries.queryDomainList,
      );
      final decoded = json.decode(response.toString());
      final object = DomainListRes(domainList: decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Transfer method global list
  Future epGetTransferMethodGlobalList() async {
    try {
      final response = await _client.get(
        ApiQueries.queryTransferMethodGlobal,
      );
      final decoded = json.decode(response.toString());

      final object =
          TransferMethodGlobalListRes(transferMethodList: decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Approval list
  Future epGetApprovalList({ApprovalListReq? req}) async {
    try {
      dynamic response;
      if (req == null) {
        response = await _client.post(
          ApiQueries.queryApprovalList,
        );
      } else {
        final content = createContentMap(req);
        response = await _client.post(
          ApiQueries.queryApprovalList,
          data: content,
        );
      }

      final decoded = json.decode(response.toString());
      final object = ApprovalListRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get approval details
  Future epGetApprovalDetails(ApprovalDetailsReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryApprovalDetails,
        data: content,
      );
      final decoded = json.decode(response.toString());
      final object = ApprovalDetailsRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Store list
  Future epGetStoreList({StoreListReq? req}) async {
    try {
      dynamic response;
      if (req == null) {
        response = await _client.post(
          ApiQueries.queryStoreList,
        );
      } else {
        final content = createContentMap(req);
        response = await _client.post(
          ApiQueries.queryStoreList,
          data: content,
        );
      }
      final decoded = json.decode(response.toString());
      final object = StoreListRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Update Store detail
  Future<CommonMessageRes> epGetUpdateStoreDetail(StoreUpdateReq req) async {
    try {
      final content = createContentMap(req);
      final response = await _client.post(
        ApiQueries.queryStoreUpdate,
        data: content,
      );
      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Store create
  Future<CommonMessageRes> epGetStoreCreate(StoreCreateReq req) async {
    try {
      final content = createContentMap(req);
      final response = await _client.post(
        ApiQueries.queryStoreCreate,
        data: content,
      );
      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Delete Store detail
  Future epGetDeleteStore(StoreDeleteReq req) async {
    try {
      final content = createContentMap(req);
      final response = await _client.post(
        ApiQueries.queryStoreDelete,
        data: content,
      );
      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Settlement list
  Future epGetSettlementList({SettlementListReq? req}) async {
    try {
      dynamic response;
      if (req == null) {
        response = await _client.post(
          ApiQueries.querySettlementList,
        );
      } else {
        final content = createContentMap(req);
        response = await _client.post(
          ApiQueries.querySettlementList,
          data: content.toString(),
        );
      }
      final decoded = json.decode(response.toString());
      final object = SettlementListRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Acquirement list
  Future epGetAcquirementList({AcquirementListReq? req}) async {
    try {
      dynamic response;
      if (req == null) {
        response = await _client.post(
          ApiQueries.queryAcquirementList,
        );
      } else {
        final content = createContentMap(req);
        response = await _client.post(
          ApiQueries.queryAcquirementList,
          data: content.toString(),
        );
      }

      final decoded = json.decode(response.toString());
      final object = AcquirementListRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

//Get transferList
  Future epGetTransferList({TransferListReq? req}) async {
    try {
      dynamic response;
      if (req == null) {
        response = await _client.post(
          ApiQueries.queryTransferList,
        );
      } else {
        final content = createContentMap(req);
        response = await _client.post(
          ApiQueries.queryTransferList,
          data: content.toString(),
        );
      }
      final decoded = json.decode(response.toString());
      final object = TransferListRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Transfer Details
  Future epGetTransferDetails(TransferDetailsReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryTransferDetail,
        data: content,
      );

      final decoded = json.decode(response.toString());
      final object = TransferDetailsRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get settlementdetailList
  Future epGetSettlementDetailList({SettlementDetailListReq? req}) async {
    try {
      dynamic response;
      if (req == null) {
        response = await _client.post(
          ApiQueries.querySettlementDetailList,
        );
      } else {
        final content = createContentMap(req);
        response = await _client.post(
          ApiQueries.querySettlementDetailList,
          data: content.toString(),
        );
      }
      final decoded = json.decode(response.toString());
      final object = SettlementDetailListRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get store payment list
  Future epGetStorePaymentMethodList(StorePaymentMethodListReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryStorePaymentMethodList,
        data: content,
      );

      final decoded = json.decode(response.toString());

      final object = StorePaymentMethodListRes(methodList: decoded['content']);

      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get store account list
  Future epGetStoreAccountList(StoreAccountListReq req) async {
    try {
      final content = createContentMap(req);
      final response = await _client.post(
        ApiQueries.queryStoreAccountList,
        data: content,
      );
      final decoded = json.decode(response.toString());
      final object = StoreAccountListRes(accountList: decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get store details
  Future epGetStoreDetails(StoreDetailsReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryStoreDetails,
        data: content.toString(),
      );
      final decoded = json.decode(response.toString());
      final object = StoreDetailsRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Transfer setllement list details
  Future epGetTransferSettlementList(TransferSettlementListReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryTransferSettlementList,
        data: content.toString(),
      );
      final decoded = json.decode(response.toString());
      final object =
          TransferSettlementListRes(settlementList: decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Transfer State list details
  Future epGetTransferStateList(TransferStateListReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryTransferStateList,
        data: content.toString(),
      );
      final decoded = json.decode(response.toString());
      final object = TransferStateListRes(stateList: decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Distributor List
  Future epGetDistributorList() async {
    try {
      final response = await _client.post(
        ApiQueries.queryDistributorList,
      );

      final decoded = json.decode(response.toString());
      final object = DistributorListRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Agency List
  Future epGetAgencyList(AgencyListReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryAgencyList,
        data: content,
      );

      final decoded = json.decode(response.toString());
      final object = AgencyListRes.fromJson(decoded['content']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get User Exists
  Future epGetUserExists(UserExistsReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryUserExists,
        data: content,
      );

      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Store payment method add
  Future epGetStorePaymentMethodAdd(StorePaymentMethodAddReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryStorePaymentMethodAdd,
        data: content,
      );

      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Store payment method update
  Future epGetStorePaymentMethodUpdate(StorePaymentMethodUpdateReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryStorePaymentMethodUpdate,
        data: content,
      );

      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Store payment method Remove
  Future epGetStorePaymentMethodRemove(StorePaymentMethodRemoveReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryStorePaymentMethodRemove,
        data: content,
      );

      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Store Account add
  Future epGetStoreAccountAdd(StoreAccountMethodAddReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryStoreAccountAdd,
        data: content,
      );

      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Store Account update
  Future epGetStoreAccountUpdate(StoreAccountMethodUpdateReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryStoreAccountUpdate,
        data: content,
      );

      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Store Account Remove
  Future epGetStoreAccountRemove(StoreAccountMethodRemoveReq req) async {
    try {
      final content = createContentMap(req);

      final response = await _client.post(
        ApiQueries.queryStoreAccountRemove,
        data: content,
      );

      final decoded = json.decode(response.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
    }
  }

  //Get Bank List
  Future epGetBankList() async {
    try {
      final response = await _client.post(
        ApiQueries.queryBankList,
      );

      final decoded = json.decode(response.toString());
      final object = BankListRes(bankList: decoded['content']);

      return object;
    } on DioError catch (ex) {
      final decoded = json.decode(ex.response!.toString());
      final object = CommonMessageRes.fromJson(decoded['common']);
      return object;
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
}

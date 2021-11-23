import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';
import 'package:yollet_web/models/serialized_models/approval_details/approval_details_model_req.dart';
import 'package:yollet_web/models/serialized_models/approval_details/approval_details_model_res.dart';
import 'package:yollet_web/models/serialized_models/auth/auth_model_res.dart';
import 'package:yollet_web/models/serialized_models/bank_list/bank_list_model_res.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/models/serialized_models/transfer_state_list/transfer_state_list_model_req.dart';
import 'package:yollet_web/models/serialized_models/transfer_state_list/transfer_state_list_model_res.dart';
import 'package:yollet_web/models/serialized_models/user_exists/user_exists_model_req.dart';

///----------------- Navigation -----------------
class NavigateToAction {
  final String? to;
  final bool replace;
  final Map? arguments;

  NavigateToAction({
    this.to,
    this.replace = false,
    this.arguments,
  });
}

class UpdateNavigationAction {
  final String? name;
  final List<String>? history;

  UpdateNavigationAction({
    this.name,
    this.history,
  });
}

class OverlayAction {
  dynamic overlayEntry;
  GlobalKey? gKey;
  Widget? child;

  OverlayAction({this.overlayEntry = false, this.gKey, this.child});
}

///----------------- API -----------------

class GetApprovalListAction {
  final ApprovalListReq? approvalListReq;

  GetApprovalListAction({this.approvalListReq});
}

class GetStoreListAction {
  final StoreListReq? storeListReq;

  GetStoreListAction({this.storeListReq});
}

class GetSettlementListAction {
  final SettlementListReq? settlementListReq;

  GetSettlementListAction({this.settlementListReq});
}

class GetStoreDetailAction {
  final StoreDetailsReq storeDetailsReq;

  GetStoreDetailAction({required this.storeDetailsReq});
}

class GetAcquirementListAction {
  final AcquirementListReq? acquirementListReq;

  GetAcquirementListAction({this.acquirementListReq});
}

class GetTransferListAction {
  final TransferListReq? transferListReq;

  GetTransferListAction({this.transferListReq});
}

class GetStorePaymentMethodListAction {
  final StorePaymentMethodListReq? storePaymentMethodListReq;

  GetStorePaymentMethodListAction({this.storePaymentMethodListReq});
}

class GetStoreUpdateDetailAction {
  final StoreUpdateReq? storeUpdateReq;

  GetStoreUpdateDetailAction({this.storeUpdateReq});
}

class GetStoreDeleteAction {
  final StoreDeleteReq? storeDeleteReq;

  GetStoreDeleteAction({this.storeDeleteReq});
}

class GetSettlementDetailListAction {
  final SettlementDetailListReq? settlementDetailListReq;

  GetSettlementDetailListAction({this.settlementDetailListReq});
}

class GetStoreAccountListAction {
  final StoreAccountListReq? storeAccountListReq;

  GetStoreAccountListAction({this.storeAccountListReq});
}

class GetApprovalDeatilsAction {
  final ApprovalDetailsReq? approvalDetailsReq;

  GetApprovalDeatilsAction({this.approvalDetailsReq});
}

class GetTransferDetailAction {
  final TransferDetailsReq? transferDetailsReq;

  GetTransferDetailAction({this.transferDetailsReq});
}

class GetJwtTokenAction {
  final AuthReq authReq;

  GetJwtTokenAction({required this.authReq});
}

class GetAuthInfoAction {}

class GetHelloTestAction {}

class GetDownloadExcelAction {
  DownloadState downloadState;

  GetDownloadExcelAction(this.downloadState);
}

class GetPaymentMethodGlobalListAction {}

class GetTransferMethodGlobalListAction {}

class GetDomainListAction {}

class GetUploadLicenseAction {
  FilePickerResult? result;
  String storeId;

  GetUploadLicenseAction(this.result, {required this.storeId});
}

class GetTransferSettlementListAction {
  TransferSettlementListReq? transferSettlementListReq;

  GetTransferSettlementListAction({this.transferSettlementListReq});
}

class GetTransferStateListAction {
  TransferStateListReq? transferStateListReq;

  GetTransferStateListAction({this.transferStateListReq});
}

class GetDistributorListAction {}

class GetStoreCreateAction {
  final StoreCreateReq storeCreateReq;

  GetStoreCreateAction({required this.storeCreateReq});
}

class GetAgencyListAction {
  AgencyListReq? agencyListReq;

  GetAgencyListAction({this.agencyListReq});
}

class GetUserExistsAction {
  UserExistsReq? userExistsReq;

  GetUserExistsAction({this.userExistsReq});
}

class GetStorePaymentMethodAddAction {
  StorePaymentMethodAddReq? storePaymentMethodAddReq;

  GetStorePaymentMethodAddAction({this.storePaymentMethodAddReq});
}

class GetStorePaymentMethodUpdateAction {
  StorePaymentMethodUpdateReq? storePaymentMethodUpdateReq;

  GetStorePaymentMethodUpdateAction({this.storePaymentMethodUpdateReq});
}

class GetStorePaymentMethodRemoveAction {
  StorePaymentMethodRemoveReq? storePaymentMethodRemoveReq;

  GetStorePaymentMethodRemoveAction({this.storePaymentMethodRemoveReq});
}

class GetStoreAccountMethodAddAction {
  StoreAccountMethodAddReq? storeAccountMethodAddReq;

  GetStoreAccountMethodAddAction({this.storeAccountMethodAddReq});
}

class GetStoreAccountMethodUpdateAction {
  StoreAccountMethodUpdateReq? storeAccountMethodUpdateReq;

  GetStoreAccountMethodUpdateAction({this.storeAccountMethodUpdateReq});
}

class GetStoreAccountMethodRemoveAction {
  StoreAccountMethodRemoveReq? storeAccountMethodRemoveReq;

  GetStoreAccountMethodRemoveAction({this.storeAccountMethodRemoveReq});
}

class GetBankListAction {}

enum DownloadState {
  APPROVED,
  ACQUIRED,
  SETTLEMENT,
  SETTLEMENTDETAIL,
  TRANSFER,
  STORE,
}

extension StringParsing on DownloadState {
  String parseString() {
    switch (this) {
      case DownloadState.ACQUIRED:
        return 'acquired_list';
      case DownloadState.SETTLEMENT:
        return 'settlement_list';
      case DownloadState.SETTLEMENTDETAIL:
        return 'settlement_detail_list';
      case DownloadState.TRANSFER:
        return 'transfer_list';
      case DownloadState.APPROVED:
        return 'approved_list';
      default:
        return 'store_list';
    }
  }
}

class UpdateApiAction {
  String? errorMessage;
  ApprovalListRes? approvalListRes;
  StoreListRes? storeListRes;
  SettlementListRes? settlementListRes;
  AcquirementListRes? acquirementListRes;
  TransferListRes? transferList;
  StorePaymentMethodListRes? storePaymentMethodListRes;
  SettlementDetailListRes? settlementDetailListRes;
  StoreAccountListRes? storeAccountListRes;
  ApprovalDetailsRes? approvalDetailsRes;
  AuthRes? authRes;
  CommonMessageRes? commonMessageResHello;
  PaymentMethodGlobalListRes? paymentMethodGlobalListRes;
  TransferDetailsRes? transferDetailsRes;
  DomainListRes? domainListRes;
  CommonMessageRes? messageRes;
  TransferMethodGlobalListRes? transferMethodGlobalList;
  StoreDetailsRes? storeDetailsRes;
  TransferSettlementListRes? transferSettlementListRes;
  TransferStateListRes? transferStateListRes;
  AuthInfoRes? authInfoRes;
  DistributorListRes? distributorListRes;
  AgencyListRes? agencyListRes;
  BankListRes? bankListRes;

  UpdateApiAction({
    this.errorMessage ,
    this.approvalListRes,
    this.storeListRes,
    this.settlementListRes,
    this.acquirementListRes,
    this.transferList,
    this.storePaymentMethodListRes,
    this.settlementDetailListRes,
    this.storeAccountListRes,
    this.approvalDetailsRes,
    this.authRes,
    this.commonMessageResHello,
    this.paymentMethodGlobalListRes,
    this.transferDetailsRes,
    this.domainListRes,
    this.messageRes,
    this.transferMethodGlobalList,
    this.storeDetailsRes,
    this.transferSettlementListRes,
    this.transferStateListRes,
    this.authInfoRes,
    this.distributorListRes,
    this.agencyListRes,
    this.bankListRes,
  });
}

///----------------- UI -----------------

class SetLocalStorageAction {
  String key;
  String value;

  SetLocalStorageAction({required this.value, required this.key});
}

class GetLocalStorageAction {
  String key;

  GetLocalStorageAction({required this.key});
}

class ClearControllersAction {}

class InitUIAction {}

class UpdateUIAction {
  LoadingStatus? loadingStatus;
  int? sideBarCollapsedNumber;
  int? sideBarChildNumber;

  dynamic overlayEntry;
  List<String>? approvedHeadNames;
  List<String>? acquiredHeadNames;
  List<String>? settlementHeadNames;
  List<String>? settlementDetailHeadNames;
  List<String>? transferHeadNames;
  List<String>? storeHeadNames;
  List<String>? storeIdList;
  UpdateUIAction({
    this.sideBarCollapsedNumber,
    this.sideBarChildNumber,
    this.loadingStatus,
    this.overlayEntry,
    this.approvedHeadNames,
    this.acquiredHeadNames,
    this.settlementHeadNames,
    this.settlementDetailHeadNames,
    this.transferHeadNames,
    this.storeHeadNames,
    this.storeIdList,
  });
}

///----------------- INIT -----------------

enum ROLE {
  ROLE_ROOT,
  ROLE_DISTRIBUTOR,
  ROLE_AGENCY,
  ROLE_STORE,
}

extension StringParsingRole on ROLE {
  String parseString() {
    switch (this) {
      case ROLE.ROLE_ROOT:
        return 'ROLE_ROOT';
      case ROLE.ROLE_DISTRIBUTOR:
        return 'ROLE_DISTRIBUTOR';
      case ROLE.ROLE_AGENCY:
        return 'ROLE_AGENCY';
      default:
        return 'ROLE_STORE';
    }
  }
}

class UpdateInitAction {
  bool? loggedIn;
  String? token;
  String? domain;
  String? sub;
  String? role;
  String? exp;
  String? iab;
  String? id;
  String? pw;

  UpdateInitAction({
    this.loggedIn,
    this.token,
    this.sub,
    this.role,
    this.iab,
    this.exp,
    this.domain,
    this.id,
    this.pw,
  });
}

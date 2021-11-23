import 'package:yollet_web/UI/template/base/template.dart';

///
/// UI State
///
@immutable
class UIState {
  final LoadingStatus loadingStatus;
  final dynamic overlayEntry;
  final int sideBarCollapsedNumber;
  final int sideBarChildNumber;
  final List<String> storeIdList;
  final List<String> approvedHeadNames;
  final List<String> acquiredHeadNames;
  final List<String> settlementHeadNames;
  final List<String> settlementDetailHeadNames;
  final List<String> transferHeadNames;
  final List<String> storeHeadNames;

  UIState({
    required this.loadingStatus,
    required this.sideBarCollapsedNumber,
    required this.sideBarChildNumber,
    required this.overlayEntry,
    required this.approvedHeadNames,
    required this.acquiredHeadNames,
    required this.settlementHeadNames,
    required this.settlementDetailHeadNames,
    required this.transferHeadNames,
    required this.storeHeadNames,
    required this.storeIdList,
  });

  factory UIState.initial() {
    return UIState(
      sideBarChildNumber: 1,
      loadingStatus: LoadingStatus.init,
      sideBarCollapsedNumber: 1,
      overlayEntry: false,
      storeHeadNames: [
        'businessRegistrationNo',
        'storeName',
        'loginId',
        'creationTime',
        'primaryAddress',
      ],
      approvedHeadNames: [
        'businessRegistrationNo',
        'paymentMethodName',
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
        'paymentMethodName',
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
      settlementHeadNames: [
        'businessRegistrationNo',
        'settlementId',
        'paymentMethodName',
        'settlementDatetime',
        'expectedTransferDate',
        'transferDate',
        'transactionCount',
        'settlementAmount',
        'settlementFee',
        'settlementTax',
        'depositAmount',
        'transferMethod',
        'transferId',
      ],
      settlementDetailHeadNames: [
        'businessRegistrationNo',
        'settlementId',
        'paymentMethodName',
        'settlementDatetime',
        'transactionId',
        'approvalDatetime',
        'acquirerName',
        'transactionType',
        'approvalAmount',
        'settlementFee',
        'settlementTax',
        'depositAmount',
        'orderId',
        'transferId',
      ],
      transferHeadNames: [
        'businessRegistrationNo',
        'transferId',
        'transferMethodName',
        'expectedTransferDatetime',
        'transferState',
        'transferDatetime',
        'depositAmount',
        'depositBankName',
        'depositAccountNo',
        'updateDatetime',
      ],
      storeIdList: [],
    );
  }

  UIState copyWith({
    LoadingStatus? loadingStatus,
    int? sideBarCollapsedNumber,
    int? sideBarChildNumber,
    dynamic overlayEntry,
    List<String>? approvedHeadNames,
    List<String>? acquiredHeadNames,
    List<String>? settlementHeadNames,
    List<String>? settlementDetailHeadNames,
    List<String>? transferHeadNames,
    List<String>? storeHeadNames,
    List<String>? storeIdList,
  }) {
    return UIState(
      sideBarChildNumber: sideBarChildNumber ?? this.sideBarChildNumber,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      sideBarCollapsedNumber:
          sideBarCollapsedNumber ?? this.sideBarCollapsedNumber,
      overlayEntry: overlayEntry ?? this.overlayEntry,
      approvedHeadNames: approvedHeadNames ?? this.approvedHeadNames,
      acquiredHeadNames: acquiredHeadNames ?? this.acquiredHeadNames,
      settlementHeadNames: settlementHeadNames ?? this.settlementHeadNames,
      settlementDetailHeadNames:
          settlementDetailHeadNames ?? this.settlementDetailHeadNames,
      transferHeadNames: transferHeadNames ?? this.transferHeadNames,
      storeHeadNames: storeHeadNames ?? this.storeHeadNames,
      storeIdList: storeIdList ?? this.storeIdList,
    );
  }
}

enum LoadingStatus { fetching, error, failed, done, init }

import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/models/serialized_models/approval_details/approval_details_model_res.dart';
import 'package:yollet_web/models/serialized_models/bank_list/bank_list_model_res.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/models/serialized_models/transfer_state_list/transfer_state_list_model_res.dart';

///
/// Api State
///
@immutable
class ApiState {
  final String? errorMessage;

  final ApprovalListRes approvalListRes;
  final StoreListRes storeListRes;
  final SettlementListRes settlementListRes;
  final AcquirementListRes acquirementListRes;
  final TransferListRes transferListRes;
  final StorePaymentMethodListRes storePaymentMethodListRes;
  final SettlementDetailListRes settlementDetailListRes;
  final StoreAccountListRes storeAccountListRes;
  final ApprovalDetailsRes approvalDetailsRes;
  final StoreDetailsRes storeDetailsRes;
  final AuthRes authRes;
  final AuthInfoRes authInfoRes;
  final PaymentMethodGlobalListRes paymentMethodGlobalListRes;
  final TransferMethodGlobalListRes transferMethodGlobalList;
  final TransferDetailsRes transferDetailsRes;
  final DomainListRes domainListRes;
  final CommonMessageRes messageRes;
  final TransferSettlementListRes transferSettlementListRes;
  final TransferStateListRes transferStateListRes;
  final DistributorListRes distributorListRes;
  final AgencyListRes agencyListRes;
  final BankListRes bankListRes;

  ApiState({
    required this.errorMessage,
    required this.approvalListRes,
    required this.storeListRes,
    required this.settlementListRes,
    required this.acquirementListRes,
    required this.transferListRes,
    required this.storePaymentMethodListRes,
    required this.settlementDetailListRes,
    required this.storeAccountListRes,
    required this.approvalDetailsRes,
    required this.authRes,
    required this.paymentMethodGlobalListRes,
    required this.transferDetailsRes,
    required this.domainListRes,
    required this.messageRes,
    required this.transferMethodGlobalList,
    required this.storeDetailsRes,
    required this.transferSettlementListRes,
    required this.transferStateListRes,
    required this.authInfoRes,
    required this.agencyListRes,
    required this.distributorListRes,
    required this.bankListRes,
  });

  factory ApiState.initial() {
    return ApiState(
      errorMessage: null,
      approvalListRes: ApprovalListRes(),
      storeListRes: StoreListRes(),
      settlementListRes: SettlementListRes(),
      acquirementListRes: AcquirementListRes(),
      transferListRes: TransferListRes(),
      storePaymentMethodListRes: StorePaymentMethodListRes(),
      settlementDetailListRes: SettlementDetailListRes(),
      storeAccountListRes: StoreAccountListRes(),
      approvalDetailsRes: ApprovalDetailsRes(),
      authRes: AuthRes(),
      paymentMethodGlobalListRes: PaymentMethodGlobalListRes(),
      transferDetailsRes: TransferDetailsRes(),
      domainListRes: DomainListRes(),
      messageRes: CommonMessageRes(),
      transferMethodGlobalList: TransferMethodGlobalListRes(),
      storeDetailsRes: StoreDetailsRes(),
      transferSettlementListRes: TransferSettlementListRes(),
      transferStateListRes: TransferStateListRes(),
      authInfoRes: AuthInfoRes(),
      agencyListRes: AgencyListRes(),
      distributorListRes: DistributorListRes(),
      bankListRes: BankListRes(),
    );
  }

  ApiState copyWith({
    String? errorMessage,
    ApprovalListRes? approvalListRes,
    StoreListRes? storeListRes,
    SettlementListRes? settlementListRes,
    AcquirementListRes? acquirementListRes,
    TransferListRes? transferListRes,
    StorePaymentMethodListRes? storePaymentMethodListRes,
    SettlementDetailListRes? settlementDetailListRes,
    StoreAccountListRes? storeAccountListRes,
    ApprovalDetailsRes? approvalDetailsRes,
    StoreDetailsRes? storeDetailsRes,
    AuthRes? authRes,
    PaymentMethodGlobalListRes? paymentMethodGlobalListRes,
    TransferDetailsRes? transferDetailsRes,
    DomainListRes? domainListRes,
    CommonMessageRes? messageRes,
    TransferMethodGlobalListRes? transferMethodGlobalList,
    TransferSettlementListRes? transferSettlementListRes,
    TransferStateListRes? transferStateListRes,
    AuthInfoRes? authInfoRes,
    DistributorListRes? distributorListRes,
    AgencyListRes? agencyListRes,
    BankListRes? bankListRes,
  }) {
    return ApiState(
      errorMessage: errorMessage,
      approvalListRes: approvalListRes ?? this.approvalListRes,
      storeListRes: storeListRes ?? this.storeListRes,
      settlementListRes: settlementListRes ?? this.settlementListRes,
      acquirementListRes: acquirementListRes ?? this.acquirementListRes,
      transferListRes: transferListRes ?? this.transferListRes,
      storePaymentMethodListRes:
          storePaymentMethodListRes ?? this.storePaymentMethodListRes,
      settlementDetailListRes:
          settlementDetailListRes ?? this.settlementDetailListRes,
      storeAccountListRes: storeAccountListRes ?? this.storeAccountListRes,
      approvalDetailsRes: approvalDetailsRes ?? this.approvalDetailsRes,
      authRes: authRes ?? this.authRes,
      paymentMethodGlobalListRes:
          paymentMethodGlobalListRes ?? this.paymentMethodGlobalListRes,
      transferDetailsRes: transferDetailsRes ?? this.transferDetailsRes,
      domainListRes: domainListRes ?? this.domainListRes,
      messageRes: messageRes ?? this.messageRes,
      transferMethodGlobalList:
          transferMethodGlobalList ?? this.transferMethodGlobalList,
      storeDetailsRes: storeDetailsRes ?? this.storeDetailsRes,
      transferSettlementListRes:
          transferSettlementListRes ?? this.transferSettlementListRes,
      transferStateListRes: transferStateListRes ?? this.transferStateListRes,
      authInfoRes: authInfoRes ?? this.authInfoRes,
      agencyListRes: agencyListRes ?? this.agencyListRes,
      distributorListRes: distributorListRes ?? this.distributorListRes,
      bankListRes: bankListRes ?? this.bankListRes,
    );
  }
}

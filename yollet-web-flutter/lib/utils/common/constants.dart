class Constants {
  static const mainUrl = 'https://rest.yollet.net';
  static const baseUrlAuth = 'https://cpos-auth.yoshop.net';
  static const appTitle = 'Yollet Admin';
  static const pageSizes = [10, 20, 50, 100];
  static const numericDataValues = ['approvalAmount'];
  static const txTypes = {
    'SA': 'Sell Approved',
    'SC': "Sell Cancelled",
    'BA': "Buy Approved",
    'BC': "Buy Cancelled",
  };
  static const transferStates = {
    '00': 'create',
    '10': "approve",
    '20': "ready",
    '30': "transfer",
    '40': "done"
  };
  static const acquirementStates = {
    '00': 'ready',
    '10': "checking",
    '20': "done",
    '30': "return",
    '40': "negative"
  };
  static const storeHeadNamesConst = [
    'businessRegistrationNo',
    'storeName',
    'loginId',
    'creationTime',
    'primaryAddress',
  ];
  static const approvedHeadNamesConst = [
    'businessRegistrationNo',
    'paymentMethodName',
    'approvalDatetime',
    'transactionType',
    'acquirerName',
    'cardNo',
    'approvalNo',
    'approvalAmount',
    'resultCode',
  ];
  static const acquiredHeadNamesConst = [
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
  ];
  static const settlementHeadNamesConst = [
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
  ];
  static const settlementDetailHeadNamesConst = [
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
  ];
  static const transferHeadNamesConst = [
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
  ];
}

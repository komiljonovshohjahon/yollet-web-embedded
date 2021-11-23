String stateIdentify(String state) {
  if (state == '00') {
    return 'create';
  } else if (state == '10') {
    return 'approve';
  } else if (state == '20') {
    return 'ready';
  } else if (state == '30') {
    return 'transfer';
  } else if (state == '40') {
    return 'done';
  } else {
    return '';
  }
}

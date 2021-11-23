import 'package:yollet_web/mgr/redux/app_state.dart';

String text2Code(String type, String name) {
  String code = "";
  switch (type) {
    case "payment":
      appStore.state.apiState.paymentMethodGlobalListRes.paymentMethodList!
          .forEach((element) {
        if (element['name'] == name) {
          code = element['code'];
        }
      });
      break;
    case "transfer":
      appStore.state.apiState.transferMethodGlobalList.transferMethodList!
          .forEach((element) {
        if (element['name'] == name) {
          code = element['code'];
        }
      });
      break;
    case "bank":
      appStore.state.apiState.bankListRes.bankList!.forEach((element) {
        if (element['name'] == name) {
          code = element['code'];
        }
      });
      break;
  }
  return code;
}

String code2Text(String type, String code) {
  String name = "";
  switch (type) {
    case "payment":
      appStore.state.apiState.paymentMethodGlobalListRes.paymentMethodList!
          .forEach((element) {
        if (element['code'] == code) {
          name = element['name'];
        }
      });
      break;
    case "transfer":
      for (var element in appStore
          .state.apiState.transferMethodGlobalList.transferMethodList!) {
        if (element['code'] == code) {
          name = element['name'];
        }
      }
      break;
    case "bank":
      appStore.state.apiState.bankListRes.bankList!.forEach((element) {
        if (element['code'] == code) {
          name = element['name'];
        }
      });
      break;
  }
  return name;
}

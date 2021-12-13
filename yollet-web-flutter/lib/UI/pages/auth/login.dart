import 'dart:developer';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:xstate/xstate.dart' as xs;
import 'package:yollet_web/UI/widgets/dropdown/dropdown_2.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/utils/common/validators.dart';

enum AuthStates {
  IDLE,
  LOGIN,
  STORELIST,
  STOREDETAIL,
}

enum AuthEvents {
  LOGIN,
  RESOLVE,
  REJECT,
}

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  dynamic _current;

  final _formAuthKey = GlobalKey<FormState>();

  final Validator validator = Validator();
  bool _validate = false;
  String errorMsg = '';
  String? _domainError;
  List<String>? domainList = [];

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  String? id;
  String? pw;
  String? dpValue;

  @override
  void initState() {
    super.initState();
    // machine.start(initial: ['not_loaded']); // not_loaded
    // _initMachine();
  }

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) {
        if (store.state.apiState.domainListRes.domainList != null) {
          domainList = [
            ...store.state.apiState.domainListRes.domainList!
                .map((e) => e.toString())
          ];
        } else {
          _validate = false;
          errorMsg = 'Failed to get domain list!\nPlease refresh the page.';
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeColors.coolgray100,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: ThemeColors.white,
                  boxShadow: ThemeShadows.shadowLg,
                  borderRadius: BorderRadius.circular(6)),
              width: 465.0,
              height: 650.0,
              padding: const EdgeInsets.only(
                  top: 56, right: 32, left: 32, bottom: 56),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/icons/yollet_logo_color.png',
                    width: 138.0,
                    height: 39.0,
                  ),
                  Form(
                    key: _formAuthKey,
                    child: Column(
                      children: [
                        InputForm(
                          label: 'id',
                          hint: 'enter_id',
                          validator: validator.validateId,
                          controller: idController,
                        ),
                        InputForm(
                          validator: validator.validatePassword,
                          label: 'password',
                          hint: 'enter_password',
                          isObscured: true,
                          controller: pwController,
                        ),
                        DefaultDropdown(
                          label: 'domain',
                          errorText: _domainError,
                          value: dpValue,
                          listValues: domainList ?? [],
                          onChanged: (value) {
                            setState(() {
                              dpValue = value.toString();
                            });
                            setState(() {
                              _domainError = null;
                            });
                          },
                          hintText: 'yollet.net',
                        ),
                        const SizedBox(height: 48.0),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      if (state.apiState.errorMessage != null)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(state.apiState.errorMessage.toString()),
                          ),
                        ),
                      if (_validate)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else
                        DefaultButton(
                          isExpanded: true,
                          text: 'login',
                          onPressed: onLogin,
                          sizeOfButton: ButtonSize.M,
                          variant: ButtonVariant.PRIMARY,
                        ),
                      const SizedBox(height: 12.0),
                      DefaultButton(
                        isExpanded: true,
                        disabled: true,
                        text: 'sign_up',
                        onPressed: null,
                        sizeOfButton: ButtonSize.M,
                        variant: ButtonVariant.GHOST,
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        children: [
                          InkWell(
                            onTap: null,
                            child: SizedText(
                              text: "find_id",
                              textStyle: ThemeTextRegular.sm.apply(
                                  color:
                                      ThemeColors.orange500.withOpacity(0.5)),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          InkWell(
                            onTap: null,
                            child: SizedText(
                              text: 'reset_password',
                              textStyle: ThemeTextRegular.sm.apply(
                                  color:
                                      ThemeColors.orange500.withOpacity(0.5)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  onLogin() async {
    // machine.transition('not_loaded', 'INSERT_CD'); // loaded.stopped
    // machine.transition('loaded.paused', 'EJECT'); // not_loaded
    // loginState.enter();
    if (_formAuthKey.currentState!.validate()) {
      if (validator.validateDomain(dpValue, () {
            setState(() {
              _domainError = 'domain_must_be_selected';
            });
          }) ==
          null) {
        setState(() {
          id = idController.text;
          pw = pwController.text;
        });
        _validate = true;
        AuthRes? tokenRes = await appStore.dispatch(GetJwtTokenAction(
            authReq: AuthReq(domain: dpValue!, id: id!, password: pw!)));
        if (tokenRes != null) {
          AuthInfoRes? authInfoRes =
              await appStore.dispatch(GetAuthInfoAction());
        }
        setState(() {
          _validate = false;
        });
      }
    }
  }

  // _initMachine() {
  //   loginState.addTransition(SM.EntryTransition(() async {
  //     log('I am in Login State');
  //
  //     if (_formAuthKey.currentState!.validate()) {
  //       if (validator.validateDomain(dpValue, () {
  //             setState(() {
  //               _domainError = 'domain_must_be_selected';
  //             });
  //           }) ==
  //           null) {
  //         setState(() {
  //           id = idController.text;
  //           pw = pwController.text;
  //         });
  //         _validate = true;
  //         AuthRes? tokenRes = await appStore.dispatch(GetJwtTokenAction(
  //             authReq: AuthReq(domain: dpValue!, id: id!, password: pw!)));
  //         if (tokenRes != null) {
  //           AuthInfoRes? authInfoRes =
  //               await appStore.dispatch(GetAuthInfoAction());
  //           storeListState.enter();
  //         }
  //         setState(() {
  //           _validate = false;
  //         });
  //       }
  //     }
  //   }));
  //   storeListState.addTransition(SM.EntryTransition(() {
  //     log('I am in Store List State');
  //   }));
  //
  //   // idleState.onEntry(() {
  //   //   log('I am in Idle State');
  //   //
  //   //   loginState.enter();
  //   //
  //   //   // appStore.dispatch(action);
  //   // });
  //   //
  //   // loginState.onEntry(() async {
  //   //   log('I am in Login State');
  //   //   onLogin();
  //   //   _getRole().enter();
  //   // });
  //   //
  //   // storeListState.onEntry(() {
  //   //   appStore.dispatch(NavigateToAction(to: AppRoutes.RouteToStoreList));
  //   //   log('I am in Store List State');
  //   //   // loginState.enter();
  //   // });
  //   //
  //   // storeDetailState.onEntry(() {
  //   //   appStore.dispatch(NavigateToAction(to: AppRoutes.RouteToStoreBasic));
  //   //   log('I am in Store Detail State');
  //   //   // loginState.enter();
  //   // });
  // }
}

//
final machine = xs.Machine.fromJson({
  "key": "cd",
  "initial": "not_loaded",
  "states": {
    "not_loaded": {
      "on": {"INSERT_CD": "loaded"},
    },
    "loaded": {
      "initial": "stopped",
      "on": {"EJECT": "not_loaded"},
      "states": {
        "stopped": {
          "on": {"PLAY": "playing"}
        },
        "playing": {
          "on": {
            "STOP": "stopped",
            "EXPIRED_END": "stopped",
            "EXPIRED_MID": "playing",
            "PAUSE": "paused"
          }
        },
        "paused": {
          "initial": "not_blank",
          "states": {
            "blank": {
              "on": {"TIMER": "not_blank"}
            },
            "not_blank": {
              "on": {"TIMER": "blank"}
            }
          },
          "on": {"PAUSE": "playing", "PLAY": "playing", "STOP": "stopped"}
        }
      }
    }
  }
});

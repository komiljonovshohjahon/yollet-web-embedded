import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/UI/widgets/popups/show_popup.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:js' as js;

import 'package:yollet_web/utils/common/validators.dart';

class StoreDetailBasicPage extends StatefulWidget {
  String? storeId;
  bool? isNewStore;
  StoreDetailBasicPage({Key? key, this.storeId, this.isNewStore = false})
      : super(key: key);

  @override
  _StoreDetailBasicStatePage createState() => _StoreDetailBasicStatePage();
}

class _StoreDetailBasicStatePage extends State<StoreDetailBasicPage> {
  final _formStoreDetailKey = GlobalKey<FormState>();
  final _formAuthKey = GlobalKey<FormState>();

  bool isObscured = true;

  Validator validator = Validator();

  TextEditingController storeController = TextEditingController();
  TextEditingController binController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController loginIdController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController primaryAddrController = TextEditingController();
  TextEditingController detailAddrController = TextEditingController();
  TextEditingController resetPassController = TextEditingController();

  StoreDetailsRes? storeDetailsRes;

  FilePickerResult? file;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await appStore.dispatch(GetStoreDetailAction(
          storeDetailsReq: StoreDetailsReq(
              storeId: widget.storeId ??
                  appStore.state.apiState.authInfoRes.storeId!)));
      await appStore.dispatch(GetStorePaymentMethodListAction(
          storePaymentMethodListReq: StorePaymentMethodListReq(
              storeId: widget.storeId ??
                  appStore.state.apiState.authInfoRes.storeId!)));
      await appStore.dispatch(GetStoreAccountListAction(
          storeAccountListReq: StoreAccountListReq(
              storeId: widget.storeId ??
                  appStore.state.apiState.authInfoRes.storeId!)));
      // if (appStore.state.apiState.authInfoRes.storeId != null) {
      //   if (appStore.state.apiState.storeDetailsRes.loginId == null) {
      //     StoreDetailsRes? storeDetailRes = await appStore.dispatch(
      //         GetStoreDetailAction(
      //             storeDetailsReq: StoreDetailsReq(
      //                 storeId: appStore.state.apiState.authInfoRes.storeId!)));
      //     StorePaymentMethodListRes? storePayRes = await appStore.dispatch(
      //         GetStorePaymentMethodListAction(
      //             storePaymentMethodListReq: StorePaymentMethodListReq(
      //                 storeId: appStore.state.apiState.authInfoRes.storeId!)));
      //     StoreAccountListRes? storeAccRes = await appStore.dispatch(
      //         GetStoreAccountListAction(
      //             storeAccountListReq: StoreAccountListReq(
      //                 storeId: appStore.state.apiState.authInfoRes.storeId!)));
      //     if (storeDetailRes != null &&
      //         storePayRes != null &&
      //         storeAccRes != null) {
      //       setState(() {
      //         storeDetailsRes = appStore.state.apiState.storeDetailsRes;
      //         loginIdController = TextEditingController(
      //             text: storeDetailsRes!.loginId!.toString());
      //         primaryAddrController = TextEditingController(
      //             text: storeDetailsRes!.primaryAddress.toString());
      //         detailAddrController = TextEditingController(
      //             text: storeDetailsRes!.detailAddress.toString());
      //         ownerController = TextEditingController(
      //             text: storeDetailsRes!.ownerName.toString());
      //         storeController = TextEditingController(
      //             text: storeDetailsRes!.storeName.toString());
      //         binController = TextEditingController(
      //             text: storeDetailsRes!.businessRegistrationNo.toString());
      //         licenseController = TextEditingController(
      //             text: getLicenseName(
      //                 storeDetailsRes!.licenseUrl,
      //                 appStore.state.apiState.authInfoRes.storeId ??
      //                     widget.storeId!));
      //         telController = TextEditingController(
      //             text: storeDetailsRes!.telNo.toString());
      //       });
      //     }
      //   }
      // }
    });
  }

  @override
  void dispose() {
    storeController.dispose();
    binController.dispose();
    ownerController.dispose();
    licenseController.dispose();
    loginIdController.dispose();
    telController.dispose();
    passController.dispose();
    primaryAddrController.dispose();
    detailAddrController.dispose();
    resetPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return PageInitLayout(state: state, child: _buildBody(state));
      },
    );
  }

  Widget _buildBody(AppState state) {
    return Container(
      color: ThemeColors.white,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: ThemeColors.white,
                border: Border(
                    bottom:
                        BorderSide(color: ThemeColors.coolgray50, width: 1))),
            child: Navigationbar(
              id: widget.storeId,
              active: 0,
              names: const [
                'basic_info',
                'payment_info',
                'account_info',
              ],
              icons: const [
                HeroIcons.home,
                HeroIcons.creditCard,
                HeroIcons.user,
              ],
              tabsLength: 3,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
              height: 520,
              padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
              child: state.apiState.storeDetailsRes.loginId != null
                  ? buildInputTable2(state)
                  : buildInputTableInit()),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultButton(
                    text: 'remove',
                    onPressed: () async {
                      _onRemovePress(state);
                    },
                    sizeOfButton: ButtonSize.M,
                    variant: ButtonVariant.GHOST),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.initState.role != 'ROLE_STORE')
                      DefaultButton(
                        text: 'back',
                        onPressed: () {
                          appStore.dispatch(NavigateToAction(
                              to: AppRoutes.RouteToStoreList, replace: true));
                        },
                        sizeOfButton: ButtonSize.M,
                        variant: ButtonVariant.GHOST,
                      ),
                    const SizedBox(
                      width: 8,
                    ),
                    DefaultButton(
                        text: 'save',
                        onPressed: () async {
                          _onSave(state.apiState);
                        },
                        sizeOfButton: ButtonSize.M,
                        variant: ButtonVariant.PRIMARY),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onRemovePress(AppState state) async {
    await showPopup(
        context,
        DefaultModal(
          childWidget: state.initState.role == ROLE.ROLE_STORE.parseString()
              ? Form(
                  key: _formAuthKey,
                  child: SizedBox(
                    width: 290,
                    child: InputForm(
                      label: 'password',
                      validator: validator.validatePassword,
                      rightLabel: 'required',
                      isObscured: true,
                      controller: passController,
                    ),
                  ),
                )
              : null,
          onCancel: () {
            appStore.dispatch(NavigateToAction(to: 'up'));
          },
          onConfirm: () {
            _onRemoveConfirm(state);
          },
        ),
        barrierDismissible: true);
  }

  _onRemoveConfirm(AppState state) async {
    String resCode = '400';
    String id = "";
    String message = "";
    CommonMessageRes res = await appStore.dispatch(
      GetStoreDeleteAction(
        storeDeleteReq: StoreDeleteReq(
          storeId: widget.storeId!,
        ),
      ),
    );
    if (res.resCode == "200") {
      resCode = res.resCode!;
    } else {
      resCode = res.resCode!;
      message = res.resMessage!;
      id = widget.storeId!;
    }

    if (resCode == '200') {
    } else {
      await showPopup(
          context,
          DefaultModal(
            buttons: [
              DefaultButton(
                text: 'ok',
                onPressed: () {
                  appStore.dispatch(NavigateToAction(to: 'up'));
                },
                sizeOfButton: ButtonSize.S,
                variant: ButtonVariant.PRIMARY,
              ),
            ],
            title: 'Error: ${resCode}, ID: ${id}',
            subTitle: 'Error message: ${message}',
            icon: HeroIcons.xCircle,
          ),
          barrierDismissible: true);
    }
    // }
  }

  Widget buildInputTableInit() {
    return Form(
      key: _formStoreDetailKey,
      child: InputTable(
        columnCount: 2,
        listOfInput: [
          InputForm(
            label: 'store_name',
            rightLabel: 'required',
            controller: storeController,
          ),
          InputForm(
            label: 'bin_inn',
            rightLabel: 'required',
            controller: binController,
          ),
          InputForm(
            label: 'owner_name',
            rightLabel: 'required',
            controller: ownerController,
          ),
          SizedBox(
            width: 524,
            child: InputForm(
              subButtons: [
                const SizedBox(
                  width: 8,
                ),
                DefaultButton(
                  text: 'upload',
                  onPressed: () async {
                    await _pickFile();
                  },
                  variant: ButtonVariant.SECONDARY,
                  sizeOfButton: ButtonSize.M,
                ),
                const SizedBox(
                  width: 8,
                ),
                DefaultButton(
                  text: 'download',
                  disabled: true,
                  onPressed: () async {},
                  variant: ButtonVariant.GHOST,
                  sizeOfButton: ButtonSize.M,
                ),
              ],
              label: 'license',
              rightLabel: 'required',
              readOnly: true,
              controller: licenseController,
            ),
          ),
          InputForm(
            label: 'login_id',
            rightLabel: 'required',
            controller: loginIdController,
          ),
          InputForm(
            label: 'phone_no',
            rightLabel: 'required',
            controller: telController,
          ),
          InputForm(
            label: 'password',
            subButtons: [
              const SizedBox(
                width: 8,
              ),
              DefaultButton(
                text: 'reset_password',
                onPressed: () async {},
                variant: ButtonVariant.GHOST,
                sizeOfButton: ButtonSize.M,
                isExpanded: true,
              ),
            ],
            rightLabel: 'required',
            isObscured: isObscured,
            controller: passController,
          ),
          InputForm(
            label: 'primary_address',
            rightLabel: 'required',
            controller: primaryAddrController,
          ),
          const SizedBox(),
          InputForm(
            label: 'detail_address',
            rightLabel: 'required',
            controller: detailAddrController,
          ),
        ],
      ),
    );
  }

  Widget buildInputTable(StoreDetailsRes res, AppState state) {
    return Form(
      key: _formStoreDetailKey,
      child: InputTable(
        columnCount: 2,
        listOfInput: [
          InputForm(
            label: 'store_name',
            rightLabel: 'required',
            controller: storeController,
          ),
          InputForm(
            label: 'businessRegistrationNo',
            rightLabel: 'required',
            controller: binController,
          ),
          InputForm(
            label: 'owner_name',
            rightLabel: 'required',
            controller: ownerController,
          ),
          SizedBox(
            width: 524,
            child: InputForm(
              label: 'license',
              readOnly: true,
              rightLabel: 'required',
              controller: licenseController,
              subButtons: [
                const SizedBox(
                  width: 8,
                ),
                DefaultButton(
                  text: 'upload',
                  onPressed: () async {
                    await _pickFile();
                  },
                  variant: ButtonVariant.SECONDARY,
                  sizeOfButton: ButtonSize.M,
                ),
                const SizedBox(
                  width: 8,
                ),
                DefaultButton(
                  text: 'download',
                  onPressed: () {
                    js.context.callMethod('open', [res.licenseUrl]);
                  },
                  variant: ButtonVariant.GHOST,
                  sizeOfButton: ButtonSize.M,
                ),
              ],
            ),
          ),
          InputForm(
            label: 'login_id',
            readOnly: state.initState.role == 'ROLE_STORE',
            controller: loginIdController,
          ),
          InputForm(
            label: 'phone_no',
            rightLabel: 'required',
            controller: telController,
          ),
          InputForm(
            label: 'password',
            subButtons: [
              const SizedBox(
                width: 8,
              ),
              DefaultButton(
                text: 'reset_password',
                onPressed: () async {},
                variant: ButtonVariant.GHOST,
                sizeOfButton: ButtonSize.M,
                isExpanded: true,
              ),
            ],
            rightLabel: 'required',
            isObscured: isObscured,
            validator: validator.validatePassword,
            controller: passController,
          ),
          InputForm(
            label: 'primary_address',
            rightLabel: 'required',
            controller: primaryAddrController,
          ),
          const SizedBox(),
          InputForm(
            label: 'detail_address',
            rightLabel: 'required',
            controller: detailAddrController,
          ),
        ],
      ),
    );
  }

  Widget buildInputTable2(AppState state) {
    return Form(
      key: _formStoreDetailKey,
      child: InputTable(
        columnCount: 2,
        listOfInput: [
          InputForm(
            label: 'store_name',
            rightLabel: 'required',
            controller: storeController = TextEditingController(
                text: state.apiState.storeDetailsRes.storeName),
          ),
          InputForm(
            label: 'businessRegistrationNo',
            rightLabel: 'required',
            controller: binController = TextEditingController(
                text: state.apiState.storeDetailsRes.businessRegistrationNo),
          ),
          InputForm(
            label: 'owner_name',
            rightLabel: 'required',
            controller: ownerController = TextEditingController(
                text: state.apiState.storeDetailsRes.ownerName),
          ),
          SizedBox(
            width: 524,
            child: InputForm(
              label: 'license',
              readOnly: true,
              rightLabel: 'required',
              controller: licenseController = TextEditingController(
                  text: getLicenseName(
                      state.apiState.storeDetailsRes.licenseUrl,
                      state.apiState.authInfoRes.storeId ?? widget.storeId!)),
              subButtons: [
                const SizedBox(
                  width: 8,
                ),
                DefaultButton(
                  text: 'upload',
                  onPressed: () async {
                    await _pickFile();
                  },
                  variant: ButtonVariant.SECONDARY,
                  sizeOfButton: ButtonSize.M,
                ),
                const SizedBox(
                  width: 8,
                ),
                DefaultButton(
                  text: 'download',
                  onPressed: () {
                    js.context.callMethod(
                        'open', [state.apiState.storeDetailsRes.licenseUrl]);
                  },
                  variant: ButtonVariant.GHOST,
                  sizeOfButton: ButtonSize.M,
                ),
              ],
            ),
          ),
          InputForm(
            label: 'login_id',
            readOnly: state.initState.role == 'ROLE_STORE',
            controller: loginIdController = TextEditingController(
                text: state.apiState.storeDetailsRes.loginId),
          ),
          InputForm(
            label: 'phone_no',
            rightLabel: 'required',
            controller: telController = TextEditingController(
                text: state.apiState.storeDetailsRes.telNo),
          ),
          InputForm(
            label: 'password',
            subButtons: [
              const SizedBox(
                width: 8,
              ),
              DefaultButton(
                text: 'reset_password',
                onPressed: () async {},
                variant: ButtonVariant.GHOST,
                sizeOfButton: ButtonSize.M,
                isExpanded: true,
              ),
            ],
            rightLabel: 'required',
            isObscured: isObscured,
            suffix: Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                child: HeroIcon(isObscured ? HeroIcons.eye : HeroIcons.eyeOff,
                    color: ThemeColors.coolgray600),
              ),
            ),
            validator: validator.validatePassword,
            controller: passController,
          ),
          InputForm(
            label: 'primary_address',
            rightLabel: 'required',
            controller: primaryAddrController = TextEditingController(
                text: state.apiState.storeDetailsRes.primaryAddress),
          ),
          const SizedBox(),
          InputForm(
            label: 'detail_address',
            rightLabel: 'required',
            controller: detailAddrController = TextEditingController(
                text: state.apiState.storeDetailsRes.detailAddress),
          ),
        ],
      ),
    );
  }

  getLicenseName(String? name, String storeId) {
    if (name != null) {
      return name
          .substring(name.toString().indexOf(storeId))
          .substring(name
              .toString()
              .substring(name.toString().indexOf(storeId))
              .indexOf('/'))
          .substring(1);
    }
  }

  _onSave(ApiState state) async {
    if (_formStoreDetailKey.currentState!.validate()) {
      if (!widget.isNewStore!) {
        CommonMessageRes infoUpdateRes = await appStore.dispatch(
          GetStoreUpdateDetailAction(
            storeUpdateReq: StoreUpdateReq(
                storeId: widget.storeId!,
                password: passController.text,
                ownerName: ownerController.text,
                businessRegistrationNo: binController.text,
                detailAddress: detailAddrController.text,
                primaryAddress: primaryAddrController.text,
                storeName: storeController.text,
                telNo: telController.text),
          ),
        );
        if (infoUpdateRes.resCode == '200') {
          if (file != null) {
            final updateLicenseRes = await appStore.dispatch(
                GetUploadLicenseAction(file, storeId: widget.storeId!));
            if (updateLicenseRes.resCode != '200') {
              await showPopup(
                  context,
                  DefaultModal(
                    buttons: [
                      DefaultButton(
                        text: 'ok',
                        onPressed: () {
                          if (widget.isNewStore!) {
                            appStore.dispatch(NavigateToAction(
                                to: AppRoutes.RouteToStoreList, replace: true));
                          } else {
                            appStore.dispatch(NavigateToAction(to: 'up'));
                            setState(() {});
                          }
                        },
                        sizeOfButton: ButtonSize.S,
                        variant: ButtonVariant.PRIMARY,
                      ),
                    ],
                    title: 'Error: ${updateLicenseRes.resCode}',
                    subTitle: 'Error message: ${updateLicenseRes.resMessage}',
                    icon: HeroIcons.xCircle,
                  ),
                  barrierDismissible: true);
            }
          }
          await showPopup(
              context,
              DefaultModal(
                buttons: [
                  DefaultButton(
                    text: 'ok',
                    onPressed: () {
                      if (widget.isNewStore!) {
                        appStore.dispatch(NavigateToAction(
                            to: AppRoutes.RouteToStoreList, replace: true));
                      } else {
                        appStore.dispatch(NavigateToAction(to: 'up'));
                        setState(() {});
                      }
                    },
                    sizeOfButton: ButtonSize.S,
                    variant: ButtonVariant.PRIMARY,
                  ),
                ],
                title: 'Success!',
                subTitle: 'Store updated successfully!',
                icon: HeroIcons.checkCircle,
              ),
              barrierDismissible: true);
        } else {
          await showPopup(
              context,
              DefaultModal(
                buttons: [
                  DefaultButton(
                    text: 'ok',
                    onPressed: () {
                      if (widget.isNewStore!) {
                        appStore.dispatch(NavigateToAction(to: 'up'));
                        appStore.dispatch(NavigateToAction(
                            to: AppRoutes.RouteToStoreList, replace: true));
                      } else {
                        appStore.dispatch(NavigateToAction(to: 'up'));
                        setState(() {});
                      }
                    },
                    sizeOfButton: ButtonSize.S,
                    variant: ButtonVariant.PRIMARY,
                  ),
                ],
                title: 'Error: ${infoUpdateRes.resCode}',
                subTitle: 'Error message: ${infoUpdateRes.resMessage}',
                icon: HeroIcons.xCircle,
              ),
              barrierDismissible: true);
        }
      } else {
        CommonMessageRes createdStore = await appStore.dispatch(
          GetStoreCreateAction(
            storeCreateReq: StoreCreateReq(
                agencyId: state.authInfoRes.agencyId!,
                id: loginIdController.text,
                password: '1111',
                businessRegistrationNo: binController.text,
                detailAddress: detailAddrController.text,
                ownerName: ownerController.text,
                primaryAddress: primaryAddrController.text,
                storeName: storeController.text,
                telNo: telController.text),
          ),
        );
        if (createdStore.resCode == "200") {
          if (file != null) {
            final updateLicenseRes = await appStore.dispatch(
                GetUploadLicenseAction(file, storeId: loginIdController.text));
            if (updateLicenseRes.resCode != '200') {
              await showPopup(
                  context,
                  DefaultModal(
                    buttons: [
                      DefaultButton(
                        text: 'ok',
                        onPressed: () {
                          if (widget.isNewStore!) {
                            appStore.dispatch(NavigateToAction(
                                to: AppRoutes.RouteToStoreList, replace: true));
                          } else {
                            appStore.dispatch(NavigateToAction(to: 'up'));
                            setState(() {});
                          }
                        },
                        sizeOfButton: ButtonSize.S,
                        variant: ButtonVariant.PRIMARY,
                      ),
                    ],
                    title: 'Error: ${updateLicenseRes.resCode}',
                    subTitle: 'Error message: ${updateLicenseRes.resMessage}',
                    icon: HeroIcons.xCircle,
                  ),
                  barrierDismissible: true);
            }
          }
          await showPopup(
              context,
              DefaultModal(
                buttons: [
                  DefaultButton(
                    text: 'ok',
                    onPressed: () {
                      appStore.dispatch(NavigateToAction(to: 'up'));
                      appStore.dispatch(NavigateToAction(
                          to: AppRoutes.RouteToStoreList, replace: true));
                    },
                    sizeOfButton: ButtonSize.S,
                    variant: ButtonVariant.PRIMARY,
                  ),
                ],
                title: 'Success!',
                subTitle: 'Store created successfully!',
                icon: HeroIcons.checkCircle,
              ),
              barrierDismissible: true);
        } else {
          await showPopup(
              context,
              DefaultModal(
                buttons: [
                  DefaultButton(
                    text: 'ok',
                    onPressed: () {
                      appStore.dispatch(NavigateToAction(to: 'up'));
                    },
                    sizeOfButton: ButtonSize.S,
                    variant: ButtonVariant.PRIMARY,
                  ),
                ],
                title: 'Error: ${createdStore.resCode}',
                subTitle: 'Error message: User ID ${createdStore.resMessage}',
                icon: HeroIcons.xCircle,
              ),
              barrierDismissible: true);
        }
      }
    }
  }

  _pickFile() async {
    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf']);
    if (result != null) {
      setState(() {
        file = result;
        licenseController =
            TextEditingController(text: result.files.first.name);
      });
      await showPopup(
          context,
          DefaultModal(
            buttons: [
              DefaultButton(
                text: 'ok',
                onPressed: () {
                  appStore.dispatch(NavigateToAction(to: 'up'));
                },
                sizeOfButton: ButtonSize.S,
                variant: ButtonVariant.PRIMARY,
              ),
            ],
            title: 'Success!',
            subTitle: 'License uploaded successfully!',
            icon: HeroIcons.checkCircle,
          ),
          barrierDismissible: true);
    }
  }
}

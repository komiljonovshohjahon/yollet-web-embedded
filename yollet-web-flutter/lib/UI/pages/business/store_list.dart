import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/UI/widgets/popups/show_popup.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/utils/common/constants.dart';
import 'package:yollet_web/utils/common/validators.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({Key? key}) : super(key: key);

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  GlobalKey overlayKeyStore = GlobalKey();
  GlobalKey datePickerKey = GlobalKey();
  final _formAuthKey = GlobalKey<FormState>();
  final Validator validator = Validator();

  TextEditingController passController = TextEditingController();

  dynamic overlayEntry;

  bool tableOpen = false;

  int pageNo = 1;
  int pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final List<bool> selectedItemsSort = List<bool>.generate(
        Constants.storeHeadNamesConst.length, (int index) => true);
    final List<String> headNamesStore = [];
    for (var element in Constants.storeHeadNamesConst) {
      headNamesStore.add(element);
    }
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) {
          appStore.dispatch(UpdateUIAction(storeIdList: []));
        },
        builder: (_, state) {
          return PageInitLayout(
            state: state,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  DefaultButton(
                      text: 'table',
                      key: overlayKeyStore,
                      variant: ButtonVariant.GHOST,
                      sizeOfButton: ButtonSize.M,
                      icon: HeroIcons.cog,
                      isSortableTable: true,
                      sortableTableOpened: tableOpen,
                      onPressed: () async {
                        _openSortableList(
                            state.uiState, selectedItemsSort, headNamesStore);
                      }),
                  const Spacer(),
                  DefaultButton(
                    text: 'new_store',
                    onPressed: () {
                      _onNewStorePress();
                    },
                    variant: ButtonVariant.PRIMARY,
                    sizeOfButton: ButtonSize.M,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  DefaultButton(
                    text: 'detail',
                    onPressed: () async {
                      _onDetailPress(state);
                    },
                    variant: ButtonVariant.SECONDARY,
                    disabled: !(state.uiState.storeIdList.isNotEmpty &&
                        state.uiState.storeIdList.length == 1),
                    sizeOfButton: ButtonSize.M,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  DefaultButton(
                    text: 'remove_store',
                    disabled: state.uiState.storeIdList.isEmpty,
                    onPressed: () {
                      _onRemovePress(state);
                    },
                    variant: ButtonVariant.GHOST,
                    sizeOfButton: ButtonSize.M,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              DefaultDatatable(
                showNumber: pageSize,
                pageNumber: pageNo,
                limit: state.apiState.storeListRes.storeList == null
                    ? 10
                    : state.apiState.storeListRes.storeList!.length,
                data: state.apiState.storeListRes.storeList,
                variant: TableVariants.STORELIST,
                state: state,
                sortColumnIndex: 1,
              ),
              const SizedBox(
                height: 8,
              ),
              TableButtons(
                pageTotal: state.apiState.storeListRes.pageTotal ?? 1,
                page: state.apiState.storeListRes.pageNo ?? 1,
                pageSize: state.apiState.storeListRes.pageSize ?? 10,
                onChanged: (value) async {
                  _onPageSizeChange(value, state);
                },
                previousButtonPressed: () async {
                  _onPrevPress(state);
                },
                nextButtonPressed: () {
                  _onNextPress(state);
                },
                stateData: state.apiState.storeListRes,
              ),
            ]),
          );
        });
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

  _onDetailPress(AppState state) async {
    await appStore.dispatch(GetStoreDetailAction(
        storeDetailsReq:
            StoreDetailsReq(storeId: state.uiState.storeIdList[0])));
    await appStore.dispatch(GetStorePaymentMethodListAction(
        storePaymentMethodListReq:
            StorePaymentMethodListReq(storeId: state.uiState.storeIdList[0])));
    await appStore.dispatch(GetStoreAccountListAction(
        storeAccountListReq:
            StoreAccountListReq(storeId: state.uiState.storeIdList[0])));

    appStore.dispatch(
      NavigateToAction(
        to: AppRoutes.RouteToStoreBasic,
        arguments: {'id': state.uiState.storeIdList[0]},
      ),
    );
  }

  _onNewStorePress() {
    appStore.dispatch(
      UpdateApiAction(
        storeDetailsRes: StoreDetailsRes(),
        storeAccountListRes: StoreAccountListRes(),
        storePaymentMethodListRes: StorePaymentMethodListRes(),
      ),
    );
    appStore.dispatch(NavigateToAction(to: AppRoutes.RouteToStoreBasic));
  }

  _onNextPress(AppState state) async {
    if (state.apiState.storeListRes.pageNo! <
        state.apiState.storeListRes.pageTotal!) {
      setState(() {
        pageNo = pageNo + 1;
      });
      await appStore.dispatch(
        GetStoreListAction(
          storeListReq: StoreListReq(
            pageSize: pageSize,
            pageNo: state.apiState.storeListRes.pageNo! + 1,
          ),
        ),
      );
    }
  }

  _onPrevPress(AppState state) async {
    if (state.apiState.storeListRes.pageNo! > 1) {
      setState(() {
        pageNo = pageNo - 1;
      });
      appStore.dispatch(
        GetStoreListAction(
            storeListReq: StoreListReq(
          pageSize: pageSize,
          pageNo: state.apiState.storeListRes.pageNo! - 1,
        )),
      );
    }
  }

  _onPageSizeChange(value, AppState state) async {
    setState(() {
      pageSize = int.tryParse(value)!;
    });

    appStore.dispatch(
      GetStoreListAction(
        storeListReq: StoreListReq(
          pageSize: pageSize,
          pageNo: state.apiState.storeListRes.pageNo,
        ),
      ),
    );
  }

  _onRemoveConfirm(AppState state) async {
    String resCode = '400';
    String id = "";
    String message = "";
    // if (_formAuthKey.currentState!.validate()) {
    for (var element in state.uiState.storeIdList) {
      CommonMessageRes res = await appStore.dispatch(
        GetStoreDeleteAction(
          storeDeleteReq: StoreDeleteReq(
            storeId: element,
          ),
        ),
      );
      if (res.resCode == "200") {
        resCode = res.resCode!;
      } else {
        resCode = res.resCode!;
        message = res.resMessage!;
        id = element;
      }
    }

    if (resCode == '200') {
      await appStore.dispatch(GetStoreListAction(
          storeListReq: StoreListReq(pageSize: pageSize, pageNo: pageNo)));
      appStore.dispatch(UpdateUIAction(storeIdList: []));
      appStore.dispatch(NavigateToAction(to: 'up'));
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

  _openSortableList(
      UIState state, List<bool> selectedItems, List<String> headNamesStore) {
    if (state.overlayEntry == false) {
      tableOpen = true;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeyStore,
        child: SortableTable(
          listType: DownloadState.STORE,
          stateList: state.storeHeadNames,
          headNames: headNamesStore,
          selectedItems: selectedItems,
        ),
      ));
    } else {
      tableOpen = false;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeyStore,
        overlayEntry: true,
        child: SortableTable(
          listType: DownloadState.APPROVED,
          stateList: state.storeHeadNames,
          headNames: headNamesStore,
          selectedItems: selectedItems,
        ),
      ));
    }
  }
}

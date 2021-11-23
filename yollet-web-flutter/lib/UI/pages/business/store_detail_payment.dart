import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/UI/widgets/popups/show_popup.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/utils/format/text_2_code.dart';

class StoreDetailPaymentPage extends StatefulWidget {
  String? storeId;
  StoreDetailPaymentPage({Key? key, this.storeId}) : super(key: key);

  @override
  _StoreDetailPaymentPageState createState() => _StoreDetailPaymentPageState();
}

class _StoreDetailPaymentPageState extends State<StoreDetailPaymentPage> {
  int selectedCard = -1;

  String? paymentMethodCode;
  String? paymentMethod;
  String? paymentMethodId;

  String? paymentMethodError;

  List<String>? paymentMethods = [];

  TextEditingController feeController = TextEditingController();
  TextEditingController tidController = TextEditingController();
  TextEditingController settlementController = TextEditingController();

  StorePaymentMethodListRes? storePaymentRes;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (appStore.state.apiState.storePaymentMethodListRes.methodList !=
          null) {
        storePaymentRes = appStore.state.apiState.storePaymentMethodListRes;
      }
      paymentMethods = [
        ...appStore.state.apiState.paymentMethodGlobalListRes.paymentMethodList!
            .map((e) => e['name'].toString())
      ];
    });
  }

  @override
  void dispose() {
    feeController.dispose();
    tidController.dispose();
    settlementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onWillChange: (previousViewModel, newViewModel) {
          setState(() {
            if (newViewModel.apiState.storePaymentMethodListRes.methodList !=
                null) {
              storePaymentRes = newViewModel.apiState.storePaymentMethodListRes;
            }
          });
        },
        builder: (_, state) {
          return Container(
            color: ThemeColors.white,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: ThemeColors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: ThemeColors.coolgray50, width: 1))),
                  child: Navigationbar(
                    id: widget.storeId,
                    active: 1,
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
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.apiState.storePaymentMethodListRes.methodList !=
                              null
                          ? CardsContainer(
                              cardsList: _buildCards2(state),
                              addMore: state.initState.role != "ROLE_STORE",
                              addClick: _clearFields,
                            )
                          : CardsContainer(
                              cardsList: _buildInitCards(),
                              addMore: state.initState.role != "ROLE_STORE",
                              addClick: _clearFields,
                            ),
                      const SizedBox(
                        width: 72,
                      ),
                      SizedBox(
                          width: 568,
                          height: 456,
                          child: _buildInputTable(state))
                    ],
                  ),
                ),
                if (state.initState.role != 'ROLE_STORE')
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                              if (selectedCard == -1) {
                                _addPaymentMethod();
                              } else {
                                _updatePaymentMethod();
                              }
                            },
                            sizeOfButton: ButtonSize.M,
                            variant: ButtonVariant.PRIMARY),
                      ],
                    ),
                  ),
              ],
            ),
          );
        });
  }

  List<DefaultCard> _buildCards(StorePaymentMethodListRes res, AppState state) {
    List paymentInfo = res.methodList!;
    List<DefaultCard> list = [];

    if (paymentInfo.isNotEmpty) {
      for (int i = 0; i < paymentInfo.length; i++) {
        list.add(DefaultCard(
            onClick: () {
              _onSelectCard(i, paymentInfo);
            },
            onRemove:
                state.apiState.authInfoRes.role != ROLE.ROLE_STORE.parseString()
                    ? () async {
                        _onRemoveCard(i, paymentInfo);
                      }
                    : null,
            headName: paymentInfo[i]['name'],
            bodyName: paymentInfo[i]['description'].toString(),
            childName: paymentInfo[i]['fee'].toString() + "%",
            backgroundColor: selectedCard == i
                ? ThemeColors.orange50
                : ThemeColors.coolgray50));
      }
    }

    return list;
  }

  List<DefaultCard> _buildCards2(AppState state) {
    List paymentInfo = state.apiState.storePaymentMethodListRes.methodList!;
    List<DefaultCard> list = [];

    if (paymentInfo.isNotEmpty) {
      for (int i = 0; i < paymentInfo.length; i++) {
        list.add(DefaultCard(
            onClick: () {
              _onSelectCard(i, paymentInfo);
            },
            onRemove:
                state.apiState.authInfoRes.role != ROLE.ROLE_STORE.parseString()
                    ? () async {
                        _onRemoveCard(i, paymentInfo);
                      }
                    : null,
            headName: paymentInfo[i]['name'],
            bodyName: paymentInfo[i]['description'].toString(),
            childName: paymentInfo[i]['fee'].toString() + "%",
            backgroundColor: selectedCard == i
                ? ThemeColors.orange50
                : ThemeColors.coolgray50));
      }
    }

    return list;
  }

  List<DefaultCard> _buildInitCards() {
    List<DefaultCard> list = [];

    return list;
  }

  Widget _buildInputTable(AppState state) {
    return InputTable(
      columnCount: 1,
      listOfInput: [
        DefaultDropdown(
          value: paymentMethod,
          label: "payment_method",
          errorText: paymentMethodError,
          note: 'select_payment_module',
          readOnly: state.initState.role == 'ROLE_STORE',
          listValues: paymentMethods!,
          onChanged: (val) {
            state.initState.role != 'ROLE_STORE'
                ? setState(() {
                    paymentMethod = val;
                    paymentMethodCode = text2Code('payment', val);
                  })
                : null;
          },
        ),
        InputForm(
          readOnly: state.initState.role == 'ROLE_STORE',
          label: 'transaction_fee',
          note: 'the_commission_rate_applied_to_the_store',
          controller: feeController,
        ),
        InputForm(
          readOnly: state.initState.role == 'ROLE_STORE',
          label: 'tid',
          note: 'terminal_id',
          controller: tidController,
        ),
        // InputForm(
        //   readOnly: state.initState.role == 'ROLE_STORE',
        //   label: 'settlement_account',
        //   note: '가맹점에 적용되는 수수료',
        //   controller: settlementController,
        // ),
      ],
    );
  }

  _clearFields() {
    setState(() {
      feeController.clear();
      tidController.clear();
      settlementController.clear();
      paymentMethod = null;
      selectedCard = -1;
    });
  }

  _onSelectCard(int i, List paymentInfo) {
    setState(() {
      selectedCard = i;
      feeController =
          TextEditingController(text: paymentInfo[i]['fee'].toString());
      tidController =
          TextEditingController(text: paymentInfo[i]['tid'].toString());
      settlementController =
          TextEditingController(text: paymentInfo[i]['settlement'].toString());
      paymentMethod = paymentInfo[i]['name'].toString();
      paymentMethodCode = paymentInfo[i]['code'].toString();
      paymentMethodId = paymentInfo[i]['id'].toString();
    });
  }

  _onRemoveCard(int i, List paymentInfo) async {
    showPopup(
        context,
        DefaultModal(
          title: 'remove_payment',
          subTitle: 'remove_payment_detail',
          onCancel: () async {
            appStore.dispatch(NavigateToAction(to: 'up'));
          },
          onConfirm: () async {
            final res = await appStore.dispatch(
                GetStorePaymentMethodRemoveAction(
                    storePaymentMethodRemoveReq: StorePaymentMethodRemoveReq(
                        paymentMethodId: paymentInfo[i]['id'])));

            if (res) {
              await appStore.dispatch(GetStorePaymentMethodListAction(
                  storePaymentMethodListReq:
                      StorePaymentMethodListReq(storeId: widget.storeId!)));
              appStore.dispatch(NavigateToAction(to: 'up'));
              _clearFields();
            }
          },
        ));
  }

  _addPaymentMethod() async {
    if (paymentMethod == null) {
      setState(() {
        paymentMethodError = "select_payment_method";
      });
    } else {
      setState(() {
        paymentMethodError = null;
      });
      final added = await appStore.dispatch(GetStorePaymentMethodAddAction(
          storePaymentMethodAddReq: StorePaymentMethodAddReq(
        storeId: widget.storeId!,
        code: paymentMethodCode!,
        name: paymentMethod!,
        // description: 'description',
        fee: double.tryParse(feeController.text),
        tid: tidController.text,
      )));
      if (added) {
        await appStore.dispatch(GetStorePaymentMethodListAction(
            storePaymentMethodListReq:
                StorePaymentMethodListReq(storeId: widget.storeId!)));
        _clearFields();
      }
    }
  }

  _updatePaymentMethod() async {
    final updated = await appStore.dispatch(GetStorePaymentMethodUpdateAction(
        storePaymentMethodUpdateReq: StorePaymentMethodUpdateReq(
      paymentMethodId: paymentMethodId!,
      code: paymentMethodCode!,
      name: paymentMethod!,
      // description: 'description',
      fee: double.tryParse(feeController.text),
      tid: tidController.text,
    )));
    if (updated) {
      await appStore.dispatch(GetStorePaymentMethodListAction(
          storePaymentMethodListReq:
              StorePaymentMethodListReq(storeId: widget.storeId!)));
      _clearFields();
    }
  }
}

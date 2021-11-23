import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/UI/widgets/popups/show_popup.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/utils/common/validators.dart';
import 'package:yollet_web/utils/format/text_2_code.dart';

class StoreDetailAccountPage extends StatefulWidget {
  String? storeId;

  StoreDetailAccountPage({Key? key, this.storeId}) : super(key: key);

  @override
  _StoreDetailAccountPageState createState() => _StoreDetailAccountPageState();
}

class _StoreDetailAccountPageState extends State<StoreDetailAccountPage> {
  final Validator validator = Validator();

  int selectedCard = -1;

  TextEditingController accNameController = TextEditingController();
  TextEditingController depositBankController = TextEditingController();
  TextEditingController accNoController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();

  String? depositBank;
  String? depositBankCode;
  String? accountId;

  String? transactionTypeCode;
  String? transactionType;

  String? transferModError;
  String? depositBankError;

  List<String>? depositBanks = [];
  List<String>? transferTypes = [];

  StoreAccountListRes? storeAccountListRes;

  @override
  void initState() {
    super.initState();
    if (appStore.state.apiState.storeAccountListRes.accountList != null) {
      storeAccountListRes = appStore.state.apiState.storeAccountListRes;
    }

    if (appStore.state.apiState.bankListRes.bankList != null) {
      depositBanks = [
        ...appStore.state.apiState.bankListRes.bankList!
            .map((e) => e['name'].toString())
      ];
    }
    if (appStore.state.apiState.transferMethodGlobalList.transferMethodList !=
        null) {
      transferTypes = [
        ...appStore.state.apiState.transferMethodGlobalList.transferMethodList!
            .map((e) => e['name'].toString())
      ];
    }
  }

  @override
  void dispose() {
    accNameController.dispose();
    depositBankController.dispose();
    accNoController.dispose();
    holderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        onWillChange: (previousViewModel, newViewModel) {
          setState(() {
            if (newViewModel.apiState.storeAccountListRes.accountList != null) {
              storeAccountListRes = newViewModel.apiState.storeAccountListRes;
            }
          });
        },
        converter: (store) => store.state,
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
                    active: 2,
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
                      state.apiState.storeAccountListRes.accountList != null
                          ? CardsContainer(
                              cardsList: _buildCards2(state),
                              methodName: 'account_info',
                              addClick: _clearFields,
                              addMore: state.initState.role != "ROLE_STORE",
                            )
                          : CardsContainer(
                              cardsList: _buildInitCards(),
                              methodName: 'account_info',
                              addClick: _clearFields,
                              addMore: state.initState.role != "ROLE_STORE",
                            ),
                      const SizedBox(
                        width: 72,
                      ),
                      SizedBox(
                          width: 568,
                          // height: 456,
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
                                _addAccountMethod();
                              } else {
                                _updateAccountMethod();
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

  List<DefaultCard> _buildCards(StoreAccountListRes res, AppState state) {
    List accInfo = res.accountList!;
    List<DefaultCard> list = [];
    if (accInfo.isNotEmpty) {
      for (int i = 0; i < accInfo.length; i++) {
        list.add(DefaultCard(
            onClick: () {
              _onSelectCard(i, accInfo);
            },
            onRemove:
                state.apiState.authInfoRes.role != ROLE.ROLE_STORE.parseString()
                    ? () async {
                        _onRemoveCard(i, accInfo);
                      }
                    : null,
            headName: accInfo[i]['depositBank'].toString(),
            bodyName: accInfo[i]['accountNo'].toString(),
            childName: accInfo[i]['holderName'].toString(),
            isButton: false,
            backgroundColor: selectedCard == i
                ? ThemeColors.orange50
                : ThemeColors.coolgray50));
      }
    }

    return list;
  }

  List<DefaultCard> _buildCards2(AppState state) {
    List accInfo = state.apiState.storeAccountListRes.accountList!;
    List<DefaultCard> list = [];
    if (accInfo.isNotEmpty) {
      for (int i = 0; i < accInfo.length; i++) {
        list.add(DefaultCard(
            onClick: () {
              _onSelectCard(i, accInfo);
            },
            onRemove:
                state.apiState.authInfoRes.role != ROLE.ROLE_STORE.parseString()
                    ? () async {
                        _onRemoveCard(i, accInfo);
                      }
                    : null,
            headName: accInfo[i]['depositBank'].toString(),
            bodyName: accInfo[i]['accountNo'].toString(),
            childName: accInfo[i]['holderName'].toString(),
            isButton: false,
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
    return Column(
      children: [
        InputForm(
          label: 'name',
          readOnly: state.initState.role == 'ROLE_STORE',
          note: 'alias_displayed_on_screen.',
          controller: accNameController,
        ),
        SizedBox(
          height: 32,
        ),
        DefaultDropdown(
          errorText: transferModError,
          label: 'transfer_module',
          value: transactionType,
          listValues: transferTypes!,
          onChanged: (val) {
            setState(() {
              transactionType = val;
              transactionTypeCode = text2Code('transfer', val);
            });
          },
        ),
        SizedBox(
          height: 32,
        ),
        DefaultDropdown(
          value: depositBank,
          errorText: depositBankError,
          label: "deposit_bank",
          note: "deposit_bank",
          readOnly: state.initState.role == 'ROLE_STORE',
          listValues: depositBanks!,
          onChanged: (value) {
            state.initState.role != 'ROLE_STORE'
                ? setState(() {
                    depositBank = value;
                  })
                : null;
          },
        ),
        SizedBox(
          height: 32,
        ),
        InputForm(
          label: 'account_no',
          note: 'depositer_acc_no',
          readOnly: state.initState.role == 'ROLE_STORE',
          controller: accNoController,
        ),
        SizedBox(
          height: 32,
        ),
        InputForm(
          label: 'holder_name',
          note: 'acc_holder_name',
          readOnly: state.initState.role == 'ROLE_STORE',
          controller: holderNameController,
        ),
      ],
    );
  }

  _clearFields() {
    setState(() {
      accNameController.clear();
      depositBank = null;
      depositBankCode = null;
      transactionType = null;
      transactionTypeCode = null;
      holderNameController.clear();
      accNoController.clear();
      selectedCard = -1;
    });
  }

  _onSelectCard(int i, List accountInfo) {
    setState(() {
      selectedCard = i;
      accNameController =
          TextEditingController(text: accountInfo[i]['accountName'].toString());
      transactionType = code2Text(
          'transfer', accountInfo[i]['transferMethodCode'].toString());
      accNoController =
          TextEditingController(text: accountInfo[i]['accountNo'].toString());
      holderNameController =
          TextEditingController(text: accountInfo[i]['holderName'].toString());
      depositBank = accountInfo[i]['depositBank'].toString();
      accountId = accountInfo[i]['accountId'].toString();
    });
  }

  _onRemoveCard(int i, List accountInfo) async {
    showPopup(
        context,
        DefaultModal(
          title: 'remove_account',
          subTitle: 'remove_account_detail',
          onCancel: () async {
            appStore.dispatch(NavigateToAction(to: 'up'));
          },
          onConfirm: () async {
            final res = await appStore.dispatch(
                GetStoreAccountMethodRemoveAction(
                    storeAccountMethodRemoveReq: StoreAccountMethodRemoveReq(
                        accountId: accountInfo[i]['accountId'])));

            if (res) {
              await appStore.dispatch(GetStoreAccountListAction(
                  storeAccountListReq:
                      StoreAccountListReq(storeId: widget.storeId!)));
              appStore.dispatch(NavigateToAction(to: 'up'));
              _clearFields();
            }
          },
        ));
  }

  _addAccountMethod() async {
    if (transactionType == null || depositBank == null) {
      setState(() {
        transferModError =
            transactionType == null ? "select_transfer_module" : null;
        depositBankError = depositBank == null ? "select_deposit_bank" : null;
      });
    } else {
      setState(() {
        transferModError = null;
        depositBankError = null;
      });
      final added = await appStore.dispatch(
        GetStoreAccountMethodAddAction(
          storeAccountMethodAddReq: StoreAccountMethodAddReq(
            storeId: widget.storeId!,
            transferMethodCode: transactionTypeCode!,
            depositBank: depositBank,
            holderName: holderNameController.text,
            accountNo: accNoController.text,
            accountName: accNameController.text,
          ),
        ),
      );

      if (added) {
        await appStore.dispatch(GetStoreAccountListAction(
            storeAccountListReq:
                StoreAccountListReq(storeId: widget.storeId!)));
        _clearFields();
      }
    }
  }

  _updateAccountMethod() async {
    final updated = await appStore.dispatch(
      GetStoreAccountMethodUpdateAction(
        storeAccountMethodUpdateReq: StoreAccountMethodUpdateReq(
            accountId: accountId!,
            transferMethodCode: transactionTypeCode!,
            holderName: holderNameController.text,
            accountNo: accNoController.text,
            accountName: accNameController.text,
            depositBank: depositBank),
      ),
    );
    if (updated) {
      await appStore.dispatch(GetStoreAccountListAction(
          storeAccountListReq: StoreAccountListReq(storeId: widget.storeId!)));
      _clearFields();
    }
  }
}

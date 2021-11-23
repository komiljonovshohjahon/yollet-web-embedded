import 'package:intl/intl.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/UI/widgets/popups/show_popup.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/utils/common/constants.dart';

class SettlementListPage extends StatefulWidget {
  const SettlementListPage({Key? key}) : super(key: key);

  @override
  State<SettlementListPage> createState() => _SettlementListPageState();
}

class _SettlementListPageState extends State<SettlementListPage> {
  GlobalKey overlayKeySettlement = GlobalKey();
  final _formSettlementKey = GlobalKey<FormState>();

  dynamic overlayEntry;

  bool tableOpen = false;
  bool filterOpen = false;

  String? paymentMethodCode;
  String? paymentMethod;

  int pageNo = 1;
  int pageSize = 10;

  List<String>? paymentMethods = [];

  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController binController = TextEditingController();

  // Future<SettlementListRes?> settlListRes() async {
  //
  // }
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        paymentMethods = [
          ...appStore
              .state.apiState.paymentMethodGlobalListRes.paymentMethodList!
              .map((e) => e['name'].toString())
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<bool> selectedItems = List<bool>.generate(
        Constants.settlementHeadNamesConst.length, (int index) => true);
    final List<String> headNamesSettlement = [];
    for (var element in Constants.settlementHeadNamesConst) {
      headNamesSettlement.add(element);
    }
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return PageInitLayout(
            state: state,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (!filterOpen)
                Row(
                  children: [
                    DefaultButton(
                        text: 'table',
                        key: overlayKeySettlement,
                        variant: ButtonVariant.GHOST,
                        sizeOfButton: ButtonSize.M,
                        icon: HeroIcons.cog,
                        isSortableTable: true,
                        sortableTableOpened: tableOpen,
                        onPressed: () async {
                          _openSortableList(state.uiState, selectedItems,
                              headNamesSettlement);
                        }),
                    const Spacer(),
                    DefaultButton(
                      text: 'download_excel',
                      onPressed: () async {
                        dynamic downRes = await appStore.dispatch(
                            GetDownloadExcelAction(DownloadState.SETTLEMENT));
                        if (downRes == null) {
                          showPopup(
                              context,
                              DefaultModal(
                                title: "Download Error!",
                                subTitle: 'Cannot download right now!',
                                buttons: [
                                  DefaultButton(
                                      text: 'Ok',
                                      onPressed: () {
                                        appStore.dispatch(
                                            NavigateToAction(to: 'up'));
                                      })
                                ],
                              ));
                        }
                      },
                      variant: ButtonVariant.PRIMARY,
                      sizeOfButton: ButtonSize.M,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    DefaultButton(
                      text: 'inquiry_filter',
                      onPressed: () {
                        openFilter();
                      },
                      variant: ButtonVariant.PRIMARY,
                      sizeOfButton: ButtonSize.M,
                    ),
                  ],
                ),
              if (filterOpen) inquiryFilter(state),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  TableTotal(
                    totalAmount: state.apiState.settlementListRes.amountSum,
                    totalCount: state.apiState.settlementListRes.itemCount,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              if (state.apiState.settlementListRes.settlementList != null &&
                  state.apiState.settlementListRes.settlementList!.isNotEmpty)
                DefaultDatatable(
                  showNumber: pageSize,
                  pageNumber: pageNo,
                  limit: state.apiState.settlementListRes.settlementList == null
                      ? 10
                      : state.apiState.settlementListRes.settlementList!.length,
                  data: state.apiState.settlementListRes.settlementList,
                  variant: TableVariants.SETTLEMENTLIST,
                  state: state,
                  sortColumnIndex: 3,
                ),
              const SizedBox(
                height: 8,
              ),
              TableButtons(
                  pageTotal: state.apiState.settlementListRes.pageTotal ?? 1,
                  page: state.apiState.settlementListRes.pageNo ?? 1,
                  pageSize: state.apiState.settlementListRes.pageSize ?? 10,
                  onChanged: (value) async {
                    setState(() {
                      pageSize = int.tryParse(value)!;
                    });
                    await appStore.dispatch(
                      GetSettlementListAction(
                        settlementListReq: SettlementListReq(
                          pageSize: pageSize,
                          pageNo: state.apiState.settlementListRes.pageNo!,
                          paymentMethodCode: paymentMethodCode,
                          businessRegistrationNo: binController.text,
                          startDate: fromDate.text,
                          endDate: toDate.text,
                        ),
                      ),
                    );
                  },
                  previousButtonPressed: () async {
                    if (state.apiState.settlementListRes.pageNo! > 1) {
                      await appStore.dispatch(
                        GetSettlementListAction(
                          settlementListReq: SettlementListReq(
                            pageSize: pageSize,
                            pageNo:
                                state.apiState.settlementListRes.pageNo! - 1,
                            paymentMethodCode: paymentMethodCode,
                            businessRegistrationNo: binController.text,
                            startDate: fromDate.text,
                            endDate: toDate.text,
                          ),
                        ),
                      );
                    }
                  },
                  nextButtonPressed: () async {
                    if (state.apiState.settlementListRes.pageNo! <
                        state.apiState.settlementListRes.pageTotal!) {
                      await appStore.dispatch(GetSettlementListAction(
                          settlementListReq: SettlementListReq(
                        pageNo: state.apiState.approvalListRes.pageNo! + 1,
                        pageSize: pageSize,
                        paymentMethodCode: paymentMethodCode,
                        businessRegistrationNo: binController.text,
                        startDate: fromDate.text,
                        endDate: toDate.text,
                      )));
                    }
                  },
                  stateData: state.apiState.settlementListRes),
            ]),
          );
          // });
        });
  }

  Widget inquiryFilter(AppState state) {
    return Container(
      color: ThemeColors.coolgray100,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              SizedText(
                  text: 'inquiry_filter',
                  textStyle:
                      ThemeTextRegular.lg.apply(color: ThemeColors.black)),
              const Spacer(),
              InkWell(
                child: const HeroIcon(
                  HeroIcons.x,
                  size: 24,
                  color: ThemeColors.coolgray900,
                ),
                onTap: () {
                  binController.clear();
                  fromDate.clear();
                  toDate.clear();
                  paymentMethod = null;
                  paymentMethodCode = null;
                },
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          buildInputTable(state),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultButton(
                text: 'close',
                onPressed: () {
                  closeFilter();
                },
                sizeOfButton: ButtonSize.M,
                variant: ButtonVariant.GHOST,
              ),
              const SizedBox(
                width: 8,
              ),
              DefaultButton(
                  text: 'search',
                  onPressed: () async {
                    if (_formSettlementKey.currentState!.validate()) {
                      await appStore.dispatch(
                        GetSettlementListAction(
                          settlementListReq: SettlementListReq(
                            paymentMethodCode: paymentMethodCode,
                            businessRegistrationNo: binController.text,
                            pageNo: pageNo,
                            pageSize: pageSize,
                            startDate: fromDate.text,
                            endDate: toDate.text,
                          ),
                        ),
                      );
                      closeFilter();
                    }
                  },
                  sizeOfButton: ButtonSize.M,
                  variant: ButtonVariant.PRIMARY),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInputTable(AppState state) {
    return Form(
      key: _formSettlementKey,
      child: InputTable(
        verticalSpacing: 48,
        columnCount: 2,
        listOfInput: [
          InputForm(
            label: 'business',
            // validator: isNumValidator,
            controller: binController,
          ),
          DefaultDropdown(
            label: 'payment_method',
            value: paymentMethod,
            listValues: paymentMethods!,
            onChanged: (val) {
              setState(() {
                paymentMethod = val;
                String? value;
                state.apiState.paymentMethodGlobalListRes.paymentMethodList!
                    .forEach((element) {
                  if (element['name'] == val) {
                    value = element['code'];
                  }
                });
                paymentMethodCode = value;
              });
            },
          ),
          InputForm(
            label: 'from_approved_date',
            controller: fromDate,
            onTap: () {
              selectDate(context, TypeDate.from, state);
            },
            suffix: const Padding(
              padding: EdgeInsets.all(10.0),
              child: HeroIcon(
                HeroIcons.calendar,
                color: ThemeColors.coolgray600,
              ),
            ),
          ),
          InputForm(
            label: 'to_approved_date',
            controller: toDate,
            onTap: () {
              selectDate(context, TypeDate.to, state);
            },
            suffix: const Padding(
              padding: EdgeInsets.all(10.0),
              child: HeroIcon(
                HeroIcons.calendar,
                color: ThemeColors.coolgray600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openFilter() {
    setState(() {
      filterOpen = true;
    });
  }

  void closeFilter() {
    setState(() {
      filterOpen = false;
    });
    appStore.dispatch(ClearControllersAction());
  }

  String? isNumValidator(String? value) {
    if (value!.isNotEmpty && !value.isNumeric()) {
      return 'field_must_be_numeric_only';
    } else {
      return null;
    }
  }

  void selectDate(BuildContext context, TypeDate type, AppState state) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (type == TypeDate.from) {
      if (picked != null && picked != fromDate) {
        setState(() {
          fromDate = TextEditingController(
              text: DateFormat('yyyyMMdd').format(picked));
        });
      }
    } else {
      if (picked != null && picked != toDate) {
        setState(() {
          toDate = TextEditingController(
              text: DateFormat('yyyyMMdd').format(picked));
        });
      }
    }
  }

  void _openSortableList(UIState state, List<bool> selectedItems,
      List<String> headNamesSettlement) {
    if (state.overlayEntry == false) {
      tableOpen = true;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeySettlement,
        child: SortableTable(
          listType: DownloadState.SETTLEMENT,
          stateList: state.settlementHeadNames,
          headNames: headNamesSettlement,
          selectedItems: selectedItems,
        ),
      ));
    } else {
      tableOpen = false;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeySettlement,
        overlayEntry: true,
        child: SortableTable(
          listType: DownloadState.SETTLEMENT,
          stateList: state.settlementHeadNames,
          headNames: headNamesSettlement,
          selectedItems: selectedItems,
        ),
      ));
    }
  }
}

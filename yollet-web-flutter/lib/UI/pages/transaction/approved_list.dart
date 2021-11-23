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
import 'package:yollet_web/utils/format/text_2_code.dart';

class ApprovedListPage extends StatefulWidget {
  const ApprovedListPage({Key? key}) : super(key: key);

  @override
  State<ApprovedListPage> createState() => _ApprovedListStatePage();
}

class _ApprovedListStatePage extends State<ApprovedListPage> {
  GlobalKey overlayKeyApproved = GlobalKey();
  final _formApproveKey = GlobalKey<FormState>();

  dynamic overlayEntry;

  bool tableOpen = false;
  bool filterOpen = false;

  String? paymentMethodCode;
  String? paymentMethod;

  int pageNo = 1;
  int pageSize = 10;

  String? transactionTypeCode;
  String? transactionType;

  List<String>? paymentMethods = [];
  List<String>? transferTypes = [];

  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController binController = TextEditingController();
  TextEditingController approvedNoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<bool> selectedItems = List<bool>.generate(
        Constants.approvedHeadNamesConst.length, (int index) => true);
    final List<String> headNamesApproved = [];
    for (var element in Constants.approvedHeadNamesConst) {
      headNamesApproved.add(element);
    }
    return StoreConnector<AppState, AppState>(
        onInit: (store) async {
          if (store.state.apiState.paymentMethodGlobalListRes
                  .paymentMethodList !=
              null) {
            paymentMethods = [
              ...store
                  .state.apiState.paymentMethodGlobalListRes.paymentMethodList!
                  .map((e) => e['name'].toString())
            ];
          }
          if (store
                  .state.apiState.transferMethodGlobalList.transferMethodList !=
              null) {
            transferTypes = [
              ...store
                  .state.apiState.transferMethodGlobalList.transferMethodList!
                  .map((e) => e['name'].toString())
            ];
          }
        },
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
                        key: overlayKeyApproved,
                        variant: ButtonVariant.GHOST,
                        sizeOfButton: ButtonSize.M,
                        icon: HeroIcons.cog,
                        isSortableTable: true,
                        sortableTableOpened: tableOpen,
                        onPressed: () async {
                          _openSortableList(
                              state.uiState, selectedItems, headNamesApproved);
                        }),
                    const Spacer(),
                    DefaultButton(
                      text: 'download_excel',
                      onPressed: () async {
                        dynamic downRes = await appStore.dispatch(
                            GetDownloadExcelAction(DownloadState.APPROVED));
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
                    totalAmount: state.apiState.approvalListRes.amountSum,
                    totalCount: state.apiState.approvalListRes.itemCount,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              if (state.apiState.approvalListRes.approvalList != null &&
                  state.apiState.approvalListRes.approvalList!.isNotEmpty)
                DefaultDatatable(
                  showNumber: pageSize,
                  pageNumber: pageNo,
                  limit: state.apiState.approvalListRes.approvalList == null
                      ? 10
                      : state.apiState.approvalListRes.approvalList!.length,
                  data: state.apiState.approvalListRes.approvalList,
                  variant: TableVariants.APPROVEDLIST,
                  state: state,
                  sortColumnIndex: 2,
                ),
              const SizedBox(
                height: 8,
              ),
              TableButtons(
                  pageTotal: state.apiState.approvalListRes.pageTotal ?? 1,
                  page: state.apiState.approvalListRes.pageNo ?? 1,
                  pageSize: state.apiState.approvalListRes.pageSize ?? 10,
                  onChanged: (value) async {
                    setState(() {
                      pageSize = int.tryParse(value)!;
                    });
                    appStore.dispatch(
                      GetApprovalListAction(
                        approvalListReq: ApprovalListReq(
                          pageSize: pageSize,
                          pageNo: state.apiState.approvalListRes.pageNo!,
                          transactionType: transactionTypeCode,
                          paymentMethodCode: paymentMethodCode,
                          businessRegistrationNo: binController.text,
                          approvalNo: approvedNoController.text,
                          approvalAmount:
                              double.tryParse(amountController.text),
                          startDate: fromDate.text,
                          endDate: toDate.text,
                        ),
                      ),
                    );
                  },
                  previousButtonPressed: () async {
                    if (state.apiState.approvalListRes.pageNo! > 1) {
                      appStore.dispatch(
                        GetApprovalListAction(
                          approvalListReq: ApprovalListReq(
                            pageNo: state.apiState.approvalListRes.pageNo! - 1,
                            pageSize: pageSize,
                            transactionType: transactionTypeCode,
                            paymentMethodCode: paymentMethodCode,
                            businessRegistrationNo: binController.text,
                            approvalNo: approvedNoController.text,
                            approvalAmount:
                                double.tryParse(amountController.text),
                            startDate: fromDate.text,
                            endDate: toDate.text,
                          ),
                        ),
                      );
                    }
                  },
                  nextButtonPressed: () async {
                    if (state.apiState.approvalListRes.pageNo! <
                        state.apiState.approvalListRes.pageTotal!) {
                      appStore.dispatch(
                        GetApprovalListAction(
                          approvalListReq: ApprovalListReq(
                            pageNo: state.apiState.approvalListRes.pageNo! + 1,
                            pageSize: pageSize,
                            transactionType: transactionTypeCode,
                            paymentMethodCode: paymentMethodCode,
                            businessRegistrationNo: binController.text,
                            approvalNo: approvedNoController.text,
                            approvalAmount:
                                double.tryParse(amountController.text),
                            startDate: fromDate.text,
                            endDate: toDate.text,
                          ),
                        ),
                      );
                    }
                  },
                  stateData: state.apiState.approvalListRes),
            ]),
          );
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
                  setState(() {
                    binController.clear();
                    fromDate.clear();
                    toDate.clear();
                    approvedNoController.clear();
                    amountController.clear();
                    paymentMethod = null;
                    paymentMethodCode = null;
                    transactionType = null;
                    transactionTypeCode = null;
                    transactionTypeCode = null;
                  });
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
                    if (_formApproveKey.currentState!.validate()) {
                      await appStore.dispatch(
                        GetApprovalListAction(
                          approvalListReq: ApprovalListReq(
                            transactionType: transactionTypeCode,
                            paymentMethodCode: paymentMethodCode,
                            businessRegistrationNo: binController.text,
                            approvalNo: approvedNoController.text,
                            approvalAmount:
                                double.tryParse(amountController.text),
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
      key: _formApproveKey,
      child: InputTable(
        verticalSpacing: 48,
        columnCount: 2,
        listOfInput: [
          InputForm(
            label: 'bin_inn',
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
                paymentMethodCode = text2Code('payment', val);
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
          DefaultDropdown(
            label: 'tx_type',
            value: transactionType,
            listValues: transferTypes!,
            onChanged: (val) {
              setState(() {
                transactionType = val;
                // String? value;
                // state.apiState.transferMethodGlobalList.transferMethodList!
                //     .forEach((element) {
                //   if (element['name'] == val) {
                //     value = element['code'];
                //   }
                // });
                transactionTypeCode = text2Code('transfer', val);
              });
            },
          ),
          InputForm(
            label: 'approved_no',
            // validator: isNumValidator,
            controller: approvedNoController,
          ),
          InputForm(
            label: 'amount',
            validator: isNumValidator,
            controller: amountController,
            suffix: const Padding(
              padding: EdgeInsets.all(10.0),
              child: HeroIcon(
                HeroIcons.currencyPound,
                color: ThemeColors.coolgray600,
              ),
            ),
          ),
        ],
      ),
    );
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

  void _openSortableList(
      UIState state, List<bool> selectedItems, List<String> headNamesApproved) {
    if (state.overlayEntry == false) {
      tableOpen = true;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeyApproved,
        child: SortableTable(
          listType: DownloadState.APPROVED,
          stateList: state.approvedHeadNames,
          headNames: headNamesApproved,
          selectedItems: selectedItems,
        ),
      ));
    } else {
      tableOpen = false;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeyApproved,
        overlayEntry: true,
        child: SortableTable(
          listType: DownloadState.APPROVED,
          stateList: state.approvedHeadNames,
          headNames: headNamesApproved,
          selectedItems: selectedItems,
        ),
      ));
    }
  }
}

enum TypeDate { from, to }

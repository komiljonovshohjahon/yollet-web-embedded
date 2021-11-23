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

class TransferListPage extends StatefulWidget {
  const TransferListPage({Key? key}) : super(key: key);

  @override
  State<TransferListPage> createState() => _TransferListPageState();
}

class _TransferListPageState extends State<TransferListPage> {
  GlobalKey overlayKeyTransfer = GlobalKey();
  final _formTransferKey = GlobalKey<FormState>();

  dynamic overlayEntry;

  String? paymentMethodCode;
  String? paymentMethod;

  int pageNo = 1;
  int pageSize = 10;

  String? transferState;
  String? transferStateCode;
  List<String>? acquirementStates;

  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController binController = TextEditingController();
  TextEditingController transferIdController = TextEditingController();

  bool tableOpen = false;
  bool filterOpen = false;

  List<String>? paymentMethods = [];
  List<String>? states = [];

  @override
  Widget build(BuildContext context) {
    final List<bool> selectedItems = List<bool>.generate(
        Constants.transferHeadNamesConst.length, (int index) => true);
    final List<String> headNamesTransfer = [];
    for (var element in Constants.transferHeadNamesConst) {
      headNamesTransfer.add(element);
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
          acquirementStates = [
            ...Constants.acquirementStates.values.map((value) => value)
          ];
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
                        key: overlayKeyTransfer,
                        variant: ButtonVariant.GHOST,
                        sizeOfButton: ButtonSize.M,
                        icon: HeroIcons.cog,
                        isSortableTable: true,
                        sortableTableOpened: tableOpen,
                        onPressed: () async {
                          _openSortableList(
                              state.uiState, selectedItems, headNamesTransfer);
                        }),
                    const Spacer(),
                    DefaultButton(
                      text: 'download_excel',
                      onPressed: () async {
                        dynamic downRes = await appStore.dispatch(
                            GetDownloadExcelAction(DownloadState.TRANSFER));
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
                    totalAmount: state.apiState.transferListRes.amountSum,
                    totalCount: state.apiState.transferListRes.itemCount,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              if (state.apiState.transferListRes.transferList != null &&
                  state.apiState.transferListRes.transferList!.isNotEmpty)
                DefaultDatatable(
                  showNumber: pageSize,
                  pageNumber: pageNo,
                  limit: state.apiState.transferListRes.transferList == null
                      ? 10
                      : state.apiState.transferListRes.transferList!.length,
                  data: state.apiState.transferListRes.transferList,
                  variant: TableVariants.TRANSFERLIST,
                  state: state,
                  sortColumnIndex: 5,
                ),
              const SizedBox(
                height: 8,
              ),
              TableButtons(
                  pageTotal: state.apiState.transferListRes.pageTotal ?? 1,
                  page: state.apiState.transferListRes.pageNo ?? 1,
                  pageSize: state.apiState.transferListRes.pageSize ?? 10,
                  onChanged: (value) async {
                    setState(() {
                      pageSize = int.tryParse(value)!;
                    });

                    await appStore.dispatch(GetTransferListAction(
                        transferListReq: TransferListReq(
                      pageNo: state.apiState.transferListRes.pageNo,
                      paymentMethodCode: paymentMethodCode,
                      transferState: transferStateCode,
                      pageSize: pageSize,
                      startDate: fromDate.text,
                      businessRegistrationNo: binController.text,
                      endDate: toDate.text,
                    )));
                  },
                  previousButtonPressed: () async {
                    if (state.apiState.transferListRes.pageNo! > 1) {
                      await appStore.dispatch(GetTransferListAction(
                          transferListReq: TransferListReq(
                        pageNo: state.apiState.transferListRes.pageNo! - 1,
                        paymentMethodCode: paymentMethodCode,
                        transferState: transferStateCode,
                        pageSize: pageSize,
                        startDate: fromDate.text,
                        businessRegistrationNo: binController.text,
                        endDate: toDate.text,
                      )));
                    }
                  },
                  nextButtonPressed: () async {
                    if (state.apiState.transferListRes.pageNo! <
                        state.apiState.transferListRes.pageTotal!) {
                      await appStore.dispatch(GetTransferListAction(
                          transferListReq: TransferListReq(
                        pageNo: state.apiState.transferListRes.pageNo! + 1,
                        paymentMethodCode: paymentMethodCode,
                        transferState: transferStateCode,
                        pageSize: pageSize,
                        startDate: fromDate.text,
                        businessRegistrationNo: binController.text,
                        endDate: toDate.text,
                      )));
                    }
                  },
                  stateData: state.apiState.settlementListRes),
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
                    if (_formTransferKey.currentState!.validate()) {
                      await appStore.dispatch(
                        GetTransferListAction(
                          transferListReq: TransferListReq(
                            pageNo: pageNo,
                            paymentMethodCode: paymentMethodCode,
                            transferState: transferStateCode,
                            pageSize: pageSize,
                            startDate: fromDate.text,
                            businessRegistrationNo: binController.text,
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
    UIState uiState = state.uiState;
    ApiState apiState = state.apiState;
    return Form(
      key: _formTransferKey,
      child: InputTable(
        verticalSpacing: 48,
        columnCount: 2,
        listOfInput: [
          InputForm(
            label: 'bin_inn',
            // validator: isNumValidator,
            controller: binController,
          ),
          InputForm(
            label: 'transferId',
            // validator: isNumValidator,
            controller: transferIdController,
          ),
          InputForm(
            label: 'from_approved_date',
            controller: fromDate,
            onTap: () {
              selectDate(context, TypeDate.from, state);

              // DefaultDatePicker();
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

              // _openDatePicker(uiState);
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

  void _openSortableList(
      UIState state, List<bool> selectedItems, List<String> headNamesTransfer) {
    if (state.overlayEntry == false) {
      tableOpen = true;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeyTransfer,
        child: SortableTable(
          listType: DownloadState.TRANSFER,
          stateList: state.transferHeadNames,
          headNames: headNamesTransfer,
          selectedItems: selectedItems,
        ),
      ));
    } else {
      tableOpen = false;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeyTransfer,
        overlayEntry: true,
        child: SortableTable(
          listType: DownloadState.TRANSFER,
          stateList: state.transferHeadNames,
          headNames: headNamesTransfer,
          selectedItems: selectedItems,
        ),
      ));
    }
  }
}

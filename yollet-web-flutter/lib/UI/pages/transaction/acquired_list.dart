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

class AcquiredListPage extends StatefulWidget {
  const AcquiredListPage({Key? key}) : super(key: key);

  @override
  State<AcquiredListPage> createState() => _AcquiredListPageState();
}

class _AcquiredListPageState extends State<AcquiredListPage> {
  GlobalKey overlayKeyAcquired = GlobalKey();
  final _formAcquiredKey = GlobalKey<FormState>();

  dynamic overlayEntry;

  String? paymentMethodCode;
  String? paymentMethod;

  int pageNo = 1;
  int pageSize = 10;

  String? acquirementState;
  String? acquirementStateCode;
  List<String>? acquirementStates;

  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController binController = TextEditingController();

  bool tableOpen = false;
  bool filterOpen = false;

  List<String>? paymentMethods = [];
  List<String>? states = [];

  @override
  Widget build(BuildContext context) {
    final List<bool> selectedItems = List<bool>.generate(
        Constants.acquiredHeadNamesConst.length, (int index) => true);
    final List<String> headNamesAcquired = [];
    for (var element in Constants.acquiredHeadNamesConst) {
      headNamesAcquired.add(element);
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
                        key: overlayKeyAcquired,
                        variant: ButtonVariant.GHOST,
                        sizeOfButton: ButtonSize.M,
                        icon: HeroIcons.cog,
                        isSortableTable: true,
                        sortableTableOpened: tableOpen,
                        onPressed: () async {
                          _openSortableList(
                              state.uiState, selectedItems, headNamesAcquired);
                        }),
                    const Spacer(),
                    DefaultButton(
                      text: 'download_excel',
                      onPressed: () async {
                        dynamic downRes = await appStore.dispatch(
                            GetDownloadExcelAction(DownloadState.ACQUIRED));
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
                    totalAmount: state.apiState.acquirementListRes.amountSum,
                    totalCount: state.apiState.acquirementListRes.itemCount,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              if (state.apiState.acquirementListRes.acquirementList != null &&
                  state.apiState.acquirementListRes.acquirementList!.isNotEmpty)
                DefaultDatatable(
                  showNumber: pageSize,
                  pageNumber: pageNo,
                  limit:
                      state.apiState.acquirementListRes.acquirementList == null
                          ? 10
                          : state.apiState.acquirementListRes.acquirementList!
                              .length,
                  data: state.apiState.acquirementListRes.acquirementList,
                  variant: TableVariants.ACQUIREDLIST,
                  state: state,
                  sortColumnIndex: 2,
                ),
              const SizedBox(
                height: 8,
              ),
              TableButtons(
                  pageTotal: state.apiState.acquirementListRes.pageTotal ?? 1,
                  page: state.apiState.acquirementListRes.pageNo ?? 1,
                  pageSize: state.apiState.acquirementListRes.pageSize ?? 10,
                  onChanged: (value) async {
                    setState(() {
                      pageSize = int.tryParse(value)!;
                    });
                    await appStore.dispatch(GetAcquirementListAction(
                        acquirementListReq: AcquirementListReq(
                      paymentMethodCode: paymentMethodCode,
                      acquirementState: acquirementStateCode,
                      pageSize: pageSize,
                      startDate: fromDate.text,
                      businessRegistrationNo: binController.text,
                      pageNo: state.apiState.acquirementListRes.pageNo,
                      endDate: toDate.text,
                    )));
                  },
                  previousButtonPressed: () async {
                    if (state.apiState.acquirementListRes.pageNo! > 1) {
                      appStore.dispatch(
                        GetAcquirementListAction(
                          acquirementListReq: AcquirementListReq(
                            pageNo:
                                state.apiState.acquirementListRes.pageNo! - 1,
                            paymentMethodCode: paymentMethodCode,
                            acquirementState: acquirementStateCode,
                            pageSize: pageSize,
                            startDate: fromDate.text,
                            businessRegistrationNo: binController.text,
                            endDate: toDate.text,
                          ),
                        ),
                      );
                    }
                  },
                  nextButtonPressed: () async {
                    if (state.apiState.acquirementListRes.pageNo! <
                        state.apiState.acquirementListRes.pageTotal!) {
                      appStore.dispatch(
                        GetAcquirementListAction(
                          acquirementListReq: AcquirementListReq(
                            pageNo:
                                state.apiState.acquirementListRes.pageNo! + 1,
                            paymentMethodCode: paymentMethodCode,
                            acquirementState: acquirementStateCode,
                            pageSize: pageSize,
                            startDate: fromDate.text,
                            businessRegistrationNo: binController.text,
                            endDate: toDate.text,
                          ),
                        ),
                      );
                    }
                  },
                  stateData: state.apiState.acquirementListRes),
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
                    if (_formAcquiredKey.currentState!.validate()) {
                      await appStore.dispatch(
                        GetAcquirementListAction(
                          acquirementListReq: AcquirementListReq(
                            paymentMethodCode: paymentMethodCode,
                            acquirementState: acquirementStateCode,
                            pageSize: pageSize,
                            startDate: fromDate.text,
                            businessRegistrationNo: binController.text,
                            pageNo: pageNo,
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
      key: _formAcquiredKey,
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
          DefaultDropdown(
            label: 'acquirementState',
            value: acquirementState,
            listValues: acquirementStates!,
            onChanged: (val) {
              setState(() {
                acquirementState = val;
                String? value;
                for (var key in Constants.acquirementStates.keys) {
                  if (Constants.acquirementStates[key] == val) {
                    value = key;
                  }
                }
                acquirementStateCode = value;
              });
            },
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
      UIState state, List<bool> selectedItems, List<String> headNamesAcquired) {
    if (state.overlayEntry == false) {
      tableOpen = true;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeyAcquired,
        child: SortableTable(
          listType: DownloadState.ACQUIRED,
          stateList: state.acquiredHeadNames,
          headNames: headNamesAcquired,
          selectedItems: selectedItems,
        ),
      ));
    } else {
      tableOpen = false;
      appStore.dispatch(OverlayAction(
        gKey: overlayKeyAcquired,
        overlayEntry: true,
        child: SortableTable(
          listType: DownloadState.ACQUIRED,
          stateList: state.acquiredHeadNames,
          headNames: headNamesAcquired,
          selectedItems: selectedItems,
        ),
      ));
    }
  }
}

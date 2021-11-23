import 'package:yollet_web/UI/widgets/datatable/table_body.dart';
import 'package:yollet_web/Utils/common/constants.dart';
import 'package:yollet_web/Utils/format/compare_util.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/models/serialized_models/approval_details/approval_details_model_req.dart';
import 'package:yollet_web/models/serialized_models/approval_list_item/approval_list_item_model.dart';
import 'package:yollet_web/models/serialized_models/transfer_details/transfer_details_model_req.dart';
import 'package:yollet_web/models/serialized_models/transfer_settlement_list/transfer_settlement_list_model_req.dart';
import 'package:yollet_web/models/serialized_models/transfer_state_list/transfer_state_list_model_req.dart';
import 'package:yollet_web/utils/format/date_format_base.dart';
import 'package:yollet_web/utils/format/number_format_util.dart';
import 'package:yollet_web/utils/localization/localizations.dart';
import '../../template/base/template.dart';

class DefaultDatatable extends StatefulWidget {
  final TableVariants variant;
  int pageNumber;
  int showNumber;
  List? data;
  int? limit;
  int sortColumnIndex;
  List<ApprovalListItemModel>? bodyNames = [];
  AppState? state;

  DefaultDatatable({
    required this.variant,
    required this.showNumber,
    this.pageNumber = 1,
    this.data = const [],
    this.limit = 10,
    this.state,
    required this.sortColumnIndex,
  });

  @override
  _DefaultDatatableState createState() => _DefaultDatatableState();
}

class _DefaultDatatableState extends State<DefaultDatatable> {
  GlobalKey _tableKey = GlobalKey();
  List<DataColumn> _columns = [];
  List<DataRow> _rows = [];
  int len = 0;
  List<String> headNames = [];
  bool isAscending = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 5 / 6 - 32;

    List<bool> selectedItems = [];
    if (widget.state!.apiState.storeListRes.storeList != null) {
      selectedItems = List<bool>.generate(
          widget.state!.apiState.storeListRes.storeList!.length,
          (int index) => false);
    }
    _runInit(selectedItems: selectedItems);
    return TableScroller(
      width: width,
      child: DataTable(
        ///NOT SELECTED ALL => TRUE
        ///SELECTED ALL => FALSE
        onSelectAll: (value) {
          final items = widget.state!.apiState.storeListRes.storeList!
              .sublist(0, widget.limit)
              .map((e) => e['storeId'].toString())
              .toList();
          if (value!) {
            appStore.dispatch(UpdateUIAction(storeIdList: items));
          } else {
            appStore.dispatch(UpdateUIAction(storeIdList: []));
          }
        },
        key: _tableKey,
        checkboxHorizontalMargin: 35,
        sortAscending: isAscending,
        sortColumnIndex: widget.sortColumnIndex,
        columns: _columns,
        rows: _rows,
      ),
    );
  }

  //Build Row data // pass row length

  // Initializer
  _runInit({List<bool>? selectedItems}) {
    int lastItemCount = widget.pageNumber * widget.showNumber;

    if (lastItemCount > widget.data!.length) {
      lastItemCount = widget.data!.length;
    }

    int beginningItemCount = 0;
    final variant = widget.variant;
    switch (variant) {
      case TableVariants.STORELIST:
        len = widget.state!.uiState.storeHeadNames.length;
        headNames = widget.state!.uiState.storeHeadNames;
        _columns = _buildStoreColumns();
        _rows =
            _buildStoreRows(beginningItemCount, lastItemCount, selectedItems!);
        break;

      case TableVariants.APPROVEDLIST:
        len = widget.state!.uiState.approvedHeadNames.length + 1;
        headNames = widget.state!.uiState.approvedHeadNames;
        _columns = _buildApprovedColumns();
        _rows = _buildApprovedRows(beginningItemCount, lastItemCount);
        break;

      case TableVariants.ACQUIREDLIST:
        len = widget.state!.uiState.acquiredHeadNames.length;
        headNames = widget.state!.uiState.acquiredHeadNames;
        _columns = _buildAcquiredColumns();
        _rows = _buildAcquiredRows(beginningItemCount, lastItemCount);
        break;

      case TableVariants.SETTLEMENTLIST:
        len = widget.state!.uiState.settlementHeadNames.length;
        headNames = widget.state!.uiState.settlementHeadNames;
        _columns = _buildSettlementColumns();
        _rows = _buildSettlementRows(beginningItemCount, lastItemCount);
        break;

      case TableVariants.TRANSFERLIST:
        len = widget.state!.uiState.transferHeadNames.length + 1;
        headNames = widget.state!.uiState.transferHeadNames;
        _columns = _buildTransferColumns();
        _rows = _buildTransferRows(beginningItemCount, lastItemCount);
        break;

      case TableVariants.SETTLEMENTDETAILLIST:
        len = widget.state!.uiState.settlementDetailHeadNames.length;
        headNames = widget.state!.uiState.settlementDetailHeadNames;
        _columns = _buildSettlementDetailColumns();
        _rows = _buildSettlementDetailRows(beginningItemCount, lastItemCount);
        break;
    }
  }

  ///STORE
  List<DataColumn> _buildStoreColumns() {
    List<DataColumn> list = [];

    for (int i = 0; i < len; i++) {
      list.add(
        DataColumn(
          onSort: (j, _) {
            setState(() {
              headNames = widget.state!.uiState.storeHeadNames;

              widget.sortColumnIndex = j;
              if (widget.data![0][headNames[j]] is int) {
                if (isAscending == true) {
                  isAscending = false;
                  widget.data!.sort((user1, user2) =>
                      user2[headNames[j]].compareTo(user1[headNames[j]]));
                } else {
                  isAscending = true;
                  widget.data!.sort((user1, user2) =>
                      user1[headNames[j]].compareTo(user2[headNames[j]]));
                }
              } else if (widget.data![0][headNames[j]] is String) {
                if (headNames[j] == 'approvalDatetime') {
                  if (isAscending == true) {
                    isAscending = false;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user2[headNames[j]]).compareTo(
                            _parseStringToDate(user1[headNames[j]])));
                  } else {
                    isAscending = true;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user1[headNames[j]]).compareTo(
                            _parseStringToDate(user2[headNames[j]])));
                  }
                } else {
                  isAscending = !isAscending;
                  widget.data!.sort((user1, user2) {
                    return CompareUtil.compareString(
                        isAscending,
                        user1[headNames[j]].toString(),
                        user2[headNames[j]].toString());
                  });
                }
              }
            });
          },
          numeric: Constants.numericDataValues.contains(headNames[i]),
          label: Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ThemeColors.coolgray50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TableHeader(
                text: headNames[i],
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  //Store list
  List<DataRow> _buildStoreRows(
      int beginning, int ending, List<bool> selectedItems) {
    List<DataRow> list = [];

    for (int i = 0; i < widget.limit!; i++) {
      List values = [];
      List selectedChecks = [];
      for (int j = 0; j < headNames.length; j++) {
        values.add(widget.data![i][headNames[j].toString()]);
      }
      selectedChecks.add((bool? value) {});
      list.add(
        DataRow(
          selected: widget.state!.uiState.storeIdList
                  .contains(widget.data![i]['storeId'])
              ? true
              : false,
          onSelectChanged: (bool? value) {
            if (value!) {
              appStore.dispatch(UpdateUIAction(storeIdList: [
                ...widget.state!.uiState.storeIdList,
                widget.data![i]['storeId']
              ]));
            } else {
              final items = widget.state!.uiState.storeIdList;
              items.remove(widget.data![i]['storeId']);
              appStore.dispatch(UpdateUIAction(storeIdList: items));
              //
            }
          },
          cells: _buildStoreRowData(names: values, data: widget.data, id: i),
        ),
      );
    }
    return list;
  }

  _buildStoreRowData({List? names, List? data, int? id}) {
    List<DataCell> widgetList = [];
    for (int i = 0; i < names!.length; i++) {
      widgetList.add(DataCell(
        TableBody(
          text: names[i].toString(),
        ),
      ));
    }
    return widgetList;
  }

  ///APPROVED
  List<DataColumn> _buildApprovedColumns() {
    List<DataColumn> list = [];

    for (int i = 0; i < len - 1; i++) {
      list.add(
        DataColumn(
          onSort: (j, _) {
            setState(() {
              headNames = widget.state!.uiState.approvedHeadNames;

              widget.sortColumnIndex = j;
              if (widget.data![0][headNames[j]] is int) {
                if (isAscending == true) {
                  isAscending = false;
                  widget.data!.sort((user1, user2) =>
                      user2[headNames[j]].compareTo(user1[headNames[j]]));
                } else {
                  isAscending = true;
                  widget.data!.sort((user1, user2) =>
                      user1[headNames[j]].compareTo(user2[headNames[j]]));
                }
              } else if (widget.data![0][headNames[j]] is String) {
                if (headNames[j] == 'approvalDatetime') {
                  if (isAscending == true) {
                    isAscending = false;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user2[headNames[j]]).compareTo(
                            _parseStringToDate(user1[headNames[j]])));
                  } else {
                    isAscending = true;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user1[headNames[j]]).compareTo(
                            _parseStringToDate(user2[headNames[j]])));
                  }
                } else {
                  isAscending = !isAscending;
                  widget.data!.sort((user1, user2) {
                    return CompareUtil.compareString(
                        isAscending,
                        user1[headNames[j]].toString(),
                        user2[headNames[j]].toString());
                  });
                }
              }
            });
          },
          numeric: Constants.numericDataValues.contains(headNames[i]),
          label: Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ThemeColors.coolgray50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TableHeader(
                text: headNames[i],
              ),
            ),
          ),
        ),
      );
    }
    list.add(
      DataColumn(
        label: Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ThemeColors.coolgray50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TableHeader(
              text: 'details',
            ),
          ),
        ),
      ),
    );
    return list;
  }

  List<DataRow> _buildApprovedRows(int beginning, int ending) {
    List<DataRow> list = [];
    for (beginning; beginning < ending; beginning++) {
      List values = [];
      for (int j = 0; j < headNames.length; j++) {
        //   if (headNames[j] == 'approvalDatetime') {
        //     values.add(
        //         datetimeFormat(widget.data![beginning][headNames[j]].toString()));
        //   } else if (headNames[j] == 'transactionType') {
        //     values.add(Constants
        //         .txTypes[widget.data![beginning][headNames[j].toString()]]);
        //   } else if (headNames[j] == 'approvalAmount') {
        //     values.add(CurrencyFormatter.noSymbolCurrency
        //         .format(widget.data![beginning][headNames[j]])
        //         .toString());
        //   } else {
        //
        //   values.add(widget.data![beginning][headNames[j].toString()]);
        //   }
        //REMOVE THIS
        values.add(widget.data![beginning][headNames[j].toString()]);
      }
      values.add('details');
      list.add(DataRow(
        cells: _buildApprovedRowData(
            names: values, data: widget.data, id: beginning),
      ));
    }
    return list;
  }

  _buildApprovedRowData({List? names, List? data, int? id}) {
    List<DataCell> widgetList = [];
    for (int i = 0; i < names!.length - 1; i++) {
      widgetList.add(DataCell(
        TableBody(
          text: names[i].toString(),
        ),
      ));
    }
    widgetList.add(
      DataCell(
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              const HeroIcon(
                HeroIcons.archive,
                color: ThemeColors.orange500,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'detail',
                style:
                    ThemeTextRegular.sm.copyWith(color: ThemeColors.orange500),
              ),
            ],
          ),
        ),
        onTap: () async {
          await appStore.dispatch(GetApprovalDeatilsAction(
              approvalDetailsReq: ApprovalDetailsReq(
                  transactionId: data![id!]['transactionId'].toString())));

          appStore.dispatch(
            NavigateToAction(
              to: AppRoutes.RouteToApprovedDetail,
              arguments: {'id': data[id]['transactionId'].toString()},
            ),
          );
        },
      ),
    );

    return widgetList;
  }

  ///ACQUIRED
  List<DataColumn> _buildAcquiredColumns() {
    List<DataColumn> list = [];

    for (int i = 0; i < len; i++) {
      list.add(
        DataColumn(
          onSort: (i, _) {
            setState(() {
              headNames = widget.state!.uiState.acquiredHeadNames;

              widget.sortColumnIndex = i;
              if (widget.data![0][headNames[i]] is int) {
                if (isAscending == true) {
                  isAscending = false;
                  widget.data!.sort((user1, user2) =>
                      user2[headNames[i]].compareTo(user1[headNames[i]]));
                } else {
                  isAscending = true;
                  widget.data!.sort((user1, user2) =>
                      user1[headNames[i]].compareTo(user2[headNames[i]]));
                }
              } else if (widget.data![0][headNames[i]] is String) {
                if (headNames[i] == 'approvalDatetime') {
                  if (isAscending == true) {
                    isAscending = false;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user2[headNames[i]]).compareTo(
                            _parseStringToDate(user1[headNames[i]])));
                  } else {
                    isAscending = true;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user1[headNames[i]]).compareTo(
                            _parseStringToDate(user2[headNames[i]])));
                  }
                } else {
                  isAscending = !isAscending;
                  widget.data!.sort((user1, user2) {
                    return CompareUtil.compareString(
                        isAscending,
                        user1[headNames[i]].toString(),
                        user2[headNames[i]].toString());
                  });
                }
              }
            });
          },
          numeric: Constants.numericDataValues.contains(headNames[i]),
          label: Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ThemeColors.coolgray50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TableHeader(
                text: headNames[i],
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  List<DataRow> _buildAcquiredRows(int beginning, int ending) {
    List<DataRow> list = [];

    for (beginning; beginning < ending; beginning++) {
      List values = [];
      for (int j = 0; j < headNames.length; j++) {
        // if (headNames[j] == 'approvalDatetime') {
        //   values.add(
        //       datetimeFormat(widget.data![beginning][headNames[j]].toString()));
        // } else if (headNames[j] == 'requestDatetime') {
        //   values.add(datetimeFormat(
        //       widget.data![beginning][headNames[j]].toString(),
        //       onlyDate: true));
        // } else if (headNames[j] == 'completeDatetime') {
        //   values.add(datetimeFormat(
        //       widget.data![beginning][headNames[j]].toString(),
        //       onlyDate: true));
        // } else if (headNames[j] == 'transactionType') {
        //   values.add(Constants
        //       .txTypes[widget.data![beginning][headNames[j].toString()]]);
        // } else if (headNames[j] == 'acquirementState') {
        //   values.add(Constants.acquirementStates[widget.data![beginning]
        //       [headNames[j].toString()]]);
        // } else if (headNames[j] == 'approvalAmount') {
        //   values.add(CurrencyFormatter.noSymbolCurrency
        //       .format(widget.data![beginning][headNames[j]])
        //       .toString());
        // } else {
        //   values.add(widget.data![beginning][headNames[j].toString()]);
        // }
        //REMOVE THIS
        values.add(widget.data![beginning][headNames[j].toString()]);
      }
      list.add(DataRow(
        cells: _buildAcquiredRowData(
            names: values, data: widget.data, id: beginning),
      ));
    }

    return list;
  }

  _buildAcquiredRowData({List? names, List? data, int? id}) {
    List<DataCell> widgetList = [];

    for (int i = 0; i < names!.length; i++) {
      widgetList.add(DataCell(
        TableBody(
          text: names[i].toString(),
        ),
      ));
    }
    return widgetList;
  }

  ///SETTLEMENT
  List<DataColumn> _buildSettlementColumns() {
    List<DataColumn> list = [];
    for (int j = 0; j < len; j++) {
      list.add(
        DataColumn(
          onSort: (i, _) {
            setState(() {
              headNames = widget.state!.uiState.settlementHeadNames;

              widget.sortColumnIndex = i;
              if (widget.data![0][headNames[i]] is int) {
                if (isAscending == true) {
                  isAscending = false;
                  widget.data!.sort((user1, user2) =>
                      user2[headNames[i]].compareTo(user1[headNames[i]]));
                } else {
                  isAscending = true;
                  widget.data!.sort((user1, user2) =>
                      user1[headNames[i]].compareTo(user2[headNames[i]]));
                }
              } else if (widget.data![0][headNames[i]] is String) {
                if (headNames[i] == 'approvalDatetime') {
                  if (isAscending == true) {
                    isAscending = false;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user2[headNames[i]]).compareTo(
                            _parseStringToDate(user1[headNames[i]])));
                  } else {
                    isAscending = true;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user1[headNames[i]]).compareTo(
                            _parseStringToDate(user2[headNames[i]])));
                  }
                } else {
                  isAscending = !isAscending;
                  widget.data!.sort((user1, user2) {
                    return CompareUtil.compareString(
                        isAscending,
                        user1[headNames[i]].toString(),
                        user2[headNames[i]].toString());
                  });
                }
              }
            });
          },
          numeric: Constants.numericDataValues.contains(headNames[j]),
          label: Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ThemeColors.coolgray50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TableHeader(
                text: headNames[j],
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  List<DataRow> _buildSettlementRows(int beginning, int ending) {
    List<DataRow> list = [];
    for (beginning; beginning < ending; beginning++) {
      List values = [];
      for (int j = 0; j < headNames.length; j++) {
        // if (headNames[j] == 'settlementDatetime') {
        //   values.add(datetimeFormat(
        //       widget.data![beginning][headNames[j]].toString(),
        //       onlyDate: true));
        //
        //   ///TODO:
        // } else if (headNames[j] == 'expectedTransferDate') {
        //   values.add(datetimeFormat(
        //       widget.data![beginning][headNames[j]].toString(),
        //       onlyDate: true));
        // } else if (headNames[j] == 'transferDate') {
        //   values.add(datetimeFormat(
        //       widget.data![beginning][headNames[j]].toString(),
        //       onlyDate: true));
        //     ///TODO:
        //   } else if (headNames[j] == 'settlementAmount') {
        //     values.add(CurrencyFormatter.noSymbolCurrency
        //         .format(widget.data![beginning][headNames[j]])
        //         .toString());
        //   } else if (headNames[j] == 'settlementFee') {
        //     values.add(CurrencyFormatter.noSymbolCurrency
        //         .format(widget.data![beginning][headNames[j]])
        //         .toString());
        //   } else if (headNames[j] == 'settlementTax') {
        //     values.add(CurrencyFormatter.noSymbolCurrency
        //         .format(widget.data![beginning][headNames[j]])
        //         .toString());
        //
        //   } else if (headNames[j] == 'depositAmount') {
        //     values.add(CurrencyFormatter.noSymbolCurrency
        //         .format(widget.data![beginning][headNames[j]])
        //         .toString());
        // } else {
        //   values.add(widget.data![beginning][headNames[j].toString()]);
        // }
        values.add(widget.data![beginning][headNames[j].toString()]);
      }
      list.add(DataRow(
        cells: _buildSettlementRowData(
            names: values, data: widget.data, id: beginning),
      ));
    }
    return list;
  }

  _buildSettlementRowData({List? names, List? data, int? id}) {
    List<DataCell> widgetList = [];
    for (int i = 0; i < names!.length; i++) {
      widgetList.add(DataCell(
        TableBody(
          text: names[i].toString(),
        ),
      ));
    }
    return widgetList;
  }

  ///SETTLEMENT DETAIL
  List<DataColumn> _buildSettlementDetailColumns() {
    List<DataColumn> list = [];
    for (int j = 0; j < len; j++) {
      list.add(
        DataColumn(
          onSort: (i, _) {
            setState(() {
              headNames = widget.state!.uiState.settlementDetailHeadNames;

              widget.sortColumnIndex = i;
              if (widget.data![0][headNames[i]] is int) {
                if (isAscending == true) {
                  isAscending = false;
                  widget.data!.sort((user1, user2) =>
                      user2[headNames[i]].compareTo(user1[headNames[i]]));
                } else {
                  isAscending = true;
                  widget.data!.sort((user1, user2) =>
                      user1[headNames[i]].compareTo(user2[headNames[i]]));
                }
              } else if (widget.data![0][headNames[i]] is String) {
                if (headNames[i] == 'approvalDatetime') {
                  if (isAscending == true) {
                    isAscending = false;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user2[headNames[i]]).compareTo(
                            _parseStringToDate(user1[headNames[i]])));
                  } else {
                    isAscending = true;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user1[headNames[i]]).compareTo(
                            _parseStringToDate(user2[headNames[i]])));
                  }
                } else {
                  isAscending = !isAscending;
                  widget.data!.sort((user1, user2) {
                    return CompareUtil.compareString(
                        isAscending,
                        user1[headNames[i]].toString(),
                        user2[headNames[i]].toString());
                  });
                }
              }
            });
          },
          numeric: Constants.numericDataValues.contains(headNames[j]),
          label: Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ThemeColors.coolgray50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TableHeader(
                text: headNames[j],
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  List<DataRow> _buildSettlementDetailRows(int beginning, int ending) {
    List<DataRow> list = [];
    for (beginning; beginning < ending; beginning++) {
      List values = [];
      for (int j = 0; j < headNames.length; j++) {
        // if (headNames[j] == 'settlementDatetime') {
        //   values.add(datetimeFormat(
        //       widget.data![beginning][headNames[j]].toString(),
        //       onlyDate: true));
        // } else if (headNames[j] == 'approvalDatetime') {
        //   values.add(
        //       datetimeFormat(widget.data![beginning][headNames[j]].toString()));
        // } else {
        //   values.add(widget.data![beginning][headNames[j].toString()]);
        // }
        //REMOVE THIS

        values.add(widget.data![beginning][headNames[j].toString()]);
      }
      list.add(DataRow(
        cells: _buildSettlementDetailRowData(
            names: values, data: widget.data, id: beginning),
      ));
    }
    return list;
  }

  _buildSettlementDetailRowData({List? names, List? data, int? id}) {
    List<DataCell> widgetList = [];
    for (int i = 0; i < names!.length; i++) {
      widgetList.add(DataCell(
        TableBody(
          text: names[i].toString(),
        ),
      ));
    }
    return widgetList;
  }

  ///TRANSFER
  List<DataColumn> _buildTransferColumns() {
    List<DataColumn> list = [];
    for (int i = 0; i < len - 1; i++) {
      list.add(
        DataColumn(
          onSort: (j, _) {
            setState(() {
              headNames = widget.state!.uiState.transferHeadNames;

              widget.sortColumnIndex = j;
              if (widget.data![0][headNames[j]] is int) {
                if (isAscending == true) {
                  isAscending = false;
                  widget.data!.sort((user1, user2) =>
                      user2[headNames[j]].compareTo(user1[headNames[j]]));
                } else {
                  isAscending = true;
                  widget.data!.sort((user1, user2) =>
                      user1[headNames[j]].compareTo(user2[headNames[j]]));
                }
              } else if (widget.data![0][headNames[j]] is String) {
                if (headNames[j] == 'updateDatetime') {
                  if (isAscending == true) {
                    isAscending = false;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user2[headNames[j]]).compareTo(
                            _parseStringToDate(user1[headNames[j]])));
                  } else {
                    isAscending = true;
                    widget.data!.sort((user1, user2) =>
                        _parseStringToDate(user1[headNames[j]]).compareTo(
                            _parseStringToDate(user2[headNames[j]])));
                  }
                } else {
                  isAscending = !isAscending;
                  widget.data!.sort((user1, user2) {
                    return CompareUtil.compareString(
                        isAscending,
                        user1[headNames[j]].toString(),
                        user2[headNames[j]].toString());
                  });
                }
              }
            });
          },
          numeric: Constants.numericDataValues.contains(headNames[i]),
          label: Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ThemeColors.coolgray50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TableHeader(
                text: headNames[i],
              ),
            ),
          ),
        ),
      );
    }
    list.add(
      DataColumn(
        label: Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ThemeColors.coolgray50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TableHeader(
              text: 'details',
            ),
          ),
        ),
      ),
    );
    return list;
  }

  List<DataRow> _buildTransferRows(int beginning, int ending) {
    List<DataRow> list = [];
    for (beginning; beginning < ending; beginning++) {
      List values = [];
      for (int j = 0; j < headNames.length; j++) {
        // if (headNames[j] == 'expectedTransferDatetime') {
        //   values.add(datetimeFormat(
        //       widget.data![beginning][headNames[j]].toString(),
        //       onlyDate: true));
        // } else if (headNames[j] == 'transferDatetime') {
        //   values.add(datetimeFormat(
        //       widget.data![beginning][headNames[j]].toString(),
        //       onlyDate: true));
        // } else if (headNames[j] == 'updateDatetime') {
        //   values.add(datetimeFormat(
        //       widget.data![beginning][headNames[j]].toString(),
        //       onlyDate: true));
        // } else {
        //   values.add(widget.data![beginning][headNames[j].toString()]);
        // }
        //REMOVE THIS
        values.add(widget.data![beginning][headNames[j].toString()]);
      }
      values.add('details');
      list.add(DataRow(
        cells: _buildTransferRowData(
            names: values, data: widget.data, id: beginning),
      ));
    }

    return list;
  }

  _buildTransferRowData({List? names, List? data, int? id}) {
    List<DataCell> widgetList = [];
    for (int i = 0; i < names!.length - 1; i++) {
      widgetList.add(DataCell(
        TableBody(
          text: names[i].toString(),
        ),
      ));
    }
    widgetList.add(
      DataCell(
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              const HeroIcon(
                HeroIcons.archive,
                color: ThemeColors.orange500,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'detail',
                style:
                    ThemeTextRegular.sm.copyWith(color: ThemeColors.orange500),
              ),
            ],
          ),
        ),
        onTap: () async {
          await appStore.dispatch(GetTransferDetailAction(
              transferDetailsReq: TransferDetailsReq(
                  transferId: data![id!]['transferId'].toString())));
          await appStore.dispatch(GetTransferSettlementListAction(
              transferSettlementListReq: TransferSettlementListReq(
                  transferId: data[id]['transferId'].toString())));
          await appStore.dispatch(GetTransferStateListAction(
              transferStateListReq: TransferStateListReq(
                  transferId: data[id]['transferId'].toString())));

          appStore.dispatch(NavigateToAction(
              to: AppRoutes.RouteToTransferDetail,
              arguments: {'id': data[id]['transferId'].toString()}));
        },
      ),
    );

    return widgetList;
  }

  //All list except Store because Store list needs to be selectable
  // List<DataColumn> _buildColumns() {
  //   List<DataColumn> list = [];
  //   for (int i = 0; i < len; i++) {
  //     list.add(
  //       DataColumn(
  //         onSort: _onSort,
  //         numeric: Constants.numericDataValues.contains(headNames[i]),
  //         label: Expanded(
  //           child: DecoratedBox(
  //             decoration: BoxDecoration(
  //               color: ThemeColors.coolgray50,
  //               borderRadius: BorderRadius.circular(6),
  //             ),
  //             child: TableHeader(
  //               text: headNames[i].toUpperCase(),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return list;
  // }

  // List<DataRow> _buildRows(int beginning, int ending) {
  //   List<DataRow> list = [];
  //   for (beginning; beginning < ending; beginning++) {
  //     List values = [];
  //     List bodyList = widget.data![beginning].values.toList();
  //     for (int j = 0; j < headNames.length; j++) {
  //       values.add(widget.data![beginning][headNames[j].toString()]);
  //     }
  //     list.add(DataRow(
  //       cells: _buildRowData(names: values),
  //     ));
  //   }
  //   return list;
  // }

  _onSort(int index, bool ascending) {
    setState(() {
      widget.sortColumnIndex = index;
      isAscending = ascending;
    });

    widget.data!.sort((user1, user2) {
      return CompareUtil.compareString(
          ascending,
          user1.values.toList()[widget.sortColumnIndex].toString(),
          user2.values.toList()[widget.sortColumnIndex].toString());
    });
  }

  _parseStringToDate(String date) {
    List listOfChar = date.split('');
    for (int index = 0; index < listOfChar.length; index++) {
      if (index == 3) {
        listOfChar.insert(4, '-');
      } else if (index == 6) {
        listOfChar.insert(7, '-');
      } else if (index == 9) {
        listOfChar.insert(10, 'T');
      } else if (index == 12) {
        listOfChar.insert(13, ':');
      } else if (index == 15) {
        listOfChar.insert(16, ':');
      }
    }
    return DateTime.parse(listOfChar.join());
  }
}

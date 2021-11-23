import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';

//import 'dart:html' as html;

import 'package:yollet_web/models/serialized_models/model_exporter.dart';
import 'package:yollet_web/utils/format/date_format_base.dart';
import 'package:yollet_web/utils/format/state_identifier.dart';

class TransferDetailPage extends StatelessWidget {
  String? transferId;
  TransferDetailPage({Key? key, this.transferId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          double width = (MediaQuery.of(context).size.width * 5 / 6) * 0.7;
          return SingleChildScrollView(
            child: Container(
              width: width,
              color: ThemeColors.transparent,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        decoration: const BoxDecoration(
                          color: ThemeColors.white,
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(top: 16),
                          decoration: const BoxDecoration(
                              color: ThemeColors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: ThemeColors.orange500,
                                    spreadRadius: 0,
                                    offset: Offset(0, -4)),
                              ]),
                          child: Column(
                            children: [
                              SizedText(
                                text: 'detail_info',
                                textStyle: ThemeTextSemiBold.xxs
                                    .apply(color: ThemeColors.coolgray400),
                              ),
                              SizedText(
                                text: datetimeFormat(
                                    state.apiState.transferDetailsRes
                                        .transferDatetime
                                        .toString(),
                                    onlyDate: true),
                                textStyle: ThemeTextRegular.sm
                                    .apply(color: ThemeColors.coolgray800),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(24),
                    color: ThemeColors.white,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: ThemeColors.orange100,
                          child: HeroIcon(
                            HeroIcons.trendingUp,
                            color: ThemeColors.orange500,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedText(
                              text: stateIdentify(state
                                  .apiState.transferDetailsRes.transferState!),
                              textStyle: ThemeTextMedium.xl2
                                  .apply(color: ThemeColors.coolgray700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        _buildHead('receiving_info'),
                        Column(
                          children: [
                            _buildBodyRow({
                              'StoreName': state.apiState.transferDetailsRes
                                      .deposit!['storeName'] ??
                                  'null',
                              'BIN/INN': state.apiState.transferDetailsRes
                                      .deposit!['businessRegistrationNo'] ??
                                  'null'
                            }, width),
                            _buildBodyRow({
                              'Bank': state.apiState.transferDetailsRes
                                      .deposit!['bankName'] ??
                                  'null',
                              'Account': state.apiState.transferDetailsRes
                                      .deposit!['accountNo'] ??
                                  'null'
                            }, width),
                            _buildBodyRow({
                              'Amount': state
                                  .apiState.transferDetailsRes.depositAmount
                                  .toString(),
                              'Transfer date': state.apiState.transferDetailsRes
                                      .transferDatetime ??
                                  'null'
                            }, width),
                            _buildBodyRow(
                                {'Approved Amnt.': 'null', 'Price': 'null'},
                                width),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        _buildHead('withdrawal_account'),
                        Column(
                          children: [
                            _buildBodyRow({
                              'Bank': state.apiState.transferDetailsRes
                                      .withdrawal!['bankName'] ??
                                  'null',
                              'Account': state.apiState.transferDetailsRes
                                      .withdrawal!['accountNo'] ??
                                  'null'
                            }, width),
                            _buildBodyRow({
                              'Sender': state.apiState.transferDetailsRes
                                      .withdrawal!['senderName'] ??
                                  'null',
                              'BIN/IIN': state.apiState.transferDetailsRes
                                      .withdrawal!['businessRegistrationNo'] ??
                                  'null'
                            }, width),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        _buildHead('settlement_list'),
                        buildDataTable(
                            state.apiState.transferSettlementListRes
                                .settlementList![0].keys
                                .toList(),
                            state.apiState.transferSettlementListRes
                                .settlementList!,
                            width,
                            context),

                        const SizedBox(
                          height: 24,
                        ),

                        _buildHead('state_history'),
                        buildDataTable(
                            state.apiState.transferStateListRes.stateList![0]
                                .keys
                                .toList(),
                            state.apiState.transferStateListRes.stateList!,
                            width,
                            context),

                        const SizedBox(
                          height: 24,
                        ),
                        // dataTablesWidget(state.apiState),
                        const SizedBox(
                          height: 24,
                        ),
                        DefaultButton(
                          text: 'back',
                          onPressed: () {
                            appStore.dispatch(NavigateToAction(
                                to: AppRoutes.RouteToTransferList,
                                replace: true));
                          },
                          variant: ButtonVariant.GHOST,
                          sizeOfButton: ButtonSize.M,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget buildDataTable(
      List<String> keysList, List data, double width, BuildContext context) {
    return TableScroller(
      width: width - 48,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: ThemeColors.white),
        child: DataTable(
          decoration: BoxDecoration(
              // boxShadow: ThemeShadows.shadow,
              border: Border.all(color: ThemeColors.white, width: 1)),
          headingRowHeight: 40,
          headingRowColor: MaterialStateProperty.all(ThemeColors.coolgray100),
          sortAscending: true,
          sortColumnIndex: 3,
          columns: buildColumn(keysList),
          rows: buildRow(keysList, data),
        ),
      ),
    );
  }

  List<DataColumn> buildColumn(List<String> keysList) {
    List<DataColumn> list = [];
    for (int i = 0; i < keysList.length; i++) {
      if (keysList[i] != 'sno' && keysList[i] != 'paymentMethodCode') {
        list.add(DataColumn(
            label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: SizedText(
            text: keysList[i],
            textStyle: ThemeTextSemiBold.xxs,
          ),
        )));
      }
    }
    return list;
  }

  List<DataRow> buildRow(List<String> keysList, List data) {
    List<DataRow> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(DataRow(cells: buildCell(keysList, data[i])));
    }
    return list;
  }

  List<DataCell> buildCell(List<String> keysList, dynamic data) {
    List<DataCell> list = [];
    for (int i = 0; i < keysList.length; i++) {
      if (keysList[i] != 'sno' && keysList[i] != 'paymentMethodCode') {
        list.add(DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: SizedText(
            text: data[keysList[i]].toString(),
            textStyle: ThemeTextRegular.sm,
          ),
        )));
      }
    }
    return list;
  }

  Column dataTablesWidget(ApiState state) {
    final deposit = state.transferDetailsRes.deposit!;
    final withdrawal = state.transferDetailsRes.withdrawal;
    final detail = state.transferDetailsRes;
    final settlementList = state.transferSettlementListRes.settlementList;

    return Column(
      children: [
        SizedText(
          text: 'receiving_info',
          textStyle: ThemeTextRegular.lg.apply(color: ThemeColors.coolgray900),
        ),
        const SizedBox(
          height: 8,
        ),
        // DataTable(
        //     decoration: BoxDecoration(
        //         border: Border.all(width: 0, color: Colors.transparent)),
        //     headingRowColor: MaterialStateProperty.all(Colors.transparent),
        //     headingRowHeight: 56,
        //     dataRowHeight: 56,
        //     dividerThickness: 1,
        //     columns: dataColumnList({
        //       'store_name': deposit['storeName'],
        //       'bin_inn': deposit['businessRegistrationNo'],
        //     }),
        //     rows: [
        //       DataRow(
        //           cells: dataRowCellList({
        //         'bank': deposit['bankName'],
        //         'account': deposit['accountNo']
        //       })),
        //       DataRow(
        //           cells: dataRowCellList({
        //         'amount': deposit['bankName'],
        //         'transfer_date': deposit['bankName']
        //       })),
        //       DataRow(
        //           cells: dataRowCellList({
        //         'approved_amt': detail.depositAmount.toString(),
        //         'price': deposit['bankName']
        //       })),
        //     ]),
        const SizedBox(
          height: 24,
        ),
        SizedText(
          text: 'withdrawal_account',
          textStyle: ThemeTextRegular.lg.apply(color: ThemeColors.coolgray900),
        ),
        const SizedBox(
          height: 8,
        ),
        // DataTable(
        //     decoration: BoxDecoration(
        //         border: Border.all(width: 0, color: Colors.transparent)),
        //     headingRowColor: MaterialStateProperty.all(Colors.transparent),
        //     headingRowHeight: 56,
        //     dataRowHeight: 56,
        //     dividerThickness: 1,
        //     columns: dataColumnList({
        //       'bank': withdrawal!['bankName'],
        //       'account': withdrawal['accountNo'],
        //     }),
        //     rows: [
        //       DataRow(
        //           cells: dataRowCellList({
        //         'sender': withdrawal['senderName'],
        //         'bin_inn': withdrawal['businessRegistrationNo']
        //       })),
        //     ]),
        const SizedBox(
          height: 24,
        ),
        SizedText(
          text: 'settlement_list',
          textStyle: ThemeTextRegular.lg.apply(color: ThemeColors.coolgray900),
        ),
        const SizedBox(
          height: 8,
        ),
        // DataTable(
        //   decoration: BoxDecoration(
        //       border: Border.all(width: 0, color: Colors.transparent)),
        //   headingRowColor: MaterialStateProperty.all(ThemeColors.coolgray100),
        //   headingRowHeight: 56,
        //   dataRowHeight: 56,
        //   dividerThickness: 1,
        //   columns: _buildSettlementList(settlementList!),
        //   rows: [
        //     DataRow(
        //       cells: dataRowList(
        //         [
        //           'SID_0001',
        //           'KSNETPG',
        //           '5',
        //           '5,000 원',
        //           '2021.07.01 21:00:00',
        //         ],
        //       ),
        //     ),
        //     DataRow(
        //       cells: dataRowList(
        //         [
        //           'A123456789012345',
        //           'KSNETPG',
        //           '10',
        //           '5,000 원',
        //           '2021.07.01 21:00:00',
        //         ],
        //       ),
        //     ),
        //     DataRow(
        //       cells: dataRowList(
        //         [
        //           'A123456789012345',
        //           'KSNETPG',
        //           '2',
        //           '5,000 원',
        //           '2021.07.01 21:00:00',
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 24,
        ),
        // SizedText(
        //   text: 'state_history',
        //   textStyle: ThemeTextRegular.lg.apply(color: ThemeColors.coolgray900),
        // ),
        const SizedBox(
          height: 8,
        ),
        // DataTable(
        //   decoration: BoxDecoration(
        //       border: Border.all(width: 0, color: Colors.transparent)),
        //   headingRowColor: MaterialStateProperty.all(ThemeColors.coolgray100),
        //   headingRowHeight: 56,
        //   dataRowHeight: 56,
        //   dividerThickness: 1,
        //   columns: [
        //     DataColumn(
        //       label: Container(
        //         padding: const EdgeInsets.symmetric(
        //             vertical: 16.0, horizontal: 18.0),
        //         width: 178,
        //         child: SizedText(
        //           text: 'date',
        //           textStyle: ThemeTextSemiBold.xxs
        //               .apply(color: ThemeColors.coolgray500),
        //         ),
        //       ),
        //     ),
        //     DataColumn(
        //       label: Container(
        //         padding: const EdgeInsets.symmetric(
        //             vertical: 16.0, horizontal: 18.0),
        //         width: 160,
        //         child: SizedText(
        //           text: 'state',
        //           textStyle: ThemeTextSemiBold.xxs
        //               .apply(color: ThemeColors.coolgray500),
        //         ),
        //       ),
        //     ),
        //     DataColumn(
        //       label: Container(
        //         padding: const EdgeInsets.symmetric(
        //             vertical: 16.0, horizontal: 18.0),
        //         width: 196,
        //         child: SizedText(
        //           text: 'result',
        //           textStyle: ThemeTextSemiBold.xxs
        //               .apply(color: ThemeColors.coolgray500),
        //         ),
        //       ),
        //     ),
        //     DataColumn(
        //       label: Container(
        //         padding: const EdgeInsets.symmetric(
        //             vertical: 16.0, horizontal: 18.0),
        //         width: 269,
        //         child: SizedText(
        //           text: 'comment',
        //           textStyle: ThemeTextSemiBold.xxs
        //               .apply(color: ThemeColors.coolgray500),
        //         ),
        //       ),
        //     ),
        //   ],
        //   rows: [
        //     DataRow(
        //       cells: dataRowList(
        //         [
        //           '2021.07.01 21:00:00',
        //           'Registered',
        //           'Success',
        //           '',
        //         ],
        //       ),
        //     ),
        //     DataRow(
        //       cells: dataRowList(
        //         [
        //           '2021.07.01 21:00:00',
        //           'Approved',
        //           'Success',
        //           '9212 - System Error',
        //         ],
        //       ),
        //     ),
        //     DataRow(
        //       cells: dataRowList(
        //         [
        //           '2021.07.01 21:00:00',
        //           'in transfer',
        //           'Fail',
        //           'txID : 2281921',
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildHead(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedText(
        text: name,
        textStyle: ThemeTextRegular.lg.apply(color: ThemeColors.coolgray900),
      ),
    );
  }

  Widget _buildBodyRow(Map<String, String> data1, double width) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: ThemeColors.coolgray200))),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          SizedText(
            width: ((width - 48 - 32) / 4).roundToDouble(),
            text: data1.keys.toList()[0],
            textStyle: ThemeTextMedium.sm.apply(color: ThemeColors.coolgray500),
          ),
          SizedText(
            width: ((width - 48 - 32) / 4).roundToDouble(),
            text: data1[data1.keys.toList()[0]],
            textStyle:
                ThemeTextRegular.sm.apply(color: ThemeColors.coolgray800),
          ),
          SizedText(
            width: ((width - 48 - 32) / 4).roundToDouble(),
            text: data1.keys.toList()[1],
            textStyle: ThemeTextMedium.sm.apply(color: ThemeColors.coolgray500),
          ),
          SizedText(
            width: ((width - 48 - 32) / 4).roundToDouble(),
            text: data1[data1.keys.toList()[1]],
            textStyle:
                ThemeTextRegular.sm.apply(color: ThemeColors.coolgray800),
          ),
        ],
      ),
    );
  }

  // _buildSettlementList(List settlementList) {
  //   List<DataColumn> list = [];
  //   final keys = settlementList[0].keys;
  //   for (int i = 0; i < settlementList.length; i++) {
  //     var values = settlementList[i].values;
  //     DataColumn(
  //       label: Container(
  //         padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
  //         width: 178,
  //         child: SizedText(
  //           text: values[i].toString(),
  //           textStyle:
  //               ThemeTextSemiBold.xxs.apply(color: ThemeColors.coolgray500),
  //         ),
  //       ),
  //     );
  //   }
  //   return list;
  // }
  //
  // List<DataColumn> dataColumnList(Map<String, dynamic> mapOfValue) {
  //   List<DataColumn> list = [];
  //   for (int index = 0; index < 2; index++) {
  //     list.add(
  //       DataColumn(
  //         label: SizedBox(
  //           width: 209,
  //           child: SizedText(
  //             text: mapOfValue.keys.toList()[index].toString(),
  //             textStyle:
  //                 ThemeTextMedium.sm.apply(color: ThemeColors.coolgray500),
  //           ),
  //         ),
  //       ),
  //     );
  //     if (mapOfValue.keys.length % 2 == 0) {
  //       list.add(
  //         DataColumn(
  //           label: SizedBox(
  //             width: 209,
  //             child: SizedText(
  //               text: mapOfValue[mapOfValue.keys.toList()[index]].toString(),
  //               textStyle:
  //                   ThemeTextRegular.sm.apply(color: ThemeColors.coolgray800),
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  //
  //   return list;
  // }
  //
  // List<DataCell> dataRowCellList(Map<String, dynamic> mapOfValue) {
  //   List<DataCell> list = [];
  //   for (int index = 0; index < mapOfValue.keys.length; index++) {
  //     list.add(DataCell(
  //       SizedText(
  //         text: mapOfValue.keys.toList()[index].toString(),
  //         textStyle: ThemeTextMedium.sm.apply(color: ThemeColors.coolgray500),
  //       ),
  //     ));
  //
  //     list.add(DataCell(
  //       SizedText(
  //         text: mapOfValue[mapOfValue.keys.toList()[index]].toString(),
  //         textStyle: ThemeTextRegular.sm.apply(color: ThemeColors.coolgray800),
  //       ),
  //     ));
  //     if (mapOfValue.keys.length % 2 != 0) {
  //       list.add(const DataCell(
  //         SizedBox(),
  //       ));
  //       list.add(const DataCell(
  //         SizedBox(),
  //       ));
  //     }
  //   }
  //   return list;
  // }
  //
  // List<DataCell> dataRowList(List<String> listOfString) {
  //   List<DataCell> list = [];
  //   for (int index = 0; index < listOfString.length; index++) {
  //     list.add(
  //       DataCell(
  //         Padding(
  //           padding:
  //               const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
  //           child: SizedText(
  //             text: listOfString.toList()[index].toString(),
  //             textStyle:
  //                 ThemeTextMedium.sm.apply(color: ThemeColors.coolgray900),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return list;
  // }
}

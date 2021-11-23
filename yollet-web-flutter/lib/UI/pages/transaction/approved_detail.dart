import 'package:flutter_redux/flutter_redux.dart';
import 'package:yollet_web/mgr/navigation/routes.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/utils/format/date_format_base.dart';

class AprrovedDetailPage extends StatelessWidget {
  String? transactionId;
  AprrovedDetailPage({Key? key, this.transactionId}) : super(key: key);

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
                                    state.apiState.approvalDetailsRes
                                        .approvalDatetime
                                        .toString(),
                                    onlyDate: true),
                                textStyle: ThemeTextRegular.sm
                                    .apply(color: ThemeColors.coolgray800),
                              )
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
                              text: state
                                  .apiState.approvalDetailsRes.approvalAmount
                                  .toString(),
                              textStyle: ThemeTextMedium.xl2
                                  .apply(color: ThemeColors.coolgray700),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            SizedText(
                              text: 'KZT',
                              textStyle: ThemeTextRegular.xl2
                                  .apply(color: ThemeColors.gray400),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        _buildHead('store_information'),
                        Column(
                          children: [
                            _buildBodyRow({
                              'Store Name': state.apiState.approvalDetailsRes
                                      .store!['storeName'] ??
                                  'Store Name',
                              'Owner': state.apiState.approvalDetailsRes
                                      .store!['ownerName'] ??
                                  'Owner Name'
                            }, width),
                            _buildBodyRow({
                              'BIN/IIN': state.apiState.approvalDetailsRes
                                      .store!['businessRegistrationNo'] ??
                                  'BIN/INN',
                              'Phone No.': state.apiState.approvalDetailsRes
                                      .store!['telNo'] ??
                                  'Phone No.'
                            }, width),
                            _buildBodyRow({
                              'Address': state.apiState.approvalDetailsRes
                                      .store!['detailAdress'] ??
                                  'Address'
                            }, width),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        _buildHead('amount_information'),
                        Column(
                          children: [
                            _buildBodyRow({
                              'Transaction Type': state
                                  .apiState.approvalDetailsRes.transactionType
                                  .toString(),
                              'Approved Amt.': state
                                  .apiState.approvalDetailsRes.approvalAmount
                                  .toString()
                            }, width),
                            _buildBodyRow({
                              'Price': state
                                  .apiState.approvalDetailsRes.supllyValue
                                  .toString(),
                              'Tax.': state.apiState.approvalDetailsRes.tax
                                  .toString(),
                            }, width),
                            _buildBodyRow({
                              'Service charge': state
                                  .apiState.approvalDetailsRes.tip
                                  .toString()
                            }, width),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        _buildHead('approved_information'),
                        Column(
                          children: [
                            _buildBodyRow({
                              'Payment Type': state.apiState.approvalDetailsRes
                                      .paymentMethodCode ??
                                  'Payment Type',
                              'Approved No.': state
                                      .apiState.approvalDetailsRes.approvalNo ??
                                  'Approved No.'
                            }, width),
                            _buildBodyRow({
                              'Card No.':
                                  state.apiState.approvalDetailsRes.cardNo ??
                                      'Card No.',
                              'TID.': state
                                      .apiState.approvalDetailsRes.terminalId ??
                                  'TID',
                            }, width),
                            _buildBodyRow({
                              'Approved Date': state.apiState.approvalDetailsRes
                                      .approvalDatetime ??
                                  'Approved Date',
                              'Transation ID': transactionId.toString()
                            }, width),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        DefaultButton(
                          text: 'back',
                          onPressed: () {
                            appStore.dispatch(NavigateToAction(
                                to: AppRoutes.RouteToApprovedList,
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
          if (data1.keys.toList().length > 1)
            Row(
              children: [
                SizedText(
                  width: ((width - 48 - 32) / 4).roundToDouble(),
                  text: data1.keys.toList()[1],
                  textStyle:
                      ThemeTextMedium.sm.apply(color: ThemeColors.coolgray500),
                ),
                SizedText(
                  width: ((width - 48 - 32) / 4).roundToDouble(),
                  text: data1[data1.keys.toList()[1]],
                  textStyle:
                      ThemeTextRegular.sm.apply(color: ThemeColors.coolgray800),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

import 'package:yollet_web/UI/template/base/template.dart';

class PopupLoading extends StatelessWidget {
  dynamic onOk;
  String? title;
  String? subtitle;

  PopupLoading({
    this.title = 'reset_the_cart',
    this.subtitle = 'reset_cart_warning',
  });
  Future<bool> _onWillPop() async {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        width: 420,
        height: 241,
        decoration: BoxDecoration(
          color: ThemeColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.all(30),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            Text(
              'Loading, please wait!',
            ),
          ],
        )),
      ),
    );
  }
}

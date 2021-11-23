import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/UI/widgets/popups/popup_content.dart';

Future showPopup(
  BuildContext context,
  Widget widget, {
  bool barrierDismissible = false,
}) async {
  showGeneralDialog(
    context: context,
    transitionDuration: Duration(milliseconds: 400),
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dismiss',
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      var fadeTween = CurveTween(curve: Curves.easeInBack);
      var fadeAnimation = fadeTween.animate(animation);
      return FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => Dialog(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(24),
      // ),
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: PopupContent(
        content: widget,
      ),
    ),
  );
}

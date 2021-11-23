import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/mgr/redux/action.dart';

///
/// NavigationState
///
@immutable
class NavigationState {
  final List<String> history;

  NavigationState({
    required this.history,
  });

  factory NavigationState.initial() {
    return NavigationState(
      history: ['home'],
    );
  }

  NavigationState copyWith(
      {List<String>? history, Widget? currentBody, bool? isLoading}) {
    return NavigationState(
      history: history ?? this.history,
    );
  }

  // String? get current {
  //   var last = history.lastWhere((v) => v.isPage, orElse: () => null);
  //   return last != null ? last.name : '/';
  // }
  //
  // bool hasRoute(String name) {
  //   return history.indexWhere((i) => i.name == name) != -1;
  // }
}

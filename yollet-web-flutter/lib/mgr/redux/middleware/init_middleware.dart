import 'package:redux/redux.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';

import '../action.dart';

/// Middleware
///   UI => Action1 => Middleware => Action2 => Reducer => Store => UI
///
/// 1. middleware 로 동작하기 위해서는 MiddlewareClass<AppState> 상속 받음
/// 2. call()에서 action 별 분기
/// 3. next(Action2()) 식으로 다음 action 을 호출

class InitMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    if (action is SetLocalStorageAction) {
      return _setLocalStorageAction(store.state.initState, action, next);
    } else if (action is GetLocalStorageAction) {
      return _getLocalStorageAction(store.state.initState, action, next);
    } else {
      return next(action);
    }
  }
}

//Set Local storage
void _setLocalStorageAction(
    InitState state, SetLocalStorageAction action, NextDispatcher next) async {
  next(UpdateInitAction(token: action.value));
}

//Get Local storage
void _getLocalStorageAction(
    InitState state, GetLocalStorageAction action, NextDispatcher next) async {
  // next(UpdateInitAction(token: digest));
}

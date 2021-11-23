import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:yollet_web/mgr/redux/middleware/init_middleware.dart';
import 'package:yollet_web/mgr/redux/middleware/ui_middleware.dart';
import 'package:yollet_web/mgr/redux/states/api_state.dart';
import 'package:yollet_web/mgr/redux/states/init_state.dart';
import 'package:yollet_web/mgr/redux/states/nav_state.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';
import 'package:yollet_web/UI/template/base/template.dart';

import 'middleware/api_middleware.dart';
import 'middleware/navigation_middleware.dart';
import 'package:yollet_web/mgr/redux/reducer.dart';

export './states/api_state.dart';
export './states/init_state.dart';
export './states/nav_state.dart';
export './states/ui_state.dart';

final appStore = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    NavigationMiddleware(),
    ApiMiddleware(),
    InitMiddleware(),
    UiMiddleware(),
  ],
);

@immutable
class AppState {
  final NavigationState navigationState;
  final ApiState apiState;
  final UIState uiState;
  final InitState initState;
  AppState({
    required this.navigationState,
    required this.apiState,
    required this.uiState,
    required this.initState,
  });

  factory AppState.initial() {
    return AppState(
      navigationState: NavigationState.initial(),
      apiState: ApiState.initial(),
      uiState: UIState.initial(),
      initState: InitState.initial(),
    );
  }

  AppState copyWith({
    NavigationState? navigationState,
    ApiState? apiState,
    UIState? uiState,
    InitState? initState,
  }) {
    return AppState(
      navigationState: navigationState ?? this.navigationState,
      apiState: apiState ?? this.apiState,
      uiState: uiState ?? this.uiState,
      initState: initState ?? this.initState,
    );
  }
}

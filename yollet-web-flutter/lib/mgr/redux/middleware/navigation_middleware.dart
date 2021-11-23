import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:yollet_web/UI/template/base/template.dart';
import 'package:yollet_web/app.dart';
import 'package:yollet_web/mgr/redux/action.dart';
import 'package:yollet_web/mgr/redux/app_state.dart';
import 'package:yollet_web/mgr/redux/states/ui_state.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    if (action is NavigateToAction) {
      return _navigate(store, action, next);
    } else if (action is OverlayAction) {
      return _overlayAction(store.state.uiState, action, next);
    } else {
      return next(action);
    }
  }

  // 의도적으로 next() 하지 않음
  void _navigate(Store<AppState> store, NavigateToAction action,
      NextDispatcher next) async {
    if (store.state.uiState.overlayEntry is OverlayEntry) {
      _closeOverlay(store.state.uiState, next);
    }

    if (action.to == 'up') {
      await RouteNavigator.pop();
      return;
    }

    final path = action.arguments != null
        ? action.to! + '/' + action.arguments!['id']
        : action.to;

    void _navigate = action.replace
        ? RouteNavigator.replace(path!)
        : RouteNavigator.push(path!);

    _navigate;
  }

  void _overlayAction(
      UIState state, OverlayAction action, NextDispatcher next) {
    if (action.child == null && action.gKey == null) {
      if (state.overlayEntry is OverlayEntry) {
        _closeOverlay(state, next);
      }
    } else {
      if (action.overlayEntry == false && action.overlayEntry != null) {
        _openOverlay(action, next);
      } else {
        _closeOverlay(state, next);
      }
    }
  }

  void _closeOverlay(UIState state, NextDispatcher next) {
    state.overlayEntry.remove();
    next(UpdateUIAction(overlayEntry: false));
  }

  void _openOverlay(OverlayAction action, NextDispatcher next) {
    BuildContext? ctx = action.gKey!.currentContext;
    final RenderBox renderBox = ctx!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final height = renderBox.size.height;
    final left = position.dx;
    final top = position.dy + height + 10;

    action.overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: left,
        top: top,
        child: Material(color: Colors.transparent, child: action.child),
      );
    });
    next(UpdateUIAction(overlayEntry: action.overlayEntry));
    Overlay.of(ctx)!.insert(action.overlayEntry);
  }
}

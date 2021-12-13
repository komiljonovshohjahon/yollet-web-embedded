import 'package:statemachine/statemachine.dart';
import 'package:yollet_web/UI/pages/auth/login.dart';
//
// class Auth {
//   final authMachine = Machine<AuthStates>();
//   dynamic _current;
//
//   Auth() {
//     final idleState = authMachine.newState(AuthStates.IDLE);
//     final loginState = authMachine.newState(AuthStates.LOGIN);
//     final storeListState = authMachine.newState(AuthStates.STORELIST);
//     final storeDetailState = authMachine.newState(AuthStates.STOREDETAIL);
//
//     idleState.onEntry(() {
//       loginState.enter();
//     });
//     loginState.onEntry(() {
//       // loginState.enter();
//     });
//
//     authMachine.start();
//   }
// }
//

final authMachine = Machine<AuthStates>();
State idleState = authMachine.newState(AuthStates.IDLE);
State loginState = authMachine.newState(AuthStates.LOGIN);
State storeListState = authMachine.newState(AuthStates.STORELIST);
State storeDetailState = authMachine.newState(AuthStates.STOREDETAIL);

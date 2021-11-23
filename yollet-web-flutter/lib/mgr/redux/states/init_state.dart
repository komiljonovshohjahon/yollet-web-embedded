import 'package:yollet_web/UI/template/base/template.dart';

///
/// UI State
///
@immutable
class InitState extends ChangeNotifier {
  final bool loggedIn;
  final String token;
  final String langCode;
  final String domain;
  final String sub;
  final String role;
  final String exp;
  final String iab;
  final String id;
  final String pw;

  InitState({
    required this.loggedIn,
    required this.token,
    required this.langCode,
    required this.domain,
    required this.exp,
    required this.iab,
    required this.sub,
    required this.role,
    required this.id,
    required this.pw,
  });

  factory InitState.initial() {
    return InitState(
      loggedIn: false,
      id: '',
      pw: '',
      domain: '',
      token: '',
      langCode: 'en',
      exp: '',
      iab: '',
      role: '',
      sub: '',
    );
  }

  InitState copyWith({
    bool? loggedIn,
    String? token,
    String? langCode,
    String? domain,
    String? sub,
    String? role,
    String? exp,
    String? iab,
    String? id,
    String? pw,
  }) {
    return InitState(
      loggedIn: loggedIn ?? this.loggedIn,
      token: token ?? this.token,
      langCode: langCode ?? this.langCode,
      domain: domain ?? this.domain,
      sub: sub ?? this.sub,
      role: role ?? this.role,
      exp: exp ?? this.exp,
      iab: iab ?? this.iab,
      id: id ?? this.id,
      pw: pw ?? this.pw,
    );
  }
}

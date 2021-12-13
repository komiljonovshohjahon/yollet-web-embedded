part of 'interpreter.dart';

enum BindingType {
  Early,
  Late,
}

class InterpreterGlobals {
  late LinkedHashSet<IState?> configuration;
  late LinkedHashSet statesToInvoke;
  late Queue internalQueue;
  // TODO: must be blocking queue
  late Queue externalQueue;
  late bool isRunning;
  BindingType? binindg;
  late HashMap<Id, LinkedHashSet<IState>> historyValue;
}


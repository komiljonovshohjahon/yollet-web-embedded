part of 'machine_definition.dart';

abstract class IState implements SCXMLChild, SCXMLElement, Identifiable {
  /// The identifier for this state.
  final Id? id;

  IState(this.id);

  IState._(this.id);
  
  // TODO: this should not be in machine_definition
  bool isFirstEntry = true;
}

abstract class StateWithChildren<T>
    implements SCXMLElement, SCXMLElementWithChildren<T>, IState {
  List<T> get children;
}

// marker interface
abstract class StateChild implements SCXMLElement {}

/// Holds the representation of a [State].
class State extends IState implements StateWithChildren<StateChild> {
  /// The id of the default initial state (or states) for this state.
  ///
  /// TODO: MUST NOT be specified in conjunction with the <initial> element. MUST NOT occur in atomic states.
  final IdRef? initial;

  final List<StateChild> children;

  State({Id? id, this.initial, required this.children}) : super(id) {
    children.forEach((child) => child.parent = this);
  }

  @override
  SCXMLElement? parent;
}

class Initial implements StateChild, SCXMLElement {
  final Transition? transition;

  @override
  SCXMLElement? parent;

  Initial({this.transition});
}

// marker interface
abstract class ParallelStateChild implements SCXMLElement {}

/// The [Parallel] element encapsulates a set of child states which
/// are simultaneously active when the parent element is active.
class Parallel extends IState implements StateWithChildren<ParallelStateChild> {
  final List<ParallelStateChild> children;

  Parallel({Id? id, required this.children}) : super(id) {
    children.forEach((child) => child.parent = this);
  }

  @override
  SCXMLElement? parent;
}

// marker interface
abstract class FinalStateChild implements SCXMLElement {}

/// [Final] represents a final state of an [SCXMLRoot] or compound [State] element.
class Final extends IState implements StateWithChildren<FinalStateChild> {
  final List<FinalStateChild> children;

  Final({Id? id, required this.children}) : super(id) {
    children.forEach((child) => child.parent = this);
  }

  @override
  SCXMLElement? parent;
}

class History extends IState {
  /// A [Transition] whose [Transition.target] specifies the default history configuration.
  /// Occurs once. In a conformant SCXML document,
  /// this transition must not contain 'cond' or 'event' attributes,
  /// and must specify a non-null 'target' whose value is a valid state specification.
  final List<Transition> children;

  History({Id? id, required this.children}) : super(id) {
    children.forEach((child) => child.parent = this);
  }

  @override
  SCXMLElement? parent;
}

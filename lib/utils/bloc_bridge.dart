import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlocBridge<A extends BlocBase, StateA, B extends BlocBase,
    StateB> {
  late final StreamSubscription _streamA;
  late final StreamSubscription _streamB;
  late StateA _prevStateA;
  late StateB _prevStateB;

  FutureOr<void> onChangeFromA(B other, StateA newState);
  FutureOr<void> onChangeFromB(A other, StateB newState);

  @protected
  bool changeWhenA(StateA prev, StateA curr) => true;

  @protected
  bool changeWhenB(StateB prev, StateB curr) => true;

  @protected
  @mustCallSuper
  void registerListeners(BuildContext context) {
    final blocA = context.read<A>();
    _prevStateA = blocA.state;
    final blocB = context.read<B>();
    _prevStateB = blocB.state;

    _streamA = blocA.stream.listen((state) {
      if (changeWhenA(_prevStateA, state)) onChangeFromA(blocB, state);
    });
    _streamB = blocB.stream.listen((state) {
      if (changeWhenB(_prevStateB, state)) onChangeFromB(blocA, state);
    });
  }

  @protected
  @mustCallSuper
  void dispose() {
    _streamA.cancel();
    _streamB.cancel();
  }
}

class BlocCommunicator extends StatefulWidget {
  const BlocCommunicator(
      {super.key, required this.bridges, required this.child});

  final List<BlocBridge> bridges;
  final Widget child;

  @override
  State<BlocCommunicator> createState() => _BlocCommunicatorState();
}

class _BlocCommunicatorState extends State<BlocCommunicator> {
  @override
  void initState() {
    super.initState();
    for (final bridge in widget.bridges) {
      bridge.registerListeners(context);
    }
  }

  @override
  void dispose() {
    for (final bridge in widget.bridges) {
      bridge.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

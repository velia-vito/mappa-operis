part of 'package:mappa_operis/common/mbv.dart';

/// Represents a UI element.
abstract base class View {
  final List<Bridge> _linkedBridges = [];

  /// Get all linked Bridges.
  List<Bridge> get linkedBridges => List.unmodifiable(_linkedBridges);

  /// Links a Bridge to this View.
  void linkBridge(Bridge bridge) => _linkedBridges.add(bridge);
}
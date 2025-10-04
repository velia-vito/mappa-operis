part of 'package:mappa_operis/common/mbv.dart';

/// Representa a Data Model along with allowed interaction upon the model.
abstract base class Model {
    final List<Bridge> _linkedBridges = [];

    /// Get all linked Bridges.
    List<Bridge> get linkedBridges => List.unmodifiable(_linkedBridges);

    /// Links a Bridge to this Model.
    void linkBridge(Bridge bridge) => _linkedBridges.add(bridge);
}
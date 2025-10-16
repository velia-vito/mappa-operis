part of '../blueprint.dart';

/// Fragment of UI.
abstract base class Fragment<S extends Service> {
  /// [Service] bound to this Fragment.
  final S service;

  /// Optional child widget.
  final Widget? child;

  /// Create a Fragment.
  Fragment({required this.service, this.child});
  
  /// UI definition for UI Fragment.
  Widget buildFragment(BuildContext context, S service, Widget? child);

  /// Build method of [ListenableBuilder].
  Widget builder(BuildContext context, Widget? child) => buildFragment(context, service, child);
}

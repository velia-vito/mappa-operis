part of '../blueprint.dart';

/// A 'Fragment' of UI.
abstract base class Fragment<S extends Service> {
  /// [Service] that drives the Buisness Logic of this UI Fragment.
  late final S _service;

  /// Bind [Service] `S` to this Fragment.
  void bind(S service) => _service = service;

  /// Build a 'Fragment' of the Widget tree, using the provided [Service] `S`.
  Widget buildFragment(BuildContext context, S service, Widget? child);

  /// A builder function to be used with [ListenableBuilder] within [Container.build].
  Widget builder(BuildContext context, Widget? child) => buildFragment(context, _service, child);
}

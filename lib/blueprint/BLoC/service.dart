part of '../blueprint.dart';

/// Handles Buisness Logic — i.e non-CRUD operations, bridges the gap b/w [Repository] and [ViewModel]
abstract base class Service<R extends Repository> extends ChangeNotifier {
  /// [Repository] attached to this Service.
  final R repository;

  /// Construct Service.
  Service({required this.repository});
}

part of '../blueprint.dart';

/// A Buisness Logic `Service` operating on data [Repository] `R`.
abstract base class Service<R extends Repository> extends ChangeNotifier {
  /// The data [Repository] that this Service operates on.
  late final R _repository;

  /// Protected access to the repository for subclasses only.
  @protected
  R get repository => _repository;

  /// Bind [Repository] `R` to this Service.
  void bind(R repository) => _repository = repository;
}
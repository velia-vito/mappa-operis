part of '../blueprint.dart';

/// Utility container to connect [Repository]s, [Service]s, and [Fragment]s.
base class UtilContainer<F extends Fragment<S>, S extends Service<R>, R extends Repository>
    extends StatelessWidget {
  final F _fragment;
  final S _service;
  final R _repository;

  /// Creates a [Container] that binds the provided [Fragment], [Service], and [Repository].
  UtilContainer({super.key, required F fragment, required S service, required R repository})
    : _fragment = fragment,
      _service = service,
      _repository = repository {
    _fragment.bind(_service);
    _service.bind(_repository);
  }

  @override
  Widget build(BuildContext context) =>
      ListenableBuilder(listenable: _service, builder: _fragment.builder);
}

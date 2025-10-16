/// TODO: Add documentation.
library;

import 'package:flutter/widgets.dart';

// Data Layer
part 'data/repository.dart';

// Buissness Layer
part 'BLoC/service.dart';

// Presentation Layer
part 'view/fragment.dart';

/// Utility Container to bind [Repository], [Service] and [Fragment] together.
// ignore: use_key_in_widget_constructors
abstract base class ViewModel<R extends Repository, S extends Service<R>, F extends Fragment<S>>
    extends StatelessWidget {
  /// The Attached [Repository]
  R get repository;

  set repository(R _) {
    throw UnsupportedError('setter for repository not supported, property is read-only.');
  }

  /// The Attached [Repository]
  S get service;

  set service(S _) {
    throw UnsupportedError('setter for repository not supported, property is read-only.');
  }

  /// The Attached [Repository]
  F get fragment;

  set fragment(F _) {
    throw UnsupportedError('setter for repository not supported, property is read-only.');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: service, builder: fragment.builder);
  }
}

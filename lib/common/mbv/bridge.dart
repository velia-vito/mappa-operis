part of 'package:mappa_operis/common/mbv.dart';

/// Representa a Bridge between Model and View.
abstract base class Bridge {
  final List<Model> _modelRepository = [];

  final List<View> _viewRepository = [];

  /// Get all bound Models.
  List<Model> get models => List.unmodifiable(_modelRepository);

  /// Get all bound Views.
  List<View> get views => List.unmodifiable(_viewRepository);

  /// Binds a Model to a View.
  void bindModel(Model model) {
    _modelRepository.add(model);
    model.linkBridge(this);
  }

  /// Binds a View to a Model.
  void bindView(View view) {
    _viewRepository.add(view);
    view.linkBridge(this);
  }
}

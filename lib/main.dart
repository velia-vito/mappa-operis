import 'package:fluent_ui/fluent_ui.dart';
import 'package:mappa_operis/blueprint/blueprint.dart';

void main(List<String> args) {
  runApp(FluentApp(home: Center(child: Counter())));
}

/// TODO: Doc for final class 'Counter' extending 'ViewModel<CR, CS, CF>'.
final class Counter extends ViewModel<CR, CS, CF> {
  late CR repository = CR();
  late final CS service = CS(repository: repository);
  late final CF fragment = CF(service: service);
}

/// TODO: Doc for final class 'CR' extending 'Repository'.
final class CR extends Repository {
  int count = 0;
}

/// TODO: Doc for final class 'CS' extending 'Service<CR>'.
final class CS extends Service<CR> {
  CS({required super.repository});

  int get count => repository.count;

  /// TODO: Doc for function 'inc'.
  void inc() {
    repository.count++;
    notifyListeners();
  }

  void dec() {
    repository.count--;
    notifyListeners();
  }
}

/// TODO: Doc for final class 'CF' extending 'Fragment<CS>'.
final class CF extends Fragment<CS> {
  CF({required super.service});

  @override
  Widget buildFragment(BuildContext context, CS service, Widget? child) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(icon: Icon(FluentIcons.chevron_left_end6), onPressed: () => service.dec()),
        Text('${service.count}'),
        IconButton(icon: Icon(FluentIcons.chevron_right_end6), onPressed: () => service.inc()),
      ],
    );
  }
}

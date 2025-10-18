import 'package:fluent_ui/fluent_ui.dart';
import 'package:mappa_operis/blueprint.dart';

void main(List<String> args) {
  runApp(
    FluentApp(
      title: 'Counter App',
      home: ScaffoldPage(
        content: UtilContainer<CounterFragment, CounterService, CounterRepository>(
          fragment: CounterFragment(),
          service: CounterService(),
          repository: CounterRepository(),
        ),
      ),
    ),
  );
}

/// Counter Data.
final class CounterRepository extends Repository {
  int _count = 0;

  /// Internal count.
  int get count => _count;

  set count(int _) {
    throw UnsupportedError('setter for count not supported, property is read-only.');
  }

  /// Increment [count] by 1.
  void increment() {
    _count += 1;
  }

  /// Decrement [count] by 1.
  void decrement() {
    _count -= 1;
  }

  /// Double [count].
  void double() {
    _count *= 2;
  }

  /// Half [count].
  void half() {
    _count ~/= 2;
  }
}

/// Counter Buisness Logic.
final class CounterService extends Service<CounterRepository> {
  /// History of operations on counter.
  final List<String> actionHistory = <String>[];

  /// Get count.
  int get count => repository.count;

  set count(int _) {
    throw UnsupportedError('setter for count not supported, property is read-only.');
  }

  /// Increment count by 1.
  void increment() {
    CounterRepository repo = repository;
    int previousCount = repo.count;

    repo.increment();
    actionHistory.add('Incremented from $previousCount to ${repo.count}');

    notifyListeners();
  }

  /// Decrement count by 1.
  void decrement() {
    CounterRepository repo = repository;
    int previousCount = repo.count;

    repo.decrement();
    actionHistory.add('Decremented from $previousCount to ${repo.count}');

    notifyListeners();
  }

  /// Double count.
  void double() {
    CounterRepository repo = repository;
    int previousCount = repo.count;

    repo.double();
    actionHistory.add('Doubled from $previousCount to ${repo.count}');

    notifyListeners();
  }

  /// Half count.
  void half() {
    CounterRepository repo = repository;
    int previousCount = repo.count;

    repo.half();
    actionHistory.add('Halved from $previousCount to ${repo.count}');

    notifyListeners();
  }
}

/// Counter View
final class CounterFragment extends Fragment<CounterService> {
  @override
  Widget buildFragment(BuildContext context, CounterService service, Widget? child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                        onPressed: service.increment,
                        child: Text('+1', style: FluentTheme.of(context).typography.subtitle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                        onPressed: service.double,
                        child: Text('×2', style: FluentTheme.of(context).typography.subtitle),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    '${service.count}',
                    style: FluentTheme.of(context).typography.titleLarge,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                        onPressed: service.decrement,
                        child: Text('-1', style: FluentTheme.of(context).typography.subtitle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Button(
                        onPressed: service.half,
                        child: Text('÷2', style: FluentTheme.of(context).typography.subtitle),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Action History',
                    style: FluentTheme.of(context).typography.title,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: service.actionHistory.length,
                    itemBuilder: (context, index) => IntrinsicWidth(
                      child: ListTile(
                        title: Text('Action #${index + 1}'),
                        subtitle: Text(service.actionHistory[index]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

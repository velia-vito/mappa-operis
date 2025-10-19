import 'package:fluent_ui/fluent_ui.dart';
import 'package:mappa_operis/blueprint.dart';
import 'package:mappa_operis/component/i_sound.dart';

void main(List<String> args) {
  runApp(
    FluentApp(
      title: 'Counter App',
      home: ScaffoldPage(
        content: UtilContainer<ISoundFragment, ISoundService, ISoundRepository>(
          fragment: ISoundFragment(),
          service: ISoundService(),
          repository: ISoundRepository(
            totalDuration: Duration(minutes: 1),
            intervalDuration: Duration(seconds: 5),
          ),
        ),
      ),
    ),
  );
}

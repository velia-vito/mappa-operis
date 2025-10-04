import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mappa_operis/blueprint/blueprint.dart';

part 'intervalsound/i_sound_repository.dart';
part 'intervalsound/i_sound_service.dart';
part 'intervalsound/interval_sound_view.dart';

/// TODO: Doc for final class 'ISoundViewModel extend ViewModel<ISoundRepository, ISoundService, ISoundFragment>'.
final class ISoundViewModel extends ViewModel<ISoundRepository, ISoundService, ISoundFragment> {
  @override
  // TODO: implement fragment
  ISoundFragment get fragment => ISoundFragment(service: service);

  @override
  // TODO: implement repository
  ISoundRepository get repository => ISoundRepository(period: Duration(hours: 1), interval: Duration(seconds: 5));

  @override
  // TODO: implement service
  ISoundService get service => ISoundService(repository: repository);
  
}
part of '../intervalsound.dart';

/// Control the playback of periodic beeps at specified intervals.
///
/// ### Notes
///
/// Let's say you're playing sounds every `5s` for `1h`. The play-period is `3600s`,
/// and the interval is `5s`. The total number of plays is `3600 / 5 = 720`. While not all
/// calculations may be done in seconds, this is the convention we will be sticking to
/// w.r.t "period" and "interval".
final class ISoundRepository extends Repository {
  /// Sound assets to play at each interval.
  final List<Source> intervalSounds;

  /// Sound asset to play at the end of the period.
  final Source finalSound;

  Duration _period;

  Duration _interval;

  Duration _completedPeriod = Duration.zero;

  bool _isActive = false;

  late final _player = AudioPlayer();

  ISoundRepository({
    required Duration period,
    required Duration interval,
    List<Source>? intervalSounds,
    Source? finalSound,
  }) : _period = period,
       _interval = interval,
       intervalSounds =
           intervalSounds ??
           <Source>[AssetSource('audio/beep-1.mp3'), AssetSource('audio/beep-2.mp3')],
       finalSound = finalSound ?? AssetSource('audio/beep-final.mp3');

  /// Start playing sound in regular intervals.
  Future<void> start() async {
    _isActive = true;

    while (_completedPeriod < _period && _isActive) {
      await Future.delayed(_interval);

      if (_isActive) {
        _completedPeriod += _interval;
        _player.play(intervalSounds[Random().nextInt(intervalSounds.length)]);
      }
    }
  }

  /// Stop playing sounds at regular intervals.
  void stop() {
    _isActive = false;
  }

  /// Fast-forward the timer till the end.
  void finish() {
    _completedPeriod = _period;
  }

  /// Reset the timer.
  void reset() {
    _completedPeriod = Duration.zero;
  }

  /// Update with new duration and period.
  void update(Duration period, Duration interval) {
    _period = period;
    _interval = interval;
    _completedPeriod = Duration.zero;
  }
}

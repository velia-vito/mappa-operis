part of '../intervalsound.dart';

/// Control the playback of periodic beeps at specified intervals.
///
/// ### Notes
///
/// Let's say you're playing sounds every `5s` for `1h`. The play-period is `3600s`,
/// and the interval is `5s`. The total number of plays is `3600 / 5 = 720`. While not all
/// calculations may be done in seconds, this is the convention we will be sticking to
/// w.r.t "period" and "interval".
final class IntervalSoundModel extends Model {
  /// All possible sounds to choose from.
  final List<Source> intervalSounds;

  /// Sound to play to indicate the end of the play-period.
  final Source finalSound;

  /// Duration of the interval between plays.
  final Duration interval;

  /// Total number of times the sound will be played.
  final int totalPlays;

  /// Internal AudioPlayer instance.
  late final AudioPlayer _internalPlayer = AudioPlayer();

  /// Number of plays completed so far.
  int _complPlays = 0;

  /// Whether to count intervals towards the total number of plays.
  bool _countIntervals = false;

  /// `true` if all plays have been completed.
  bool get isStopped => _complPlays >= totalPlays;

  set isStopped(bool _) {
    throw UnsupportedError('setter for isStopped not supported, property is read-only.');
  }

  /// `true` if the interval player is currently active.
  bool get isResumed => !isStopped && _countIntervals;

  set isResumed(bool _) {
    throw UnsupportedError('setter for isActicce not supported, property is read-only.');
  }

  /// `true` if the interval player is currently paused.
  bool get isPaused => !isResumed;

  set isPaused(bool _) {
    throw UnsupportedError('setter for isPaused not supported, property is read-only.');
  }

  /// Creates an [IntervalSoundModel] instance.
  IntervalSoundModel({
    required Duration playPeriod,
    required this.interval,
    List<Source>? intervalSounds,
    Source? finalSound,
  }) : totalPlays = playPeriod.inMilliseconds ~/ interval.inMilliseconds,
       finalSound = finalSound ?? AssetSource('audio/beep-final.mp3'),
       intervalSounds =
           intervalSounds ??
           <Source>[AssetSource('audio/beep-1.mp3'), AssetSource('audio/beep-2.mp3')],
       assert(playPeriod.inMilliseconds > 0, '[!] play-period ≤ 0; no sound will be played.'),
       assert(interval.inMilliseconds > 0, '[!] play-interval ≤ 0; no sound will be played.'),
       assert(playPeriod >= interval, '[!] play-period ≤ play-interval; one sound will be played.');

  /// Start the interval player.
  Future<void> start() async {
    Random randomEngine = Random();

    while (isResumed && _countIntervals) {
      _complPlays++;
      _internalPlayer.play(intervalSounds[randomEngine.nextInt(intervalSounds.length)]);

      await Future.delayed(interval);
    }

    _internalPlayer.play(finalSound);
  }

  /// Pause the interval player.
  void pause() {
    _countIntervals = false;
  }

  /// End the interval player.
  void end() {
    _complPlays == totalPlays;
  }
}

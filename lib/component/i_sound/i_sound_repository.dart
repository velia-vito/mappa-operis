part of '../i_sound.dart';

/// Play Sound at regular intervals — data only.
final class ISoundRepository extends Repository {
  /// Total timer duration.
  Duration totalDuration;

  /// Duration between beeps.
  Duration intervalDuration;

  /// Duration timer has been active this cycle.
  Duration _elapsed = Duration.zero;

  /// Whether the timer is currently active, i.e if time is being added to the elapsed time.
  bool _isActive = false;

  /// Duration timer has been active this cycle.
  Duration get elapsed => _elapsed;

  /// Weather timer is currently active, i.e. if time is being added to the elaped time.
  bool get isActive => _isActive;

  /// Play-Pause cycle count.
  int _currentCycle = 0;

  /// Create an [ISoundRepository].
  ISoundRepository({required this.totalDuration, required this.intervalDuration});

  /// Return `true` if sound should be played and `false` if not. Signal is sent every [intervalDuration].
  Stream<bool> soundSignalStream() async* {
    while (elapsed <= totalDuration && isActive) {
      // Keep track of current play-pause cycle.
      int callCycle = _currentCycle;

      await Future.delayed(intervalDuration);

      // If still in the same play-pause cycle, update elapsed time and yield signal.
      // This prevents signal from being yielded at intervals shorter than intervalDuration when paused and resumed quickly.
      // as the simple condition of elapsed <= totalDuration && isActive would be true in that case.
      if (callCycle == _currentCycle) {
        _elapsed += intervalDuration;

        yield isActive && true;
      } else {
        break;
      }
    }
  }

  /// Resume/Start timer.
  void resume() {
    _isActive = true;
  }

  /// Pause/Stop timer.
  void pause() {
    _currentCycle++;
    _isActive = false;
  }

  /// Reset timer.
  void reset() {
    _elapsed = Duration.zero;
  }
}

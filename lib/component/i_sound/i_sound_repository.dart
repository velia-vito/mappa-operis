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

  set elapsed(Duration _) {
    throw UnsupportedError('setter for elapsed not supported, property is read-only.');
  }

  /// Weather timer is currently active, i.e. if time is being added to the elaped time.
  bool get isActive => _isActive;

  set isActive(bool _) {
    throw UnsupportedError('setter for isActive not supported, property is read-only.');
  }

  /// Create an [ISoundRepository].
  ISoundRepository({required this.totalDuration, required this.intervalDuration});

  /// Return `true` if sound should be played and `false` if not. Signal is sent every [intervalDuration].
  Stream<bool> soundSignalStream() async* {
    while (elapsed <= totalDuration && isActive) {
      await Future.delayed(intervalDuration);
      _elapsed += intervalDuration;

      yield isActive && true;
    }
  }

  /// Resume/Start timer.
  void resume() {
    _isActive = true;
  }

  /// Pause/Stop timer.
  void pause() {
    _isActive = false;
  }

  /// Reset timer.
  void reset() {
    _elapsed = Duration.zero;
  }
}

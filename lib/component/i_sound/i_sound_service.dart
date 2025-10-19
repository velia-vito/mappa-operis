part of '../i_sound.dart';

/// Provides buisness logic and audio playback.
final class ISoundService extends Service<ISoundRepository> {
  /// Internal audio player.
  late final AudioPlayer _audioPlayer = AudioPlayer();

  /// Internal random engine.
  late final Random _randomEngine = Random();

  /// Progress percentage.
  double get progress {
    int totalMillis = repository.totalDuration.inMilliseconds;
    int elapsedMillis = repository.elapsed.inMilliseconds;

    return elapsedMillis == 0 ? 0 : (elapsedMillis / totalMillis * 100);
  }

  /// Total time on the timer.
  DateTime get totalTime => DateTime.now().copyWith(
    hour: repository.totalDuration.inHours % 24,
    minute: repository.totalDuration.inMinutes % 60,
    second: 0,
  );

  /// Interval time on the timer.
  DateTime get intervalTime => DateTime.now().copyWith(
    hour: repository.intervalDuration.inMinutes % 24,
    minute: repository.intervalDuration.inSeconds % 60,
    second: 0,
  );

  /// Remaning time on the timer.
  Duration get remainingTime => repository.totalDuration - repository.elapsed;

  /// Get remaining time as HH:MM:SS string.
  String get remainingTimeString => remainingTime.toString().split('.')[0];

  /// Weather the timer is resumed or paused.
  bool get isResumed => repository.isActive;

  /// Weather the timer is complete.
  bool get isComplete => repository.elapsed == repository.totalDuration;

  /// Creates a new timer with the given total duration and interval duration.
  void updateTimer({required Duration totalDuration, required Duration intervalDuration}) {
    repository.totalDuration = totalDuration;
    repository.intervalDuration = intervalDuration;

    repository.reset();

    notifyListeners();
  }

  /// Resume Timer
  void resume() {
    // Resume timer and notify listeners.
    repository.resume();
    notifyListeners();

    // play sound on interval, have UI update.
    repository.soundSignalStream().listen((bool shouldPlaySound) {
      if (shouldPlaySound) {
        if (repository.elapsed == repository.totalDuration) {
          _audioPlayer.play(AssetSource('audio/beep-final.mp3'));
          repository.pause();
        } else if (_randomEngine.nextBool()) {
          _audioPlayer.play(AssetSource('audio/beep-1.mp3'));
        } else {
          _audioPlayer.play(AssetSource('audio/beep-2.mp3'));
        }
      }

      notifyListeners();
    });
  }

  /// Pause Timer.
  void puase() {
    repository.pause();
    notifyListeners();
  }

  /// Timer reset.
  void reset() {
    repository.reset();
    notifyListeners();
  }
}

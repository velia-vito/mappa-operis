part of '../clicker.dart';

final class ClickerModel extends Model {
  /// Interval between clicks, in seconds.
  final int clickInterval;

  /// Total number of clicks to play.
  final int totalClicks;

  final AudioPlayer _audioPlayer = AudioPlayer();

  /// Number of clicks played so far.
  var _currentClicks = 0;

  /// Whether the clicker is currently active.
  var _isActive = false;

  bool get isResumed => _isActive && _currentClicks < totalClicks;

  bool get isPaused => !_isActive && _currentClicks < totalClicks;

  bool get isCompleted => _currentClicks >= totalClicks;

  ClickerModel({
    required int totalDurationInSeconds,
    required this.clickInterval,
  }) : totalClicks = (totalDurationInSeconds ~/ clickInterval);

  Future<void> resume() async {
    _isActive = true;

    while (_isActive) {
      if (_currentClicks >= totalClicks) {
        await _audioPlayer.play(AssetSource('audio/beep-final.mp3'));
        _isActive = false;
      } else if (await _useBeep1()) {
        await _audioPlayer.play(AssetSource('audio/beep-1.mp3'));
      } else {
        await _audioPlayer.play(AssetSource('audio/beep-2.mp3'));
      }

      _currentClicks++;

      await Future.delayed(Duration(seconds: clickInterval));
    }
  }

  Future<bool> _useBeep1() async {
    return Random().nextInt(2) == 0;
  }
}

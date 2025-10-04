part of '../intervalsound.dart';

/// Interval Sound Service.
final class ISoundService extends Service<ISoundRepository> {
  ISoundService({required super.repository});

  /// `true` if the sound service is currently paused.
  bool get isPaused => repository._isActive == false;

  double get progress =>
      repository._completedPeriod.inMilliseconds / repository._period.inMilliseconds;

  int get remainingTimeHours => repository._period.inHours - repository._completedPeriod.inHours;

  int get remainingTimeMinutes =>
      (repository._period.inMinutes - repository._completedPeriod.inMinutes) -
      (remainingTimeHours * 60);

  Future<void> resume() async {
    repository.start();

    while (!isPaused) {
      await Future.delayed(Duration(seconds: 1));
      notifyListeners();
      print(
        '${remainingTimeHours.toString().padLeft(2, '0')}H ${(remainingTimeMinutes).toString().padLeft(2, '0')}M',
      );
    }
  }

  void pause() {
    repository.stop();
    notifyListeners();
  }
}

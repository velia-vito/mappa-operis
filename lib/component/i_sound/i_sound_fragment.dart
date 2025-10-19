part of '../i_sound.dart';

/// UI for ISound
final class ISoundFragment extends Fragment<ISoundService> {
  @override
  Widget buildFragment(BuildContext context, ISoundService service, Widget? child) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            service.isComplete
                ? FluentIcons.reset
                : service.isResumed
                ? FluentIcons.circle_pause
                : FluentIcons.play_resume,
            size: FluentTheme.of(context).typography.titleLarge!.fontSize! * 2,
          ),
          onPressed: () {
            service.isComplete
                ? service.reset()
                : service.isResumed
                ? service.puase()
                : service.resume();
          },
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HyperlinkButton(
              onPressed: () {
                service.puase();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    DateTime totalTime = service.totalTime;
                    DateTime intervalTime = service.intervalTime;

                    return ContentDialog(
                      title: Text('Adjust Timer'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Total Time (HH:MM)'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TimePicker(
                              selected: totalTime,
                              onChanged: (DateTime value) => totalTime = value,
                              hourFormat: HourFormat.HH,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Interval Time (MM:SS)'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TimePicker(
                              selected: intervalTime,
                              onChanged: (DateTime value) => intervalTime = value,
                              hourFormat: HourFormat.HH,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Button(child: Text('Cancel'), onPressed: () => Navigator.pop(context)),
                        FilledButton(
                          child: Text('Update'),
                          onPressed: () {
                            service.updateTimer(
                              totalDuration: Duration(
                                hours: totalTime.hour,
                                minutes: totalTime.minute,
                                seconds: 0,
                              ),
                              intervalDuration: Duration(
                                hours: 0,
                                minutes: intervalTime.hour,
                                seconds: intervalTime.minute,
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                service.remainingTimeString,
                style: FluentTheme.of(context).typography.titleLarge,
              ),
            ),
            ProgressBar(value: service.progress),
          ],
        ),
      ],
    );
  }
}

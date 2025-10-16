part of '../intervalsound.dart';

/// TODO: Doc for final class 'ISoundFragment' extending 'Fragment<ISoundService>'.
final class ISoundFragment extends Fragment<ISoundService> {
  ISoundFragment({required super.service});

  @override
  Widget buildFragment(BuildContext context, ISoundService service, Widget? child) {
    service.addListener(() => print('should update'));
    return TaggedIconButton(
      icon: service.isPaused ? FluentIcons.cafe : FluentIcons.activity_feed,
      label: service.isPaused ? 'SA' : 'SB',
      onPressed: () {
        service.isPaused ? service.resume() : service.pause();
      },
    );
  }

  // @override
  // Widget buildFragment(BuildContext context, ISoundService service, Widget? child) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: IconButton(
  //               icon: Icon(service.isPaused ? FluentIcons.play : FluentIcons.circle_pause, size: 62),
  //               onPressed: () {
  //                service.isPaused ? service.resume() : service.pause();
  //               },
  //             ),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 '${service.remainingTimeHours.toString().padLeft(2, '0')}H ${(service.remainingTimeMinutes).toString().padLeft(2, '0')}M',
  //                 style: FluentTheme.of(context).typography.titleLarge,
  //               ),
  //               ProgressBar(value: service.progress, strokeWidth: 8),
  //             ],
  //           ),
  //         ],
  //       ),
  //       Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: TaggedIconButton(
  //               icon: FluentIcons.timer,
  //               label: 'Timer Settings',
  //               onPressed: () => print('update settings'),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: TaggedIconButton(
  //               icon: FluentIcons.reset,
  //               label: 'Reset Timer',
  //               onPressed: () => print('reset timer'),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}

class TaggedIconButton extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final void Function()? onPressed;
  const TaggedIconButton({super.key, this.icon, this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      child: Row(children: [Icon(icon), Text(' $label' ?? '')]),
    );
  }
}

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hub/__core__/components/styles/app_colors.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:iconforest_icon_park/icon_park.dart';

class MediaControlView extends StatefulWidget {
  const MediaControlView({super.key});

  @override
  State<MediaControlView> createState() => _MediaControlViewState();
}

class _MediaControlViewState extends State<MediaControlView> {
  late bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppRoundedContainer(
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: () {},
              child: const SizedBox(
                width: 48,
                height: 48,
                child: Icon(FluentIcons.previous_24_filled),
              ),
            ),
          ),
        ),
        AppRoundedContainer(
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  playing = !playing;
                });
              },
              child: SizedBox(
                width: 64,
                height: 64,
                child: Icon(playing
                    ? FluentIcons.play_24_filled
                    : FluentIcons.pause_24_filled),
              ),
            ),
          ),
        ),
        AppRoundedContainer(
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: () {},
              child: const SizedBox(
                width: 48,
                height: 48,
                child: Icon(FluentIcons.next_24_filled),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

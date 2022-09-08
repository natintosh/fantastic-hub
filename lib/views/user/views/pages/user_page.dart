import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/assets/assets.gen.dart';
import 'package:hub/__core__/extensions/build_context.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final content = ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Gap(20),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Michael',
                    style: context.theme.textTheme.titleLarge,
                  ),
                  const Gap(4),
                  Text(
                    'Personalise your experience and much more',
                    style: context.theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox.square(
              dimension: 56,
              child: ClipOval(
                child: Assets.images.mockProfileImage.image(fit: BoxFit.cover),
              ),
            )
          ],
        ),
        const Gap(50),
        const ListTile(
          leading: Icon(FluentIcons.person_24_regular),
          title: Text('User information'),
        ),
        const ListTile(
          leading: Icon(FluentIcons.clock_alarm_24_regular),
          title: Text('Notifications'),
        ),
        const ListTile(
          leading: Icon(FluentIcons.person_settings_20_regular),
          title: Text('Preferences'),
        ),
        const ListTile(
          leading: Icon(FluentIcons.headphones_24_regular),
          title: Text('Help and Support'),
        ),
        const ListTile(
          leading: Icon(FluentIcons.question_circle_24_regular),
          title: Text('About'),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
        centerTitle: true,
      ),
      body: content,
    );
  }
}

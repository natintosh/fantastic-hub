import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/views/ui/widgets/app_header.dart';
import 'package:hub/ui/dashboard/views/widgets/location_tabs.dart';
import 'package:hub/ui/dashboard/views/widgets/news_preview.dart';
import 'package:hub/ui/dashboard/views/widgets/user_preview.dart';
import 'package:hub/ui/dashboard/views/widgets/weather_preview.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int index = 0;

  void onLocationTabSelected(int index) {
    setState(() {
      this.index = index;
    });
  }

  void onAddLocationPressed() {}

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final content = ListView(
      padding: EdgeInsets.only(
        top: context.mq.padding.top,
        left: 16,
        right: 16,
        bottom: 200,
      ),
      children: [
        const Gap(20),
        const UserPreview(),
        const Gap(20),
        const WeatherPreview(),
        const Gap(20),
        const NewsPreview(),
        const Gap(20),
        AppHeader.withAction(
          text: localization.locations,
          action: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(FluentIcons.add_24_filled),
          ),
          onAction: onAddLocationPressed,
        ),
        LocationTabs(
          tabs: const ['Living Room', 'Kitchen', 'Bedroom', 'Office'],
          onTabSelected: onLocationTabSelected,
          index: index,
        ),
      ],
    );
    return Scaffold(
      body: content,
    );
  }
}

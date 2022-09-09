import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/views/widgets/app_grid_view.dart';
import 'package:hub/__core__/components/views/widgets/smart_widget.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/views/dashboard/views/widgets/news_preview.dart';
import 'package:hub/views/dashboard/views/widgets/user_preview.dart';
import 'package:hub/views/dashboard/views/widgets/weather_preview.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/details/views/pages/details_page.dart';

class LocationTabs extends StatelessWidget {
  const LocationTabs({
    super.key,
    required this.tabs,
    this.index = 0,
    this.onTabSelected,
  });

  final int index;

  final List<String> tabs;

  final ValueChanged<int>? onTabSelected;

  @override
  Widget build(BuildContext context) {
    final children = [
      AppGridView(
        children: [
          // SmartWidget.activeSwitch(
          //   device: const Device(
          //       type: DeviceType.bulb,
          //       name: 'Smart Bulb',
          //       location: 'Living Room'),
          //   onTap: (device) {
          //     DetailsPage.pushOnType(context: context, device: device);
          //   },
          // ),
          // SmartWidget.activeSwitch(
          //   device: const Device(
          //       type: DeviceType.airConditioner,
          //       name: 'Air Conditioner',
          //       location: 'Living Room'),
          //   onTap: (device) {
          //     DetailsPage.pushOnType(context: context, device: device);
          //   },
          // ),
          // SmartWidget.activeSwitch(
          //   device: const Device(
          //       type: DeviceType.voiceAssistant,
          //       name: 'Voice Assistant',
          //       location: 'Living Room'),
          //   onTap: (device) {
          //     DetailsPage.pushOnType(context: context, device: device);
          //   },
          // ),
          // SmartWidget.activeSwitch(
          //   device: const Device(
          //       type: DeviceType.television,
          //       name: 'Smart TV',
          //       location: 'Living Room'),
          //   onTap: (device) {
          //     DetailsPage.pushOnType(context: context, device: device);
          //   },
          // ),
        ],
      ),
      const UserPreview(),
      const NewsPreview(),
      const WeatherPreview()
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTabController(
          length: tabs.length,
          child: TabBar(
            isScrollable: true,
            indicatorPadding: const EdgeInsets.only(bottom: 8),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: context.theme.colorScheme.secondary,
            labelColor: context.theme.colorScheme.primary,
            labelStyle: context.theme.textTheme.subtitle1,
            unselectedLabelColor: context.theme.colorScheme.onSurface,
            unselectedLabelStyle: context.theme.textTheme.subtitle1,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
            onTap: onTabSelected,
          ),
        ),
        const Gap(20),
        AnimatedSwitcher(
          duration: const Duration(),
          child: children[index],
        ),
      ],
    );
  }
}

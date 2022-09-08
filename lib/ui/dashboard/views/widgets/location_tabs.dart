import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/app_router.gr.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/views/ui/widgets/app_grid_view.dart';
import 'package:hub/__core__/views/ui/widgets/smart_widget.dart';
import 'package:hub/ui/dashboard/views/widgets/news_preview.dart';
import 'package:hub/ui/dashboard/views/widgets/user_preview.dart';
import 'package:hub/ui/dashboard/views/widgets/weather_preview.dart';
import 'package:hub/ui/details/models/data/device.dart';
import 'package:hub/ui/details/views/pages/details_page.dart';
import 'package:iconforest_icon_park/icon_park.dart';

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
          SmartWidget.activeSwitch(
            name: 'Lamp',
            icon: IconPark.svgAsset(
              IconPark.light,
              color: context.theme.iconTheme.color,
              width: 24,
              height: 24,
            ),
            onTap: () {
              DetailsPage.lamp(
                context: context,
                device: Device(
                    type: DeviceType.smartBulb,
                    name: 'Smart Bulb',
                    brand: 'Phillips',
                    location: 'Living Room'),
              );
            },
          ),
          SmartWidget.activeSwitch(
            valueStream: Stream<bool>.value(true),
            name: 'Air Conditioner',
            icon: IconPark.svgAsset(
              IconPark.air_conditioning,
              color: context.theme.iconTheme.color,
              width: 24,
              height: 24,
            ),
            onTap: () {
              DetailsPage.airConditioner(
                context: context,
                device: Device(
                    type: DeviceType.smartAirConditioner,
                    name: 'Air Conditioner',
                    brand: 'Samsung',
                    location: 'Living Room'),
              );
            },
          ),
          SmartWidget.activeSwitch(
            name: 'Assistant',
            icon: IconPark.svgAsset(
              IconPark.voice,
              color: context.theme.iconTheme.color,
              width: 24,
              height: 24,
            ),
            onTap: () {
              DetailsPage.voiceAssistant(
                context: context,
                device: Device(
                    type: DeviceType.smartVoiceAssistant,
                    name: 'Voice Assistant',
                    brand: 'Amazon',
                    location: 'Living Room'),
              );
            },
          ),
          SmartWidget.activeSwitch(
            name: 'Television',
            icon: IconPark.svgAsset(
              IconPark.tv,
              color: context.theme.iconTheme.color,
              width: 24,
              height: 24,
            ),
            onTap: () {
              DetailsPage.tv(
                context: context,
                device: Device(
                    type: DeviceType.smartTelevision,
                    name: 'Smart TV',
                    brand: 'Onn',
                    location: 'Living Room'),
              );
            },
          ),
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

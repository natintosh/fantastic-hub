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
              context.router.push(const DetailsRouter());
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
          ),
          SmartWidget.activeSwitch(
            name: 'Television',
            icon: IconPark.svgAsset(
              IconPark.tv,
              color: context.theme.iconTheme.color,
              width: 24,
              height: 24,
            ),
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

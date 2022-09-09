import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/views/widgets/app_grid_view.dart';
import 'package:hub/__core__/components/views/widgets/smart_widget.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/views/details/views/pages/details_page.dart';
import 'package:hub/views/devices/models/data/device.dart';
import 'package:hub/views/location/models/data/location.dart';

class LocationTabs extends StatelessWidget {
  const LocationTabs({
    super.key,
    required this.tabs,
    required this.devicesStream,
    this.index = 0,
    this.onTabSelected,
    this.onDeviceActivated,
  });

  final int index;

  final Stream<List<Device>> devicesStream;
  final List<Location> tabs;

  final void Function(Device old, Device device)? onDeviceActivated;
  final ValueChanged<int>? onTabSelected;

  @override
  Widget build(BuildContext context) {
    final children = tabs
        .map(
          (e) => LocationPreview(
            key: ValueKey(e),
            location: e,
            devicesStream: devicesStream,
            onDeviceActivated: onDeviceActivated,
          ),
        )
        .toList();
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
                      text: e.name,
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

class LocationPreview extends StatelessWidget {
  const LocationPreview({
    super.key,
    required this.location,
    required this.devicesStream,
    this.onDeviceActivated,
  });

  final Stream<List<Device>> devicesStream;
  final Location location;
  final void Function(Device old, Device device)? onDeviceActivated;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Device>>(
      stream: devicesStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];

        final children = data
            .where((element) => element.location == location)
            .map((e) => SmartWidget.activeSwitch(
                  device: e,
                  onTap: (device) {
                    DetailsPage.pushOnType(context: context, device: device);
                  },
                  onSwitchChanged: (value) {
                    onDeviceActivated?.call(e, e.copyWith(isActive: value));
                  },
                ))
            .toList();
        return AppGridView(
          children: children,
        );
      },
    );
  }
}

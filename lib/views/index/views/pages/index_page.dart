import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hub/__core__/app_router.gr.dart';
import 'package:hub/__core__/extensions/build_context.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int index = 0;

  List<NavigationDestination> get navigationItems {
    final localization = context.localization;
    return <NavigationDestination>[
      NavigationDestination(
        icon: const Icon(FluentIcons.grid_24_regular),
        selectedIcon: const Icon(FluentIcons.grid_24_filled),
        label: localization.dashboard,
      ),
      NavigationDestination(
        icon: const Icon(FluentIcons.connected_20_regular),
        selectedIcon: const Icon(FluentIcons.connected_20_filled),
        label: localization.devices,
      ),
      NavigationDestination(
        icon: const Icon(FluentIcons.data_usage_24_regular),
        selectedIcon: const Icon(FluentIcons.data_usage_24_filled),
        label: localization.statistics,
      ),
      NavigationDestination(
        icon: const Icon(FluentIcons.person_24_regular),
        selectedIcon: const Icon(FluentIcons.person_24_filled),
        label: localization.user,
      ),
    ];
  }

  void onDestinationSelected(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const <PageRouteInfo>[
        DashboardRouter(),
        DeviceRouter(),
        StatisticsRouter(),
        UserRouter(),
      ],
      builder: (context, child, animation) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            destinations: navigationItems,
            onDestinationSelected: (index) {
              AutoTabsRouter.of(context).setActiveIndex(index);
              onDestinationSelected(index);
            },
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: child,
          ),
        );
      },
    );
  }
}

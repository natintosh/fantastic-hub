// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:hub/__core__/components/views/widgets/app_control_tile.dart' as _i12;
import 'package:hub/views/dashboard/views/pages/dashboard_page.dart' as _i5;
import 'package:hub/views/details/models/data/device.dart' as _i11;
import 'package:hub/views/details/views/pages/details_page.dart' as _i3;
import 'package:hub/views/devices/views/pages/devices_page.dart' as _i6;
import 'package:hub/views/index/views/pages/index_page.dart' as _i2;
import 'package:hub/views/onboarding/views/pages/on_boarding_page.dart' as _i1;
import 'package:hub/views/routines/views/pages/routines_page.dart' as _i4;
import 'package:hub/views/statistics/view/pages/statistics_page.dart' as _i7;
import 'package:hub/views/user/views/pages/user_page.dart' as _i8;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    OnBoardingRoute.name: (routeData) {
      return _i9.AdaptivePage<void>(
          routeData: routeData, child: const _i1.OnBoardingPage());
    },
    IndexRouter.name: (routeData) {
      return _i9.AdaptivePage<void>(
          routeData: routeData, child: const _i2.IndexPage());
    },
    DetailsRouter.name: (routeData) {
      final args = routeData.argsAs<DetailsRouterArgs>();
      return _i9.AdaptivePage<void>(
          routeData: routeData,
          child: _i3.DetailsPage(
              key: args.key, device: args.device, controls: args.controls));
    },
    RoutinesRouter.name: (routeData) {
      return _i9.AdaptivePage<void>(
          routeData: routeData, child: const _i4.RoutinesPage());
    },
    DashboardRouter.name: (routeData) {
      return _i9.AdaptivePage<void>(
          routeData: routeData, child: const _i5.DashboardPage());
    },
    DeviceRouter.name: (routeData) {
      return _i9.AdaptivePage<void>(
          routeData: routeData, child: const _i6.DevicesPage());
    },
    StatisticsRouter.name: (routeData) {
      return _i9.AdaptivePage<void>(
          routeData: routeData, child: const _i7.StatisticsPage());
    },
    UserRouter.name: (routeData) {
      return _i9.AdaptivePage<void>(
          routeData: routeData, child: const _i8.UserPage());
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(OnBoardingRoute.name, path: '/'),
        _i9.RouteConfig(IndexRouter.name, path: '/', children: [
          _i9.RouteConfig(DashboardRouter.name,
              path: 'dashboard', parent: IndexRouter.name),
          _i9.RouteConfig(DeviceRouter.name,
              path: 'devices', parent: IndexRouter.name),
          _i9.RouteConfig(StatisticsRouter.name,
              path: 'statistics', parent: IndexRouter.name),
          _i9.RouteConfig(UserRouter.name,
              path: 'user', parent: IndexRouter.name)
        ]),
        _i9.RouteConfig(DetailsRouter.name, path: 'details'),
        _i9.RouteConfig(RoutinesRouter.name, path: 'routines')
      ];
}

/// generated route for
/// [_i1.OnBoardingPage]
class OnBoardingRoute extends _i9.PageRouteInfo<void> {
  const OnBoardingRoute() : super(OnBoardingRoute.name, path: '/');

  static const String name = 'OnBoardingRoute';
}

/// generated route for
/// [_i2.IndexPage]
class IndexRouter extends _i9.PageRouteInfo<void> {
  const IndexRouter({List<_i9.PageRouteInfo>? children})
      : super(IndexRouter.name, path: '/', initialChildren: children);

  static const String name = 'IndexRouter';
}

/// generated route for
/// [_i3.DetailsPage]
class DetailsRouter extends _i9.PageRouteInfo<DetailsRouterArgs> {
  DetailsRouter(
      {_i10.Key? key,
      required _i11.Device device,
      required List<_i12.AppControlTile> controls})
      : super(DetailsRouter.name,
            path: 'details',
            args: DetailsRouterArgs(
                key: key, device: device, controls: controls));

  static const String name = 'DetailsRouter';
}

class DetailsRouterArgs {
  const DetailsRouterArgs(
      {this.key, required this.device, required this.controls});

  final _i10.Key? key;

  final _i11.Device device;

  final List<_i12.AppControlTile> controls;

  @override
  String toString() {
    return 'DetailsRouterArgs{key: $key, device: $device, controls: $controls}';
  }
}

/// generated route for
/// [_i4.RoutinesPage]
class RoutinesRouter extends _i9.PageRouteInfo<void> {
  const RoutinesRouter() : super(RoutinesRouter.name, path: 'routines');

  static const String name = 'RoutinesRouter';
}

/// generated route for
/// [_i5.DashboardPage]
class DashboardRouter extends _i9.PageRouteInfo<void> {
  const DashboardRouter() : super(DashboardRouter.name, path: 'dashboard');

  static const String name = 'DashboardRouter';
}

/// generated route for
/// [_i6.DevicesPage]
class DeviceRouter extends _i9.PageRouteInfo<void> {
  const DeviceRouter() : super(DeviceRouter.name, path: 'devices');

  static const String name = 'DeviceRouter';
}

/// generated route for
/// [_i7.StatisticsPage]
class StatisticsRouter extends _i9.PageRouteInfo<void> {
  const StatisticsRouter() : super(StatisticsRouter.name, path: 'statistics');

  static const String name = 'StatisticsRouter';
}

/// generated route for
/// [_i8.UserPage]
class UserRouter extends _i9.PageRouteInfo<void> {
  const UserRouter() : super(UserRouter.name, path: 'user');

  static const String name = 'UserRouter';
}

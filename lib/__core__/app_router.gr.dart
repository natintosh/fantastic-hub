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
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:hub/__core__/views/ui/widgets/app_control_tile.dart' as _i11;
import 'package:hub/ui/dashboard/views/pages/dashboard_page.dart' as _i4;
import 'package:hub/ui/details/models/data/device.dart' as _i10;
import 'package:hub/ui/details/views/pages/details_page.dart' as _i3;
import 'package:hub/ui/devices/views/pages/devices_page.dart' as _i5;
import 'package:hub/ui/index/views/pages/index_page.dart' as _i2;
import 'package:hub/ui/onboarding/views/pages/on_boarding_page.dart' as _i1;
import 'package:hub/ui/statistics/view/pages/statistics_page.dart' as _i6;
import 'package:hub/ui/user/views/pages/user_page.dart' as _i7;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    OnBoardingRoute.name: (routeData) {
      return _i8.AdaptivePage<void>(
          routeData: routeData, child: const _i1.OnBoardingPage());
    },
    IndexRouter.name: (routeData) {
      return _i8.AdaptivePage<void>(
          routeData: routeData, child: const _i2.IndexPage());
    },
    DetailsRouter.name: (routeData) {
      final args = routeData.argsAs<DetailsRouterArgs>();
      return _i8.AdaptivePage<void>(
          routeData: routeData,
          child: _i3.DetailsPage(
              key: args.key, device: args.device, controls: args.controls));
    },
    DashboardRouter.name: (routeData) {
      return _i8.AdaptivePage<void>(
          routeData: routeData, child: const _i4.DashboardPage());
    },
    DeviceRouter.name: (routeData) {
      return _i8.AdaptivePage<void>(
          routeData: routeData, child: const _i5.DevicesPage());
    },
    StatisticsRouter.name: (routeData) {
      return _i8.AdaptivePage<void>(
          routeData: routeData, child: const _i6.StatisticsPage());
    },
    UserRouter.name: (routeData) {
      return _i8.AdaptivePage<void>(
          routeData: routeData, child: const _i7.UserPage());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(OnBoardingRoute.name, path: '/'),
        _i8.RouteConfig(IndexRouter.name, path: '/', children: [
          _i8.RouteConfig(DashboardRouter.name,
              path: 'dashboard', parent: IndexRouter.name),
          _i8.RouteConfig(DeviceRouter.name,
              path: 'devices', parent: IndexRouter.name),
          _i8.RouteConfig(StatisticsRouter.name,
              path: 'statistics', parent: IndexRouter.name),
          _i8.RouteConfig(UserRouter.name,
              path: 'user', parent: IndexRouter.name)
        ]),
        _i8.RouteConfig(DetailsRouter.name, path: 'details')
      ];
}

/// generated route for
/// [_i1.OnBoardingPage]
class OnBoardingRoute extends _i8.PageRouteInfo<void> {
  const OnBoardingRoute() : super(OnBoardingRoute.name, path: '/');

  static const String name = 'OnBoardingRoute';
}

/// generated route for
/// [_i2.IndexPage]
class IndexRouter extends _i8.PageRouteInfo<void> {
  const IndexRouter({List<_i8.PageRouteInfo>? children})
      : super(IndexRouter.name, path: '/', initialChildren: children);

  static const String name = 'IndexRouter';
}

/// generated route for
/// [_i3.DetailsPage]
class DetailsRouter extends _i8.PageRouteInfo<DetailsRouterArgs> {
  DetailsRouter(
      {_i9.Key? key,
      required _i10.Device device,
      required List<_i11.AppControlTile> controls})
      : super(DetailsRouter.name,
            path: 'details',
            args: DetailsRouterArgs(
                key: key, device: device, controls: controls));

  static const String name = 'DetailsRouter';
}

class DetailsRouterArgs {
  const DetailsRouterArgs(
      {this.key, required this.device, required this.controls});

  final _i9.Key? key;

  final _i10.Device device;

  final List<_i11.AppControlTile> controls;

  @override
  String toString() {
    return 'DetailsRouterArgs{key: $key, device: $device, controls: $controls}';
  }
}

/// generated route for
/// [_i4.DashboardPage]
class DashboardRouter extends _i8.PageRouteInfo<void> {
  const DashboardRouter() : super(DashboardRouter.name, path: 'dashboard');

  static const String name = 'DashboardRouter';
}

/// generated route for
/// [_i5.DevicesPage]
class DeviceRouter extends _i8.PageRouteInfo<void> {
  const DeviceRouter() : super(DeviceRouter.name, path: 'devices');

  static const String name = 'DeviceRouter';
}

/// generated route for
/// [_i6.StatisticsPage]
class StatisticsRouter extends _i8.PageRouteInfo<void> {
  const StatisticsRouter() : super(StatisticsRouter.name, path: 'statistics');

  static const String name = 'StatisticsRouter';
}

/// generated route for
/// [_i7.UserPage]
class UserRouter extends _i8.PageRouteInfo<void> {
  const UserRouter() : super(UserRouter.name, path: 'user');

  static const String name = 'UserRouter';
}

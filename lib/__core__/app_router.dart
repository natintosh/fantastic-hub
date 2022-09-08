import 'package:auto_route/auto_route.dart';
import 'package:hub/__core__/components/views/pages/empty_page.dart';
import 'package:hub/views/dashboard/views/pages/dashboard_page.dart';
import 'package:hub/views/details/views/pages/details_page.dart';
import 'package:hub/views/devices/views/pages/devices_page.dart';
import 'package:hub/views/index/views/pages/index_page.dart';
import 'package:hub/views/onboarding/views/pages/on_boarding_page.dart';
import 'package:hub/views/routines/views/pages/routines_page.dart';
import 'package:hub/views/statistics/view/pages/statistics_page.dart';
import 'package:hub/views/user/views/pages/user_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(
      page: OnBoardingPage,
      initial: true,
    ),
    AutoRoute<void>(
      path: '/',
      name: 'IndexRouter',
      page: IndexPage,
      children: <AutoRoute>[
        AutoRoute<void>(
          path: 'dashboard',
          name: 'DashboardRouter',
          page: DashboardPage,
        ),
        AutoRoute<void>(
          path: 'devices',
          name: 'DeviceRouter',
          page: DevicesPage,
        ),
        AutoRoute<void>(
          path: 'statistics',
          name: 'StatisticsRouter',
          page: StatisticsPage,
        ),
        AutoRoute<void>(
          path: 'user',
          name: 'UserRouter',
          page: UserPage,
        ),
      ],
    ),
    AutoRoute<void>(
      path: 'details',
      name: 'DetailsRouter',
      page: DetailsPage,
    ),
    AutoRoute<void>(
      path: 'routines',
      name: 'RoutinesRouter',
      page: RoutinesPage,
    )
  ],
)
class $AppRouter {}

import 'package:auto_route/auto_route.dart';
import 'package:hub/__core__/views/ui/pages/empty_page.dart';
import 'package:hub/ui/dashboard/views/pages/dashboard_page.dart';
import 'package:hub/ui/details/views/pages/details_page.dart';
import 'package:hub/ui/devices/views/pages/devices_page.dart';
import 'package:hub/ui/index/views/pages/index_page.dart';
import 'package:hub/ui/onboarding/views/pages/on_boarding_page.dart';
import 'package:hub/ui/statistics/view/pages/statistics_page.dart';
import 'package:hub/ui/user/views/pages/user_page.dart';

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
    )
  ],
)
class $AppRouter {}

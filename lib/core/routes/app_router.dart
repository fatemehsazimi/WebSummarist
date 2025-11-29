import 'package:go_router/go_router.dart';
import '../../features/web_summary/presentation/pages/home_page.dart';
import '../../features/web_summary/presentation/pages/see_all_page.dart';
import '../../features/web_summary/presentation/pages/summary_result_page.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(name: 'home', path: '/', builder: (context, state) => MyHomePage()),
    GoRoute(
      name: 'seeAll',
      path: '/see-all',
      builder: (context, state) => SeeAllPage(),
    ),
    GoRoute(
      name: 'resultpage',
      path: '/result-page',
      builder: (context, state) => SummaryResultPage(),
    ),
  ],
);

GoRouter get router => _router;

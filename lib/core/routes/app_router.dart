import 'package:go_router/go_router.dart';
import '../../features/web_summary/presentation/pages/home_page.dart';
import '../../features/web_summary/presentation/pages/see_all_page.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(name: 'home', path: '/', builder: (context, state) => MyHomePage()),
    GoRoute(
      name: 'seeAll',
      path: '/see-all',
      builder: (context, state) => SeeAllPage(),
    ),
  ],
);

GoRouter get router => _router;

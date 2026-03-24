import 'package:go_router/go_router.dart';
import 'package:focusify_app/shared/widgets/layout/app_scaffold.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const AppScaffold()),
    ],
  );
}

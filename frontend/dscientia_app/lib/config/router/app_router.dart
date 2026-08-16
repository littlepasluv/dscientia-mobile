import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai_insight/presentation/navigation/ai_insight_result_route_data.dart';
import '../../features/ai_insight/presentation/screens/ai_insight_result_screen.dart';
import '../../features/authentication/presentation/providers/authentication_notifier.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/reports/domain/entities/community_risk_report_draft.dart';
import '../../features/reports/presentation/screens/community_risk_report_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  GoRouter.optionURLReflectsImperativeAPIs = true;

  final router = GoRouter(
    initialLocation: '/demo',
    redirect: (context, state) {
      final authState = ref.read(authenticationNotifierProvider);
      final location = state.uri.path;

      final isAuthRoute = location == '/login' || location == '/register';

      final isPublicDemoRoute =
          location == '/demo' ||
          location == '/reports/new' ||
          location == '/ai-insights/demo' ||
          location == '/ai-insights/result';

      final isAuthenticated = authState.isAuthenticated;

      if (authState.isUnauthenticated && !isAuthRoute && !isPublicDemoRoute) {
        return '/login';
      }

      if (isAuthenticated && isAuthRoute) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const DashboardScreen.authenticated(),
      ),
      GoRoute(
        path: '/demo',
        name: 'demo',
        builder: (context, state) => const DashboardScreen.demo(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/reports/new',
        name: 'create-risk-report',
        builder: (context, state) => const CommunityRiskReportScreen(),
      ),
      GoRoute(
        path: '/ai-insights/demo',
        name: 'ai-insight-demo',
        builder: (context, state) {
          return const AiInsightResultScreen(
            report: CommunityRiskReportDraft.demo(),
          );
        },
      ),
      GoRoute(
        path: '/ai-insights/result',
        name: 'ai-insight-result',
        builder: (context, state) {
          final extra = state.extra;

          if (extra is AiInsightResultRouteData) {
            return AiInsightResultScreen(
              report: extra.report,
              backendInsight: extra.backendInsight,
            );
          }

          return AiInsightResultScreen(
            report: extra is CommunityRiskReportDraft
                ? extra
                : const CommunityRiskReportDraft.demo(),
          );
        },
      ),
    ],
  );

  ref.listen(authenticationNotifierProvider, (previous, next) {
    router.refresh();
  });

  ref.onDispose(router.dispose);

  return router;
});

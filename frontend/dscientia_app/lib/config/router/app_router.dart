import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/authentication/presentation/providers/authentication_notifier.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/reports/presentation/screens/community_risk_report_screen.dart';
import '../../features/ai_insight/presentation/screens/ai_insight_result_screen.dart';
import '../../features/reports/domain/entities/community_risk_report_draft.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authenticationNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final location = state.uri.path;
      final isAuthRoute = location == '/login' || location == '/register';
      final isAuthenticated = authState.isAuthenticated;

      if (!isAuthenticated && !isAuthRoute) {
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
        builder: (context, state) => const DashboardScreen(),
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
        path: '/ai-insights/result',
        name: 'ai-insight-result',
        builder: (context, state) {
          final report = state.extra;

          return AiInsightResultScreen(
            report: report is CommunityRiskReportDraft
                ? report
                : const CommunityRiskReportDraft.demo(),
          );
        },
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
    ],
  );
});

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homepage_ui/pages/chat/hp_chat_page.dart';
import 'package:homepage_ui/pages/legal/hp_legal_imprint_page.dart';
import 'package:homepage_ui/pages/legal/hp_legal_privacy_policy_page.dart';
import 'package:homepage_ui/pages/main/hp_main_page.dart';
import 'package:homepage_ui/pages/profile/hp_profile_page.dart';
import 'package:homepage_ui/pages/projects/hp_projects_page.dart';

class HpRouter {
  static final GoRouter _router = GoRouter(initialLocation: HpRoute.main.route, routes: _getRoutes());

  static void push(HpRoute route, {Map<String, String> parameters = const {}}) {
    final targetLocation = _router.namedLocation(route.route, pathParameters: parameters);
    if (_router.state.matchedLocation != targetLocation) {
      _router.pushNamed(route.route, pathParameters: parameters);
    }
  }

  static void pop({HpRoute? defaultRoute, Map<String, String> defaultRouteParameters = const {}}) {
    _router.canPop()
        ? _router.pop()
        : _router.goNamed(defaultRoute?.route ?? HpRoute.main.route, pathParameters: defaultRouteParameters);
  }

  static List<RouteBase> _getRoutes() {
    return [
      _getRoute(HpRoute.main, (_) => const HpMainPage()),
      _getRoute(HpRoute.chat, (_) => const HpChatPage()),
      _getRoute(HpRoute.legalImprint, (_) => const HpLegalImprintPage()),
      _getRoute(HpRoute.legalPrivacyPolicy, (_) => const HpLegalPrivacyPolicyPage()),
      _getRoute(HpRoute.profile, (_) => const HpProfilePage()),
      _getRoute(HpRoute.projects, (_) => const HpProjectsPage()),
    ];
  }

  static GoRoute _getRoute(HpRoute route, Widget Function(Map<String, String>) builder) {
    return GoRoute(
      path: route.route,
      name: route.route,
      pageBuilder: (c, s) => NoTransitionPage(child: builder.call(s.pathParameters)),
    );
  }

  static GoRouter get router => _router;
}

enum HpRoute {
  main("/"),
  chat("/chat"),
  legalImprint("/legal/imprint"),
  legalPrivacyPolicy("/legal/privacy-policy"),
  profile("/profile"),
  projects("/projects");

  const HpRoute(this.route);

  final String route;
}

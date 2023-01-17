import 'package:flutter/material.dart';
import 'package:navitator_experiments/navigation/app_route_configuration.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRouteConfiguration> {
  @override
  Future<AppRouteConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/404');
    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return AppRouteConfiguration.home();
    }

    // Handle '/book/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') return AppRouteConfiguration.unknown();
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) return AppRouteConfiguration.unknown();
      return AppRouteConfiguration.details(id);
    }

    // Handle unknown routes
    return AppRouteConfiguration.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(AppRouteConfiguration configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/404');
    }
    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    }
    if (configuration.isDetailsPage) {
      return RouteInformation(location: '/book/${configuration.id}');
    }
    return const RouteInformation(location: '/404');
  }
}

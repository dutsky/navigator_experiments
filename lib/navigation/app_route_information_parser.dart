import 'package:flutter/material.dart';
import 'package:navitator_experiments/navigation/app_route_configuration.dart';

/// Парсер роутов. Отвечает за конверсию строковых путей в объекты приложения и наоборот
class AppRouteInformationParser extends RouteInformationParser<AppRouteConfiguration> {
  @override
  Future<AppRouteConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/404');
    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return AppRouteConfiguration.home();
    }

    // Handle '/artist/:artistId'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'artist') return AppRouteConfiguration.unknown();
      final id = int.tryParse(uri.pathSegments[1]);
      if (id == null) return AppRouteConfiguration.unknown();
      return AppRouteConfiguration.artist(id);
    }

    // Handle '/artist/:artistId/:trackId'
    if (uri.pathSegments.length == 3) {
      if (uri.pathSegments[0] != 'artist') return AppRouteConfiguration.unknown();
      final artistId = int.tryParse(uri.pathSegments[1]);
      final trackId = int.tryParse(uri.pathSegments[2]);
      if (artistId == null || trackId == null) return AppRouteConfiguration.unknown();
      return AppRouteConfiguration.track(artistId, trackId);
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
    if (configuration.isArtistPage) {
      return RouteInformation(location: '/artist/${configuration.artistId}');
    }
    if (configuration.isTrackPage) {
      return RouteInformation(
          location: '/artist/${configuration.artistId}/${configuration.trackId}');
    }
    return const RouteInformation(location: '/404');
  }
}

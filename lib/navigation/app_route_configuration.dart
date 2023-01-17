/// Конфигурация роута -- представление пути в виде объектов приложения.
class AppRouteConfiguration {
  final int? artistId;
  final int? trackId;
  final bool isUnknown;

  AppRouteConfiguration.home()
      : artistId = null,
        trackId = null,
        isUnknown = false;

  AppRouteConfiguration.artist(this.artistId)
      : trackId = null,
        isUnknown = false;

  AppRouteConfiguration.track(this.artistId, this.trackId) : isUnknown = false;

  AppRouteConfiguration.unknown()
      : artistId = null,
        trackId = null,
        isUnknown = true;

  bool get isHomePage => (artistId == null) && (trackId == null);

  bool get isArtistPage => artistId != null && (trackId == null);

  bool get isTrackPage => (artistId != null) && (trackId != null);
}

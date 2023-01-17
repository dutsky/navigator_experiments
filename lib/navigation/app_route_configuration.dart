class AppRouteConfiguration {
  final int? id;
  final bool isUnknown;

  AppRouteConfiguration.home()
      : id = null,
        isUnknown = false;

  AppRouteConfiguration.details(this.id) : isUnknown = false;

  AppRouteConfiguration.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}

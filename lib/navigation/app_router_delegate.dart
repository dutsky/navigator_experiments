import 'package:flutter/material.dart';
import 'package:navitator_experiments/data/artist.dart';
import 'package:navitator_experiments/data/artists.dart';
import 'package:navitator_experiments/data/track.dart';
import 'package:navitator_experiments/navigation/app_route_configuration.dart';
import 'package:navitator_experiments/screens/artist_details_screen.dart';
import 'package:navitator_experiments/screens/artist_list_screen.dart';
import 'package:navitator_experiments/screens/page_not_found_screen.dart';
import 'package:navitator_experiments/screens/track_details_screen.dart';

class AppRouterDelegate extends RouterDelegate<AppRouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouteConfiguration> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Artist? _selectedArtist;
  Track? _selectedTrack;
  bool show404 = false;

  @override
  AppRouteConfiguration get currentConfiguration {
    if (show404) {
      return AppRouteConfiguration.unknown();
    }
    if (_selectedArtist == null) {
      return AppRouteConfiguration.home();
    } else if (_selectedTrack != null) {
      final artistId = artists.indexOf(_selectedArtist!);
      final trackId = _selectedArtist?.tracks.indexOf(_selectedTrack!);
      return AppRouteConfiguration.track(artistId, trackId);
    } else {
      return AppRouteConfiguration.artist(artists.indexOf(_selectedArtist!));
    }
  }

  @override
  Future<void> setNewRoutePath(AppRouteConfiguration configuration) async {
    if (configuration.isUnknown) {
      _selectedArtist = null;
      show404 = true;
      return;
    }

    if (configuration.isArtistPage) {
      if (configuration.artistId == null) return;
      if (configuration.artistId! < 0 || configuration.artistId! > artists.length - 1) {
        show404 = true;
        return;
      }
      _selectedArtist = artists[configuration.artistId!];
    }

    if (configuration.isTrackPage) {
      if (configuration.trackId == null) return;
      if (_selectedArtist == null) return;
      if (configuration.trackId! < 0 ||
          configuration.trackId! > _selectedArtist!.tracks.length - 1) {
        show404 = true;
        return;
      }
      _selectedTrack = artists[configuration.artistId!].tracks[configuration.trackId!];
    } else {
      _selectedArtist = null;
    }

    show404 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: ArtistListScreen(
            artists: artists,
            onTapped: _onArtistTapped,
          ),
        ),
        if (show404)
          const MaterialPage(child: PageNotFoundScreen())
        else if (_selectedArtist != null)
          if (_selectedTrack != null)
            MaterialPage(child: TrackDetailsScreen(track: _selectedTrack!))
          else
            MaterialPage(
                child: ArtistDetailsScreen(
              artist: _selectedArtist!,
              onTapped: _onTrackTapped,
            ))
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _selectedArtist = null;
        _selectedTrack = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  void _onArtistTapped(Artist artist) {
    _selectedArtist = artist;
    notifyListeners();
  }

  void _onTrackTapped(Track track) {
    _selectedTrack = track;
    notifyListeners();
  }
}

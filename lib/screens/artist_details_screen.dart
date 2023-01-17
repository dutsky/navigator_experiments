import 'package:flutter/material.dart';
import 'package:navigator_experiments/data/artist.dart';
import 'package:navigator_experiments/data/track.dart';

class ArtistDetailsScreen extends StatelessWidget {
  final Artist artist;
  final ValueChanged<Track> onTapped;

  const ArtistDetailsScreen({
    required this.artist,
    required this.onTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Информация об исполнителе: ${artist.name}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Text(artist.name, style: Theme.of(context).textTheme.headline6)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: artist.tracks.length,
                  (context, index) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        title: Text(artist.tracks[index].title),
                        onTap: () => onTapped(artist.tracks[index]),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

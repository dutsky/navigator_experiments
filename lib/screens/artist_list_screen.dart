import 'package:flutter/material.dart';
import 'package:navitator_experiments/data/artist.dart';

class ArtistListScreen extends StatelessWidget {
  final List<Artist> artists;
  final ValueChanged<Artist> onTapped;

  const ArtistListScreen({
    required this.artists,
    required this.onTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список музыкальных групп')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: artists.length,
            itemBuilder: ((context, index) => ListTile(
                  title: Text(artists[index].name),
                  onTap: () => onTapped(artists[index]),
                )),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:navigator_experiments/data/track.dart';

class TrackDetailsScreen extends StatelessWidget {
  final Track track;

  const TrackDetailsScreen({required this.track, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Информация о треке: ${track.title}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Название трека: '),
                  Text(track.title),
                ],
              ),
              Row(
                children: [
                  const Text('Название альбома: '),
                  Text(track.album),
                ],
              ),
              if (track.lyrics != null)
                Column(
                  children: [
                    const Text('Текст: '),
                    Text(track.lyrics!),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

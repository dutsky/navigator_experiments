import 'package:navigator_experiments/data/artist.dart';
import 'package:navigator_experiments/data/track.dart';

const List<Artist> artists = [
  Artist(
    name: 'Iron Maiden',
    tracks: [
      Track(
        title: 'The Trooper',
        album: 'Piece of Mind',
      ),
      Track(
        title: 'Ace of Spades',
        album: 'Powerslave',
      ),
      Track(
        title: 'Hallowed Be Thy Name',
        album: 'The Number of the Beast',
      )
    ],
  ),
  Artist(
    name: 'Metallica',
    tracks: [
      Track(
        title: 'Master of Puppets',
        album: 'Master of Puppets',
        lyrics: "Master of puppets, I'm pulling your strings"
            "Twisting your mind and smashing your dreams",
      )
    ],
  ),
  Artist(
    name: 'Mastodon',
    tracks: [
      Track(
        title: 'Blood and Thunder',
        album: 'Leviathan',
      ),
    ],
  ),
];

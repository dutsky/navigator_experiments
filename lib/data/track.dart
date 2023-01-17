class Track {
  final String title;
  final String album;
  final String? lyrics;

  const Track({
    required this.title,
    required this.album,
    this.lyrics,
  });
}

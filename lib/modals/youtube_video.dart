class YoutubeVideo {
  final String id;
  final String title;
  final String thumbnailUrl;

  YoutubeVideo(
      {required this.id, required this.title, required this.thumbnailUrl});

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
    );
  }
}

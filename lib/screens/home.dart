import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vidflow/constants/colors.dart';
import 'package:vidflow/modals/youtube_video.dart';
import 'package:vidflow/screens/searchscreen.dart';
import 'package:vidflow/screens/downloads.dart';
import 'package:vidflow/widget/drawer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late YoutubePlayerController _controller;
  List<YoutubeVideo> _videos = [];
  bool _isLoading = true;
  int _downloadsCount = 0;
  final Map<String, double> _downloadProgress = {};

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '', // Add your default video ID here
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    _fetchRecommendedVideos();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchRecommendedVideos() async {
    const apiKey =
        'AIzaSyD7gHrbZF5agBvjlH0W4COTFUm3mYwFr7I'; // this is the YouTube apiKey AIzaSyD7gHrbZF5agBvjlH0W4COTFUm3mYwFr7I
    const url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=10&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _videos = (data['items'] as List)
              .map((item) => YoutubeVideo.fromJson(item))
              .toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  void _navigateToVideo(String videoId) {
    _controller.load(videoId);
    _controller.play();
  }

  Future<void> _downloadVideo(String videoId) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = await getApplicationDocumentsDirectory();
      final downloadDir = Directory('${directory.path}/Downloads');
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }
      final taskId = await FlutterDownloader.enqueue(
        url: 'https://www.youtube.com/watch?v=$videoId',
        savedDir: downloadDir.path,
        fileName: '$videoId.mp4',
        showNotification: true,
        openFileFromNotification: true,
      );
      setState(() {
        _downloadsCount++;
        _downloadProgress[taskId!] = 0.0;
      });
    } else {
      // Handle permission denied
    }
  }

  static void downloadCallback(String id, int status, int progress) {
    const taskStatus = DownloadTaskStatus;
    print(
        'Download task ($id) is in status ($taskStatus) and progress ($progress)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: white,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(30)),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: black,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Search or Enter URL ...",
                        style: TextStyle(
                            fontSize: 14,
                            color: grey1,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Downloads(),
                      ),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_down_to_line,
                    size: 30,
                    color: white,
                  ),
                ),
                if (_downloadsCount > 0)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '$_downloadsCount',
                        style: const TextStyle(color: white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchRecommendedVideos,
              child: Column(
                children: [
                  if (_controller.initialVideoId.isNotEmpty)
                    YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        // Perform additional actions if needed when the player is ready
                      },
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _videos.length,
                      itemBuilder: (context, index) {
                        final video = _videos[index];
                        return ListTile(
                          leading: Image.network(video.thumbnailUrl),
                          title: Text(video.title),
                          onTap: () => _navigateToVideo(video.id),
                          trailing: IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () => _downloadVideo(video.id),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

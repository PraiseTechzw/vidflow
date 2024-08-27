import 'package:flutter/material.dart';
import 'package:vidflow/constants/colors.dart';
import 'package:vidflow/services/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];
  late YoutubePlayerController _controller;
  int _downloadsCount = 0;

  void performSearch(String query) async {
    final results = await YouTubeService().searchVideos(query);
    setState(() {
      searchResults = results;
    });
  }

  void _downloadVideo(String videoId) {
    setState(() {
      _downloadsCount++;
    });
    // Implement the download functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: searchController,
            onSubmitted: performSearch,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: black,
                size: 20,
              ),
              hintText: "Search or Url....",
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: grey, fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
      body: searchResults.isEmpty
          ? const Center(
              child: Text(
                "No results found",
                style: TextStyle(fontSize: 18, color: grey1),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final video = searchResults[index];
                final videoId = video['id']['videoId'];
                final title = video['snippet']['title'];
                final thumbnailUrl =
                    video['snippet']['thumbnails']['default']['url'];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Image.network(thumbnailUrl),
                    title: Text(title),
                    onTap: () {
                      _controller = YoutubePlayerController(
                        initialVideoId: videoId,
                        flags: const YoutubePlayerFlags(
                          autoPlay: true,
                          mute: false,
                        ),
                      );

                      showDialog(
                        context: context,
                        builder: (context) => YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () => _downloadVideo(videoId),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              // Add action for the floating button if needed
            },
            child: const Icon(Icons.search),
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
    );
  }
}

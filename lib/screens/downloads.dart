import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:vidflow/constants/colors.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  List<DownloadTask> _tasks = [];
  final _downloadProgress = <String, double>{};

  @override
  void initState() {
    super.initState();
    _loadDownloadTasks();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<void> _loadDownloadTasks() async {
    final tasks = await FlutterDownloader.loadTasks();
    setState(() {
      _tasks = tasks ?? [];
      for (var task in _tasks) {
        _downloadProgress[task.taskId] = (task.progress / 100);
      }
    });
  }

  static void downloadCallback(String id, int status, int progress) {
    final taskStatus = DownloadTaskStatus.values[status];
    // Update the download progress
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Downloads",
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: Image.network(
                "https://img.youtube.com/vi/${task.filename!.split('.mp4').first}/maxresdefault.jpg",
                width: 100,
                fit: BoxFit.cover,
              ),
              title: Text(
                task.filename!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.status == DownloadTaskStatus.complete
                        ? "Downloaded"
                        : "Downloading",
                    style: const TextStyle(color: grey, fontSize: 12),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: _downloadProgress[task.taskId],
                          backgroundColor: Colors.grey.shade300,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${task.progress}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  task.status == DownloadTaskStatus.running
                      ? Icons.pause
                      : Icons.download,
                ),
                onPressed: () {
                  // Add pause/resume functionality if needed
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
